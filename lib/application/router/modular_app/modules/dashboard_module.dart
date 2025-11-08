import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/application/router/guards/auth_route_guard.dart';
import 'package:belluga_boilerplate/application/router/guards/tenant_route_guard.dart';
import 'package:belluga_boilerplate/domain/controllers/create_password_controller_contract.dart';
import 'package:belluga_boilerplate/domain/repositories/external_courses_repository_contract.dart';
import 'package:belluga_boilerplate/domain/repositories/schedule_repository_contract.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/external_courses_repository.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/schedule_repository.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/auth/create_new_password/controller/create_password_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/dashboard/controllers/external_course_dashboard_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/dashboard/controllers/my_courses_dashboard_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/dashboard/controllers/next_events_dashboard_controller.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

class DashboardModule extends ModuleContract {
  @override
  FutureOr<void> registerDependencies() async {
    _registerRepositories();
    _registerControllers();
  }

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: "/dashboard",
          page: DashboardRoute.page,
          guards: [
            AuthRouteGuard(),
            TenantRouteGuard(),
          ],
        ),
      ];

  void _registerRepositories() {
    registerLazySingleton<ScheduleRepositoryContract>(
      () => ScheduleRepository(),
    );

    registerLazySingleton<ExternalCoursesRepositoryContract>(
      () => ExternalCoursesRepository(),
    );
  }

  void _registerControllers() {
    registerLazySingleton<MyCoursesDashboardController>(
        () => MyCoursesDashboardController());

    registerLazySingleton(() => NextEventsDashboardController());

    registerLazySingleton(() => ExternalCourseDashboardController());

    registerLazySingleton<CreatePasswordControllerContract>(() => CreatePasswordController());


    

  }
}
