import 'package:belluga_boilerplate/domain/repositories/external_courses_repository_contract.dart';
import 'package:belluga_boilerplate/infrastructure/services/courses_backend_contract.dart';
import 'package:get_it/get_it.dart';

final class ExternalCoursesRepository
    extends ExternalCoursesRepositoryContract {
  @override
  CoursesBackendContract get coursesBackend => GetIt.I.get();
}
