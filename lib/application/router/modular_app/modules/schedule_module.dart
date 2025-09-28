import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/application/router/guards/auth_route_guard.dart';
import 'package:belluga_boilerplate/application/router/guards/tenant_route_guard.dart';
import 'package:belluga_boilerplate/domain/repositories/schedule_repository_contract.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/schedule_repository.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/schedule/controller/schedule_screen_controller.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

class ScheduleModule extends ModuleContract {
  @override
  FutureOr<void> registerDependencies() {
    _registerRepositories();
    _registerControllers();
  }

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: "/agenda",
          page: ScheduleRoute.page,
          guards: [AuthRouteGuard(), TenantRouteGuard()],
        ),
      ];

  void _registerRepositories() {
    registerLazySingleton<ScheduleRepositoryContract>(
        () => ScheduleRepository());
  }

  void _registerControllers() {
    registerLazySingleton(() => ScheduleScreenController());
  }
}
