import 'package:belluga_boilerplate/domain/repositories/enrollment_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:stream_value/core/stream_value.dart';

class CourseEnrollmentController with Disposable {
  CourseEnrollmentController({
    @visibleForTesting EnrollmentRepository? enrollmentRepository,
  }) : _enrollmentRepository = enrollmentRepository ?? GetIt.I.get<EnrollmentRepository>();

  final EnrollmentRepository _enrollmentRepository;

  final isEnrollingStreamValue = StreamValue<bool>(defaultValue: false);

  Future<bool> enroll(String courseId) async {
    if (isEnrollingStreamValue.value) {
      return false;
    }
    isEnrollingStreamValue.addValue(true);
    await _enrollmentRepository.enroll(courseId);
    isEnrollingStreamValue.addValue(false);
    return true;
  }

  @override
  void onDispose() {
    isEnrollingStreamValue.dispose();
  }
}
