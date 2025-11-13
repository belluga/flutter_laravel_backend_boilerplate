import 'package:belluga_boilerplate/domain/repositories/enrollment_repository.dart';

class CourseEnrollmentService {
  CourseEnrollmentService(this._enrollmentRepository);

  final EnrollmentRepository _enrollmentRepository;

  Future<void> enroll(String courseId) {
    return _enrollmentRepository.enroll(courseId);
  }
}
