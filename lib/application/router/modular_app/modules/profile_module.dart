import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/application/router/guards/auth_route_guard.dart';
import 'package:belluga_boilerplate/application/router/guards/tenant_route_guard.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/profile/controller/profile_screen_controller.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

class ProfileModule extends ModuleContract {
  @override
  FutureOr<void> registerDependencies() {
    _registerRepositories();
    _registerControllers();
  }

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: "/profile",
          page: ProfileRoute.page,
          guards: [
            AuthRouteGuard(),
            TenantRouteGuard(),
          ],
        ),
      ];

  void _registerRepositories() {
    //
  }

  void _registerControllers() {
    registerLazySingleton(() => ProfileScreenController());
  }
}
