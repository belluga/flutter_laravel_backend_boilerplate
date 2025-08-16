import 'package:auto_route/auto_route.dart';
import 'package:unifast_portal/application/router/app_router.gr.dart';
import 'package:unifast_portal/application/router/guards/auth_route_guard.dart';
import 'package:unifast_portal/application/router/guards/tenant_route_guard.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: "/init", page: InitRoute.page, initial: true),
        AutoRoute(
          path: "/",
          page: TenantHomeRoute.page,
          guards: [TenantRouteGuard()],
        ),
        AutoRoute(path: "/", page: LandlordHomeRoute.page),
        AutoRoute(
            path: "/profile",
            page: ProfileRoute.page,
            guards: [AuthRouteGuard(), TenantRouteGuard()]),
        AutoRoute(
          path: "/dashboard",
          page: DashboardRoute.page,
          guards: [AuthRouteGuard(), TenantRouteGuard()],
        ),
        AutoRoute(path: "/login", page: AuthLoginRoute.page),
        AutoRoute(path: "/recover_password", page: RecoveryPasswordRoute.page),
        // AutoRoute(page: AuthPasswordRecoverRoute.page),
        // AutoRoute(page: AuthPasswordRecoverConfirmationRoute.page),
        AutoRoute(
          path: "/meus-cursos",
          page: CoursesListRoute.page,
          guards: [AuthRouteGuard(), TenantRouteGuard()],
        ),
        AutoRoute(
          path: "/agenda",
          page: ScheduleRoute.page,
          guards: [AuthRouteGuard(), TenantRouteGuard()],
        ),
        AutoRoute(
          path: "/fast-tracks",
          page: FastTrackListRoute.page,
          guards: [AuthRouteGuard(), TenantRouteGuard()],
        ),
        AutoRoute(
          path: "/conteudo/:courseItemId",
          page: CourseRoute.page,
          guards: [AuthRouteGuard(), TenantRouteGuard()],
        ),
      ];
}
