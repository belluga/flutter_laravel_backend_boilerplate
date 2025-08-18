import 'package:belluga_boilerplate/domain/tenant/tenant.dart';

abstract class TenantBackendContract {

  Future<Tenant> getTenant();

}
