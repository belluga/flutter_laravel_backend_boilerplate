import 'package:belluga_boilerplate/domain/learning_experience/course_base_model.dart';
import 'package:belluga_boilerplate/domain/learning_experience/course_category_model.dart';
import 'package:belluga_boilerplate/domain/learning_experience/course_item_model.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/dashboard/view_models/courses_summary.dart';
import 'package:belluga_boilerplate/domain/learning_experience/learning_cohort_snapshot_model.dart';
import 'package:stream_value/core/stream_value.dart';

/// Contract that exposes the Learning Engine capability streams the UI consumes.
///
/// This abstraction lets us align client wiring with the advanced architecture
/// blueprint: the Flutter layer no longer depends directly on the raw
/// repository, but on a capability-oriented surface that can evolve with the
/// Learning Engine roadmap (templates, cohorts, snapshots, etc.).
abstract class LearningExperienceRepositoryContract {
  StreamValue<CoursesSummary?> get myCoursesSummaryStreamValue;
  StreamValue<List<CourseBaseModel>?> get myCoursesListStreamValue;
  StreamValue<List<CourseBaseModel>?> get fastTracksListStreamValue;
  StreamValue<List<CourseBaseModel>?> get lastCreatedFastTracksStreamValue;
  StreamValue<List<CourseCategoryModel>?> get fastTracksCategoriesStreamValue;

  /// Cohort snapshot derived from the current mock data. It mirrors the
  /// `structure_snapshot` concept in the Learning Engine documentation so we
  /// can start enforcing the same navigation semantics in the client.
  StreamValue<LearningCohortSnapshotModel?> get activeCohortSnapshotStreamValue;

  Future<void> ensureMyCoursesSummary();
  Future<void> ensureFastTracksCatalog();
  Future<void> ensureFastTrackHighlights();
  Future<void> ensureFastTrackCategories();

  Future<CourseItemModel> loadCourseDetails(String courseId);
}
