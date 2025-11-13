import 'dart:async';

import 'package:flutter/material.dart';
import 'package:belluga_boilerplate/domain/learning_experience/course_category_model.dart';
import 'package:belluga_boilerplate/domain/learning_experience/course_base_model.dart';
import 'package:belluga_boilerplate/domain/repositories/learning_experience_repository_contract.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value.dart';

class FastTracksListScreenController implements Disposable {
  FastTracksListScreenController() {
    filteredCoursesStreamValue = StreamValue<List<CourseBaseModel>?>(
      defaultValue: _courseStreamValue.value,
    );

    _courseStreamValue.stream.listen(listenCoursesList);
    selectedCategoriesStreamValue.stream.listen(listenCategoriesList);
  }

  Future<void> init() async {
    getFastTracksCategories();
    getlastCreatedFastTracks();
    getFastTracksList();
  }

  final _learningRepository =
      GetIt.I.get<LearningExperienceRepositoryContract>();

  final scrollController = ScrollController();

  StreamValue<List<CourseBaseModel>?> get _courseStreamValue =>
      _learningRepository.fastTracksListStreamValue;

  StreamValue<List<CourseCategoryModel>?> get categoriesStreamValue =>
      _learningRepository.fastTracksCategoriesStreamValue;

  StreamValue<List<CourseBaseModel>?> get lastCreatedFastTracksStreamValue =>
      _learningRepository.lastCreatedFastTracksStreamValue;

  late StreamValue<List<CourseBaseModel>?> filteredCoursesStreamValue;

  final selectedCategoriesStreamValue =
      StreamValue<List<CourseCategoryModel>?>();

  Future<void> getFastTracksList() async {
    await _learningRepository.ensureFastTracksCatalog();
  }

  Future<void> getFastTracksCategories() async {
    await _learningRepository.ensureFastTrackCategories();
  }

  Future<void> getlastCreatedFastTracks() async {
    await _learningRepository.ensureFastTrackHighlights();
  }

  Future<void> filterByCategory(CourseCategoryModel category) async {
    final _selectedCategories = selectedCategoriesStreamValue.value ?? [];
    if (_selectedCategories.contains(category)) {
      // If the category is already selected, remove it
      _selectedCategories.remove(category);
    } else {
      // If the category is not selected, add it
      _selectedCategories.add(category);
    }

    selectedCategoriesStreamValue.addValue(_selectedCategories);
  }

  void listenCategoriesList(List<CourseCategoryModel>? categories) {
    final _allCourses = _courseStreamValue.value ?? [];
    final _categoriesSelected = categories;

    if (_categoriesSelected == null || _categoriesSelected.isEmpty) {
      filteredCoursesStreamValue.addValue(_allCourses);
      return;
    }

    final filtered = _allCourses.where((course) {
      return _categoriesSelected.any(
        (category) =>
            course.categories?.any(
              (courseCategory) => courseCategory.id == category.id,
            ) ??
            false,
      );
    }).toList();

    filteredCoursesStreamValue.addValue(filtered);
  }

  void listenCoursesList(List<CourseBaseModel>? courses) {
    filteredCoursesStreamValue.addValue(courses);
  }

  Future<void> scrollToTop() async {
    if (scrollController.hasClients) {
      await scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  FutureOr onDispose() {
    //
  }
}
