import 'package:belluga_boilerplate/infrastructure/services/dal/dto/course/category_dto.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dto/course/course_item_summary_dto.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dto/course/course_item_dto.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dto/external_course_dto.dart';

abstract class CoursesBackendContract {
  Future<List<ExternalCourseDTO>> getExternalCourses();
  Future<List<CourseItemSummaryDTO>> getMyCourses();
  Future<List<CourseItemSummaryDTO>> getUnifastTracks();
  Future<List<CourseItemSummaryDTO>> getLastFastTrackCourses();
  Future<CourseItemDetailsDTO> courseItemGetDetails(String courseId);
  Future<List<CategoryDTO>> getFastTracksCategories();
}
