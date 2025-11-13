import 'package:belluga_boilerplate/domain/learning_experience/course_base_model.dart';
import 'package:belluga_boilerplate/domain/learning_experience/course_category_model.dart';
import 'package:belluga_boilerplate/domain/learning_experience/course_item_model.dart';
import 'package:belluga_boilerplate/domain/repositories/courses_repository_contract.dart';
import 'package:belluga_boilerplate/domain/repositories/learning_experience_repository_contract.dart';
import 'package:belluga_boilerplate/domain/learning_experience/learning_cohort_snapshot_model.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/dashboard/view_models/courses_summary.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value.dart';

final class LearningExperienceRepository
    implements LearningExperienceRepositoryContract {
  LearningExperienceRepository({
    CoursesRepositoryContract? coursesRepository,
  }) : _coursesRepository = coursesRepository ?? GetIt.I.get() {
    _bindCohortSnapshotStream();
  }

  final CoursesRepositoryContract _coursesRepository;

  final StreamValue<LearningCohortSnapshotModel?>
      _activeCohortSnapshotStreamValue =
      StreamValue<LearningCohortSnapshotModel?>(defaultValue: null);

  @override
  StreamValue<CoursesSummary?> get myCoursesSummaryStreamValue =>
      _coursesRepository.myCoursesSummaryStreamValue;

  @override
  StreamValue<List<CourseBaseModel>?> get myCoursesListStreamValue =>
      _coursesRepository.myCoursesListStreamValue;

  @override
  StreamValue<List<CourseBaseModel>?> get fastTracksListStreamValue =>
      _coursesRepository.fastTracksListStreamValue;

  @override
  StreamValue<List<CourseBaseModel>?> get lastCreatedFastTracksStreamValue =>
      _coursesRepository.lastCreatedfastTracksStreamValue;

  @override
  StreamValue<List<CourseCategoryModel>?> get fastTracksCategoriesStreamValue =>
      _coursesRepository.fastTracksCategoriesListStreamValue;

  @override
  StreamValue<LearningCohortSnapshotModel?>
      get activeCohortSnapshotStreamValue => _activeCohortSnapshotStreamValue;

  @override
  Future<void> ensureMyCoursesSummary() =>
      _coursesRepository.getMyCoursesDashboardSummary();

  @override
  Future<void> ensureFastTracksCatalog() =>
      _coursesRepository.getFastTracksList();

  @override
  Future<void> ensureFastTrackHighlights() =>
      _coursesRepository.getFastTracksLastCreatedList();

  @override
  Future<void> ensureFastTrackCategories() =>
      _coursesRepository.getFastTracksCategories();

  @override
  Future<CourseItemModel> loadCourseDetails(String courseId) =>
      _coursesRepository.courseItemGetDetails(courseId);

  void _bindCohortSnapshotStream() {
    _coursesRepository.myCoursesListStreamValue.stream.listen((courses) {
      if (courses == null || courses.isEmpty) {
        return;
      }
      final snapshot = LearningCohortSnapshotModel.fromCourses(courses);
      _activeCohortSnapshotStreamValue.addValue(snapshot);
    });
  }
}
