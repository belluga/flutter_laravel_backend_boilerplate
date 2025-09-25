import 'package:get_it/get_it.dart';
import 'package:belluga_boilerplate/domain/repositories/environment_repository_contract.dart';
import 'package:belluga_boilerplate/domain/environment/environment.dart';

class TenantHomeScreenController {
  final tenantRepository = GetIt.I.get<EnvironmentRepositoryContract>();
  
  Environment get tenant => tenantRepository.environment;

  TenantHomeScreenController();

  Future<void> init() async {
    await tenantRepository.init();
  }
}
