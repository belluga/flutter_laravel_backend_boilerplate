import 'package:belluga_boilerplate/domain/learning_experience/course_base_model.dart';
import 'package:belluga_boilerplate/domain/notes/projections/notes_filter_level_projection.dart';
import 'package:flutter/material.dart';

class NotesFiltersBar extends StatelessWidget {
  final List<CourseBaseModel> courses;
  final String? selectedCourseId;
  final List<NotesFilterLevelProjection> filterLevels;
  final ValueChanged<String?> onCourseChanged;
  final Future<void> Function(int levelIndex, String? nodeId) onLevelChanged;
  final VoidCallback onClearFilters;

  const NotesFiltersBar({
    super.key,
    required this.courses,
    required this.selectedCourseId,
    required this.filterLevels,
    required this.onCourseChanged,
    required this.onLevelChanged,
    required this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButtonFormField<String?>(
          key: ValueKey(selectedCourseId),
          initialValue: selectedCourseId,
          decoration: const InputDecoration(
            labelText: 'Curso',
            border: OutlineInputBorder(),
          ),
          onChanged: onCourseChanged,
          items: [
            const DropdownMenuItem<String?>(
              value: null,
              child: Text('Todos os cursos'),
            ),
            ...courses.map(
              (course) => DropdownMenuItem<String?>(
                value: course.id.value,
                child: Text(course.title.value),
              ),
            ),
          ],
        ),
        for (var i = 0; i < filterLevels.length; i++) ...[
          const SizedBox(height: 12),
          _LevelDropdown(
            levelIndex: i,
            level: filterLevels[i],
            onChanged: (value) => onLevelChanged(i, value),
          ),
        ],
        if (selectedCourseId != null || filterLevels.isNotEmpty) ...[
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onClearFilters,
              child: const Text('Limpar filtros'),
            ),
          ),
        ],
      ],
    );
  }
}

class _LevelDropdown extends StatelessWidget {
  final int levelIndex;
  final NotesFilterLevelProjection level;
  final ValueChanged<String?> onChanged;

  const _LevelDropdown({
    required this.levelIndex,
    required this.level,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String?>(
      key: ValueKey('${level.label}-${level.selected?.id.value}'),
      initialValue: level.selected?.id.value,
      decoration: InputDecoration(
        labelText: level.label,
        border: const OutlineInputBorder(),
      ),
      onChanged: onChanged,
      items: [
        DropdownMenuItem<String?>(
          value: null,
          child: Text('Todos ${level.label.toLowerCase()}s'),
        ),
        ...level.options.map(
          (option) => DropdownMenuItem<String?>(
            value: option.id.value,
            child: Text(option.title.value),
          ),
        ),
      ],
    );
  }
}
