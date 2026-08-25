import 'package:belluga_boilerplate/domain/learning_experience/course_base_model.dart';

class NotesFilterLevelProjection {
  final String label;
  final List<CourseBaseModel> options;
  final CourseBaseModel? selected;

  const NotesFilterLevelProjection({
    required this.label,
    required this.options,
    this.selected,
  });

  NotesFilterLevelProjection copyWith({
    List<CourseBaseModel>? options,
    CourseBaseModel? selected,
  }) {
    return NotesFilterLevelProjection(
      label: label,
      options: options ?? this.options,
      selected: selected ?? this.selected,
    );
  }
}
