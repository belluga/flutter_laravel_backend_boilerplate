import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/application/router/guards/auth_route_guard.dart';
import 'package:belluga_boilerplate/application/router/guards/tenant_route_guard.dart';

class LearningCapabilityRoutes {
  List<AutoRoute> build() => [
        AutoRoute(
          path: '/meus-cursos',
          page: CoursesListRoute.page,
          guards: [
            AuthRouteGuard(),
            TenantRouteGuard(),
          ],
        ),
        AutoRoute(
          path: '/fast-tracks',
          page: FastTrackListRoute.page,
          guards: [
            AuthRouteGuard(),
            TenantRouteGuard(),
          ],
        ),
        AutoRoute(
          path: '/course/:courseItemId',
          page: CourseRoute.page,
          guards: [
            AuthRouteGuard(),
            TenantRouteGuard(),
          ],
        ),
      ];
}
