import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/domain/repositories/environment_repository_contract.dart';
import 'package:get_it/get_it.dart';

class TenantRouteGuard extends AutoRouteGuard {
  final _tenantRepository = GetIt.I.get<EnvironmentRepositoryContract>();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_tenantRepository.isProperTenantRegistered) {
      resolver.next(true);
    } else {
      router.push(const LandlordHomeRoute());
    }
  }
}
