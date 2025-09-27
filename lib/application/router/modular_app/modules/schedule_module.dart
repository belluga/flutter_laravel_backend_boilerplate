import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/application/router/guards/auth_route_guard.dart';
import 'package:belluga_boilerplate/application/router/guards/tenant_route_guard.dart';
import 'package:belluga_boilerplate/domain/repositories/schedule_repository_contract.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/schedule_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

class ScheduleModule extends ModuleContract {
  
  @override
  FutureOr<void> registerDependencies() {
    GetIt.I.registerLazySingleton<ScheduleRepositoryContract>(
        () => ScheduleRepository());
  }

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: "/agenda",
          page: ScheduleRoute.page,
          guards: [AuthRouteGuard(), TenantRouteGuard()],
        ),
      ];

}