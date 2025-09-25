import 'package:belluga_boilerplate/domain/app_data/app_data.dart';
import 'package:belluga_boilerplate/domain/repositories/environment_repository_contract.dart';
import 'package:belluga_boilerplate/infrastructure/services/environment_backend_contract.dart';
import 'package:get_it/get_it.dart';

class EnvironmentRepository extends EnvironmentRepositoryContract {
  
  @override
  EnvironmentBackendContract get environmentBackend => GetIt.I.get<EnvironmentBackendContract>();

  @override
  AppData get appData => GetIt.I.get<AppData>();

}
