import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/application/router/guards/landlord_route_guard.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

class LandlordModule extends ModuleContract {
  @override
  FutureOr<void> registerDependencies() {}

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: HomeLandlordRoute.page,
          guards: [LandlordRouteGuard()],
        ),
        RedirectRoute(path: '/landlord', redirectTo: '/'),
      ];
}
