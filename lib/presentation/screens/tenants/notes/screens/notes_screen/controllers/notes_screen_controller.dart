import 'dart:async';

import 'package:belluga_boilerplate/domain/learning_experience/course_base_model.dart';
import 'package:belluga_boilerplate/domain/learning_experience/course_item_model.dart';
import 'package:belluga_boilerplate/domain/notes/note_model.dart';
import 'package:belluga_boilerplate/domain/notes/projections/notes_filter_level_projection.dart';
import 'package:belluga_boilerplate/domain/notes/projections/notes_section_projection.dart';
import 'package:belluga_boilerplate/domain/repositories/learning_experience_repository_contract.dart';
import 'package:belluga_boilerplate/domain/repositories/notes_repository_contract.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value.dart';

class NotesScreenController implements Disposable {
  NotesScreenController();

  final _learningRepository =
      GetIt.I.get<LearningExperienceRepositoryContract>();
  final _notesRepository = GetIt.I.get<NotesRepositoryContract>();

  final coursesStreamValue = StreamValue<List<CourseBaseModel>>(
    defaultValue: const [],
  );
  final filteredCoursesStreamValue = StreamValue<List<CourseBaseModel>>(
    defaultValue: const [],
  );
  final selectedCourseIdStreamValue = StreamValue<String?>(defaultValue: null);
  final filterLevelsStreamValue =
      StreamValue<List<NotesFilterLevelProjection>>(defaultValue: const []);
  final sectionsStreamValue =
      StreamValue<List<NotesSectionProjection>>(defaultValue: const []);
  final isLoadingStreamValue = StreamValue<bool>(defaultValue: true);

  StreamSubscription<List<CourseBaseModel>?>? _coursesSubscription;
  final Map<String, CourseItemModel> _courseDetails = {};
  final Map<String, Future<CourseItemModel>> _detailsLoaders = {};
  final Map<String, List<NoteModel>> _notesByCourse = {};
  bool _notesIndexLoaded = false;
  final Map<String, int> _nodeOrderIndex = {};
  final Map<String, bool> _subtreeHasNotesCache = {};
  final List<_FilterLevelState> _filterLevels = [];
  final Map<String, List<int>> _orderKeyCache = {};
  int _refreshToken = 0;

  Future<void> init() async {
    _coursesSubscription =
        _learningRepository.myCoursesListStreamValue.stream.listen(
      _handleCourseUpdate,
    );
    await _learningRepository.ensureMyCoursesSummary();
    final courses = _learningRepository.myCoursesListStreamValue.value;
    if (courses != null) {
      _handleCourseUpdate(courses);
    } else {
      isLoadingStreamValue.addValue(false);
    }
  }

  void _handleCourseUpdate(List<CourseBaseModel>? courses) {
    if (courses == null) {
      return;
    }
    coursesStreamValue.addValue(courses);
    for (var i = 0; i < courses.length; i++) {
      _nodeOrderIndex[courses[i].id.value] = i;
    }
    _updateCoursesWithNotes();
    if (selectedCourseIdStreamValue.value == null) {
      _refreshNotes();
    }
  }

  void selectCourse(String? courseId) {
    if (selectedCourseIdStreamValue.value == courseId) {
      return;
    }
    selectedCourseIdStreamValue.addValue(courseId);
    _filterLevels.clear();
    filterLevelsStreamValue.addValue(const []);
    if (courseId != null) {
      _buildLevelForParent(courseId, 0);
    }
    _refreshNotes();
  }

  Future<void> selectLevelOption(int levelIndex, String? courseItemId) async {
    if (levelIndex >= _filterLevels.length) {
      return;
    }
    final level = _filterLevels[levelIndex];
    CourseBaseModel? selectedModel;
    if (courseItemId != null) {
      try {
        selectedModel = level.options
            .firstWhere((option) => option.id.value == courseItemId);
      } catch (_) {
        throw Exception('Filter option missing for node $courseItemId');
      }
    }

    level.selected = selectedModel;
    _filterLevels.removeRange(levelIndex + 1, _filterLevels.length);
    _emitFilterLevels();
    if (selectedModel != null) {
      await _buildLevelForParent(
        selectedModel.id.value,
        levelIndex + 1,
      );
    }
    _refreshNotes();
  }

  void clearFilters() {
    selectedCourseIdStreamValue.addValue(null);
    _filterLevels.clear();
    filterLevelsStreamValue.addValue(const []);
    _refreshNotes();
  }

  Future<void> refreshNode(String nodeId) async {
    _notesByCourse.remove(nodeId);
    _subtreeHasNotesCache.clear();
    _notesIndexLoaded = false;
    await _refreshNotes();
  }

  Future<CourseItemModel> loadCourseItem(String courseItemId) {
    return _ensureCourseDetails(courseItemId);
  }

  Future<void> _buildLevelForParent(
    String parentId,
    int levelIndex,
  ) async {
    await _ensureNotesIndex();
    final children = await _loadChildren(parentId);
    final filtered = <CourseBaseModel>[];
    for (final child in children) {
      if (await _hasNotesInSubtree(child.id.value)) {
        filtered.add(child);
      }
    }
    if (filtered.isEmpty) {
      return;
    }

    final label = _labelForLevel(levelIndex);
    _filterLevels.add(
      _FilterLevelState(
        label: label,
        parentId: parentId,
        options: filtered,
      ),
    );
    _emitFilterLevels();
  }

  String _labelForLevel(int levelIndex) {
    const labels = ['Módulo', 'Seção', 'Aula', 'Conteúdo'];
    if (levelIndex < labels.length) {
      return labels[levelIndex];
    }
    return 'Nível ${levelIndex + 1}';
  }

  void _emitFilterLevels() {
    final viewModels = _filterLevels
        .map(
          (level) => NotesFilterLevelProjection(
            label: level.label,
            options: level.options,
            selected: level.selected,
          ),
        )
        .toList();
    filterLevelsStreamValue.addValue(viewModels);
  }

  Future<List<CourseBaseModel>> _loadChildren(String parentId) async {
    final details = await _ensureCourseDetails(parentId);
    final children = details.childrens;
    for (var i = 0; i < children.length; i++) {
      _nodeOrderIndex[children[i].id.value] = i;
    }
    return children;
  }

  Future<CourseItemModel> _ensureCourseDetails(String courseItemId) {
    final cached = _courseDetails[courseItemId];
    if (cached != null) {
      return Future.value(cached);
    }

    final pending = _detailsLoaders[courseItemId];
    if (pending != null) {
      return pending;
    }

    final loader = _learningRepository
        .loadCourseDetails(courseItemId)
        .then((details) {
      _courseDetails[courseItemId] = details;
      _detailsLoaders.remove(courseItemId);
      return details;
    });

    _detailsLoaders[courseItemId] = loader;
    return loader;
  }

  String? _selectedDeepestNodeId() {
    for (final level in _filterLevels.reversed) {
      final selected = level.selected;
      if (selected != null) {
        return selected.id.value;
      }
    }
    return null;
  }

  Future<void> _refreshNotes() async {
    final token = ++_refreshToken;
    isLoadingStreamValue.addValue(true);
    sectionsStreamValue.addValue(const []);
    final targetNodeIds = await _resolveTargetNodeIds();

    if (targetNodeIds.isEmpty) {
      if (_refreshToken == token) {
        isLoadingStreamValue.addValue(false);
      }
      return;
    }

    final sections = <NotesSectionProjection>[];

    for (final nodeId in targetNodeIds) {
      final section = await _buildSectionForNode(nodeId);
      if (_refreshToken != token) {
        return;
      }
      if (section != null) {
        sections.add(section);
        sections.sort(_compareSections);
        sectionsStreamValue.addValue(List.unmodifiable(sections));
        if (isLoadingStreamValue.value == true) {
          isLoadingStreamValue.addValue(false);
        }
      }
    }

    if (isLoadingStreamValue.value == true) {
      isLoadingStreamValue.addValue(false);
    }
  }

  int _compareSections(
    NotesSectionProjection a,
    NotesSectionProjection b,
  ) {
    final maxLength = a.orderKey.length > b.orderKey.length
        ? a.orderKey.length
        : b.orderKey.length;
    for (var i = 0; i < maxLength; i++) {
      final aValue = i < a.orderKey.length ? a.orderKey[i] : -1;
      final bValue = i < b.orderKey.length ? b.orderKey[i] : -1;
      final comparison = aValue.compareTo(bValue);
      if (comparison != 0) {
        return comparison;
      }
    }
    return 0;
  }

  Future<List<String>> _resolveTargetNodeIds() async {
    await _ensureNotesIndex();
    if (_notesByCourse.isEmpty) {
      return const [];
    }
    final courses = coursesStreamValue.value;
    if (courses.isEmpty) {
      return _notesByCourse.keys.toList();
    }

    final selectedCourseId = selectedCourseIdStreamValue.value;
    if (selectedCourseId == null) {
      return _notesByCourse.keys.toList();
    }

    final deepestNode = _selectedDeepestNodeId();
    if (deepestNode != null) {
      return _filterNodesByAncestor(deepestNode);
    }

    return _filterNodesByAncestor(selectedCourseId);
  }

  Future<List<String>> _filterNodesByAncestor(String ancestorId) async {
    final result = <String>[];
    for (final nodeId in _notesByCourse.keys) {
      if (await _isDescendantOf(nodeId, ancestorId)) {
        result.add(nodeId);
      }
    }
    return result;
  }

  Future<bool> _isDescendantOf(String nodeId, String ancestorId) async {
    if (nodeId == ancestorId) {
      return true;
    }
    String? currentId = nodeId;
    while (currentId != null) {
      final details = await _ensureCourseDetails(currentId);
      final parentId = details.parent?.id.value;
      if (parentId == null) {
        return false;
      }
      if (parentId == ancestorId) {
        return true;
      }
      currentId = parentId;
    }
    return false;
  }

  Future<NotesSectionProjection?> _buildSectionForNode(String nodeId) async {
    try {
      final notes = _notesByCourse[nodeId];
      if (notes == null || notes.isEmpty) {
        return null;
      }
      final breadcrumb = await _buildBreadcrumb(nodeId);
      return NotesSectionProjection(
        nodeId: nodeId,
        title: breadcrumb.trailingTitle,
        subtitle: breadcrumb.pathLeadingText,
        notes: notes,
        orderKey: breadcrumb.orderKey,
        courseTitle: breadcrumb.courseTitle,
      );
    } catch (error) {
      debugPrint(
        'NotesScreenController: failed to build section $nodeId: $error',
      );
      return null;
    }
  }

  Future<_BreadcrumbMetadata> _buildBreadcrumb(String nodeId) async {
    final segments = <_BreadcrumbSegment>[];
    String? currentId = nodeId;

    while (currentId != null) {
      final details = await _ensureCourseDetails(currentId);
      segments.add(
        _BreadcrumbSegment(
          id: details.id.value,
          title: details.title.value,
        ),
      );
      currentId = details.parent?.id.value;
    }

    final orderedSegments = segments.reversed.toList();
    final orderKey = <int>[];
    for (var i = 0; i < orderedSegments.length; i++) {
      final segment = orderedSegments[i];
      final order = _nodeOrderIndex.putIfAbsent(
        segment.id,
        () => i,
      );
      orderKey.add(order);
    }
    _orderKeyCache[nodeId] = orderKey;

    final leading =
        orderedSegments.length > 1 ? orderedSegments.take(orderedSegments.length - 1).map((segment) => segment.title).join(' • ') : null;
    final trailing = orderedSegments.isNotEmpty
        ? orderedSegments.last.title
        : 'Anotações';
    final courseTitle = orderedSegments.isNotEmpty
        ? orderedSegments.first.title
        : 'Curso';

    return _BreadcrumbMetadata(
      orderKey: orderKey,
      pathLeadingText: leading,
      trailingTitle: trailing,
      courseTitle: courseTitle,
    );
  }

  @override
  FutureOr onDispose() {
    _coursesSubscription?.cancel();
    coursesStreamValue.dispose();
    filteredCoursesStreamValue.dispose();
    selectedCourseIdStreamValue.dispose();
    filterLevelsStreamValue.dispose();
    sectionsStreamValue.dispose();
    isLoadingStreamValue.dispose();
  }

  Future<void> _ensureNotesIndex() async {
    if (_notesIndexLoaded) {
      return;
    }
    final notesMap = await _notesRepository.loadNotesByCourse();
    _notesByCourse
      ..clear()
      ..addAll(notesMap);
    _notesIndexLoaded = true;
    _subtreeHasNotesCache.clear();
    _orderKeyCache.clear();
    _updateCoursesWithNotes();
  }

  Future<bool> _hasNotesInSubtree(String nodeId) async {
    await _ensureNotesIndex();
    if (_subtreeHasNotesCache.containsKey(nodeId)) {
      return _subtreeHasNotesCache[nodeId]!;
    }
    if (_notesByCourse.containsKey(nodeId)) {
      _subtreeHasNotesCache[nodeId] = true;
      return true;
    }
    final children = await _loadChildren(nodeId);
    for (final child in children) {
      if (await _hasNotesInSubtree(child.id.value)) {
        _subtreeHasNotesCache[nodeId] = true;
        return true;
      }
    }
    _subtreeHasNotesCache[nodeId] = false;
    return false;
  }

  Future<void> _updateCoursesWithNotes() async {
    final courses = coursesStreamValue.value;
    if (courses.isEmpty) {
      filteredCoursesStreamValue.addValue(const []);
      return;
    }
    await _ensureNotesIndex();
    final filtered = <CourseBaseModel>[];
    for (final course in courses) {
      if (await _hasNotesInSubtree(course.id.value)) {
        filtered.add(course);
      }
    }
    filteredCoursesStreamValue.addValue(filtered);
  }
}

class _FilterLevelState {
  _FilterLevelState({
    required this.label,
    required this.parentId,
    required this.options,
  });

  final String parentId;
  final String label;
  final List<CourseBaseModel> options;
  CourseBaseModel? selected;
}

class _BreadcrumbSegment {
  _BreadcrumbSegment({
    required this.id,
    required this.title,
  });

  final String id;
  final String title;
}

class _BreadcrumbMetadata {
  _BreadcrumbMetadata({
    required this.orderKey,
    required this.trailingTitle,
    this.pathLeadingText,
    required this.courseTitle,
  });

  final List<int> orderKey;
  final String trailingTitle;
  final String? pathLeadingText;
  final String courseTitle;
}
