import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/application/router/guards/auth_route_guard.dart';
import 'package:belluga_boilerplate/application/router/guards/tenant_route_guard.dart';
import 'package:belluga_boilerplate/domain/repositories/notes_repository_contract.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/notes_repository.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_screen/controllers/course_screen_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/courses_list_screen/controllers/courses_list_screen_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/fast_tracks_list_screen/controllers/fast_tracks_list_screen_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/notes/widgets/add_note/controller/add_note_bottom_modal_controller.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

class LmsModule extends ModuleContract {
  @override
  FutureOr<void> registerDependencies() {
    _registerRepositories();
    _registerControllers();
  }

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: "/meus-cursos",
          page: CoursesListRoute.page,
          guards: [
            AuthRouteGuard(),
            TenantRouteGuard(),
          ],
        ),
        AutoRoute(
          path: "/fast-tracks",
          page: FastTrackListRoute.page,
          guards: [
            AuthRouteGuard(),
            TenantRouteGuard(),
          ],
        ),
        AutoRoute(
          path: "/course/:courseItemId",
          page: CourseRoute.page,
          guards: [
            AuthRouteGuard(),
            TenantRouteGuard(),
          ],
        ),
      ];

  void _registerRepositories() {
    registerLazySingleton<NotesRepositoryContract>(() => NotesRepository());
  }

  void _registerControllers() {
    registerLazySingleton(() => FastTracksListScreenController());
    registerLazySingleton(() => CourseScreenController());
    registerLazySingleton(() => CoursesListScreenController());
    registerLazySingleton(() => AddNoteBottomModalController());
  }
}
