import 'package:belluga_boilerplate/domain/learning_experience/course_base_model.dart';

enum LearningNodeType {
  program,
  track,
  lesson,
}

class LearningCohortNodeModel {
  LearningCohortNodeModel({
    required this.nodeId,
    required this.title,
    required this.sourceCourseId,
    required this.nodeType,
    this.parentNodeId,
    this.tags = const [],
  });

  final String nodeId;
  final String title;
  final String sourceCourseId;
  final LearningNodeType nodeType;
  final String? parentNodeId;
  final List<String> tags;

  factory LearningCohortNodeModel.fromCourseSummary(
    CourseBaseModel course, {
    String? parentNodeId,
  }) {
    final inferredType = (course.categories
                ?.any((category) => category.slug.value == 'fast-tracks') ??
            false)
        ? LearningNodeType.track
        : LearningNodeType.lesson;

    return LearningCohortNodeModel(
      nodeId: 'node-${course.id.value}',
      title: course.title.value,
      sourceCourseId: course.id.value,
      nodeType: inferredType,
      parentNodeId: parentNodeId,
      tags:
          course.categories?.map((category) => category.slug.value).toList() ??
              [],
    );
  }
}
