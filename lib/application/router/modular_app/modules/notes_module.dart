import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/application/router/guards/auth_route_guard.dart';
import 'package:belluga_boilerplate/application/router/guards/tenant_route_guard.dart';
import 'package:belluga_boilerplate/domain/repositories/notes_repository_contract.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/notes_repository.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/notes/controllers/note_playback_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/notes/screens/notes_screen/controllers/notes_screen_controller.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

class NotesModule extends ModuleContract {
  NotesModule();

  @override
  FutureOr<void> registerDependencies() {

    registerLazySingleton<NotesRepositoryContract>(
      () => NotesRepository(),
    );
    registerLazySingleton(() => NotesScreenController());
    registerFactory(NotePlaybackController.new);
  }

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
          path: '/notes',
          page: NotesRoute.page,
          guards: [
            AuthRouteGuard(),
            TenantRouteGuard(),
          ],
        ),
  ];
}
