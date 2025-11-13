import 'package:belluga_boilerplate/domain/learning_experience/course_base_model.dart';
import 'package:belluga_boilerplate/domain/learning_experience/learning_cohort_node_model.dart';

class LearningCohortSnapshotModel {
  LearningCohortSnapshotModel({
    required this.cohortId,
    required this.generatedAt,
    required this.nodes,
  });

  final String cohortId;
  final DateTime generatedAt;
  final List<LearningCohortNodeModel> nodes;

  factory LearningCohortSnapshotModel.fromCourses(
    List<CourseBaseModel> courses,
  ) {
    final nodes = courses
        .map(
          (course) => LearningCohortNodeModel.fromCourseSummary(course),
        )
        .toList();

    return LearningCohortSnapshotModel(
      cohortId: 'mock-school-cohort',
      generatedAt: DateTime.now().toUtc(),
      nodes: nodes,
    );
  }
}
