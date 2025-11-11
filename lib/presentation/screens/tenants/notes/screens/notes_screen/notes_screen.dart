import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/domain/learning_experience/course_base_model.dart';
import 'package:belluga_boilerplate/domain/notes/note_model.dart';
import 'package:belluga_boilerplate/domain/notes/projections/notes_filter_level_projection.dart';
import 'package:belluga_boilerplate/domain/notes/projections/notes_section_projection.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/notes/screens/notes_screen/controllers/notes_screen_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/notes/screens/notes_screen/widgets/note_playback_bottom_sheet.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/notes/screens/notes_screen/widgets/notes_empty_state.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/notes/screens/notes_screen/widgets/notes_filters_bar.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/notes/screens/notes_screen/widgets/notes_sections_list.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value_builder.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final _controller = GetIt.I.get<NotesScreenController>();

  @override
  void initState() {
    super.initState();
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Anotações'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              StreamValueBuilder<List<CourseBaseModel>>(
                streamValue: _controller.filteredCoursesStreamValue,
                onNullWidget: const SizedBox.shrink(),
                builder: (context, courses) => StreamValueBuilder<String?>(
                  streamValue: _controller.selectedCourseIdStreamValue,
                  onNullWidget: const SizedBox.shrink(),
                  builder: (context, selectedCourseId) =>
                      StreamValueBuilder<List<NotesFilterLevelProjection>>(
                    streamValue: _controller.filterLevelsStreamValue,
                    onNullWidget: const SizedBox.shrink(),
                    builder: (context, filterLevels) => NotesFiltersBar(
                      courses: courses,
                      selectedCourseId: selectedCourseId,
                      filterLevels: filterLevels,
                      onCourseChanged: _controller.selectCourse,
                      onLevelChanged: _controller.selectLevelOption,
                      onClearFilters: _controller.clearFilters,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: StreamValueBuilder<bool>(
                  streamValue: _controller.isLoadingStreamValue,
                  onNullWidget: const SizedBox.shrink(),
                  builder: (context, isLoading) =>
                      StreamValueBuilder<List<NotesSectionProjection>>(
                    streamValue: _controller.sectionsStreamValue,
                    onNullWidget: const SizedBox.shrink(),
                    builder: (context, sections) {
                      if (isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (sections.isEmpty) {
                        return NotesEmptyState(
                          onExploreCourses: () =>
                              context.router.push(const CoursesListRoute()),
                        );
                      }

                      return NotesSectionsList(
                        sections: sections,
                        onNoteTap: _openNoteViewer,
                        dividerColor: colorScheme.outlineVariant,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openNoteViewer(NoteModel note) async {
    final courseItem = await _controller.loadCourseItem(
      note.courseItemId.value,
    );
    if (!mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => NotePlaybackBottomSheet(
        note: note,
        courseItem: courseItem,
        onNavigateToCourse: () {
          Navigator.of(context).pop();
          context.router.push(
            CourseRoute(courseItemId: courseItem.id.value),
          );
        },
      ),
    );
  }

}
