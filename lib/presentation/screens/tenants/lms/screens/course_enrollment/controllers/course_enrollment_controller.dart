import 'package:belluga_boilerplate/domain/services/course_enrollment_service.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value.dart';

class CourseEnrollmentController with Disposable {
  CourseEnrollmentController(this._enrollmentService);

  final CourseEnrollmentService _enrollmentService;

  final isEnrollingStreamValue = StreamValue<bool>(defaultValue: false);

  Future<bool> enroll(String courseId) async {
    if (isEnrollingStreamValue.value) {
      return false;
    }
    isEnrollingStreamValue.addValue(true);
    await _enrollmentService.enroll(courseId);
    isEnrollingStreamValue.addValue(false);
    return true;
  }

  @override
  void onDispose() {
    isEnrollingStreamValue.dispose();
  }
}
