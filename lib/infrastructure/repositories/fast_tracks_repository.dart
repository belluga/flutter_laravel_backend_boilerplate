import 'package:belluga_boilerplate/domain/repositories/courses_repository_contract.dart';
import 'package:belluga_boilerplate/infrastructure/services/courses_backend_contract.dart';
import 'package:get_it/get_it.dart';

final class FastTracksRepository extends CoursesRepositoryContract {
  @override
  CoursesBackendContract get coursesBackend => GetIt.I.get();
}
