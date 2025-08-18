import 'package:get_it/get_it.dart';
import 'package:unifast_portal/domain/repositories/tenant_repository_contract.dart';
import 'package:unifast_portal/domain/tenant/tenant.dart';

class TenantHomeScreenController {
  final tenantRepository = GetIt.I.get<TenantRepositoryContract>();
  
  Tenant get tenant => tenantRepository.tenant!;

  TenantHomeScreenController();

  Future<void> init() async {
    await tenantRepository.init();
  }
}
