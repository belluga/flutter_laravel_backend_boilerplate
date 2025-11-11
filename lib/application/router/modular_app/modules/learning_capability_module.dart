import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/domain/repositories/learning_experience_repository_contract.dart';
import 'package:belluga_boilerplate/domain/repositories/notes_repository_contract.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/learning_experience_repository.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/learning_capability_routes.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/notes_repository.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_screen/controllers/course_screen_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/courses_list_screen/controllers/courses_list_screen_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/fast_tracks_list_screen/controllers/fast_tracks_list_screen_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/notes/screens/notes_screen/controllers/notes_screen_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/notes/widgets/add_note/controller/add_note_bottom_modal_controller.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

class LearningCapabilityModule extends ModuleContract {
  LearningCapabilityModule() : _routes = LearningCapabilityRoutes();

  final LearningCapabilityRoutes _routes;

  @override
  FutureOr<void> registerDependencies() {

    registerLazySingleton<NotesRepositoryContract>(
      () => NotesRepository(),
    );
    registerLazySingleton<LearningExperienceRepositoryContract>(
      () => LearningExperienceRepository(),
    );
    registerLazySingleton(() => FastTracksListScreenController());
    registerLazySingleton(() => CourseScreenController());
    registerLazySingleton(() => CoursesListScreenController());
    registerLazySingleton(() => AddNoteBottomModalController());
    registerLazySingleton(() => NotesScreenController());
  }

  @override
  List<AutoRoute> get routes => _routes.build();
}
