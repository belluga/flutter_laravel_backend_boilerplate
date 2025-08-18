import 'package:unifast_portal/domain/app_data/app_data.dart';
import 'package:unifast_portal/domain/repositories/tenant_repository_contract.dart';
import 'package:unifast_portal/infrastructure/services/backend_contract.dart';
import 'package:get_it/get_it.dart';

class TenantRepository extends TenantRepositoryContract {

  @override
  BackendContract get backend => GetIt.I.get<BackendContract>();

  @override
  AppData get appData => GetIt.I.get<AppData>();

}
