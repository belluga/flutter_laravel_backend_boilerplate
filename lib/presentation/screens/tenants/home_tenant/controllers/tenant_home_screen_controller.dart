import 'package:get_it/get_it.dart';
import 'package:belluga_boilerplate/domain/repositories/tenant_repository_contract.dart';
import 'package:belluga_boilerplate/domain/tenant/tenant.dart';

class TenantHomeScreenController {
  final tenantRepository = GetIt.I.get<TenantRepositoryContract>();
  
  Tenant get tenant => tenantRepository.tenant!;

  TenantHomeScreenController();

  Future<void> init() async {
    await tenantRepository.init();
  }
}
