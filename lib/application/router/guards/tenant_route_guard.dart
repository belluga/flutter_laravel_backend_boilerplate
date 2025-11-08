import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/app_data_repository.dart';
import 'package:get_it/get_it.dart';

class TenantRouteGuard extends AutoRouteGuard {
  final _appData = GetIt.I.get<AppDataRepository>().appData;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_appData.isTenant) {
      resolver.next(true);
    } else {
      router.push(const HomeLandlordRoute());
    }
  }
}
