import 'package:belluga_boilerplate/domain/repositories/enrollment_repository.dart';
import 'package:get_it/get_it.dart';

class CourseEnrollmentService {
  CourseEnrollmentService({
    EnrollmentRepository? enrollmentRepository,
  }) : _enrollmentRepository = enrollmentRepository;

  final EnrollmentRepository? _enrollmentRepository;

  Future<void> enroll(String courseId) {
    final repo =
        _enrollmentRepository ?? GetIt.I.get<EnrollmentRepository>();
    return repo.enroll(courseId);
  }
}
