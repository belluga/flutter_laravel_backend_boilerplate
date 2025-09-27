import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/application/router/guards/tenant_route_guard.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

class InitializationModule extends ModuleContract {
  @override
  FutureOr<void> registerDependencies() {
    //
  }

  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: "/init", page: InitRoute.page, initial: true),
        AutoRoute(
          path: "/",
          page: TenantHomeRoute.page,
          guards: [TenantRouteGuard()],
        ),
        AutoRoute(path: "/", page: LandlordHomeRoute.page),
      ];
}
