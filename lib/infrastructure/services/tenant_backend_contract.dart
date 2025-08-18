import 'package:unifast_portal/domain/tenant/tenant.dart';

abstract class TenantBackendContract {

  Future<Tenant> getTenant();

}
