import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/domain/learning_experience/course_item_model.dart';
import 'package:belluga_boilerplate/domain/repositories/enrollment_repository.dart';
import 'package:belluga_boilerplate/domain/repositories/learning_experience_repository_contract.dart';
import 'package:belluga_boilerplate/domain/repositories/notes_repository_contract.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/learning_experience_repository.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/learning_capability_routes.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/notes_repository.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_enrollment/controllers/course_enrollment_controller.dart';
import 'package:belluga_boilerplate/application/router/resolvers/course_item_route_resolver.dart';
import 'package:belluga_boilerplate/application/router/resolvers/route_model_resolver.dart';
import 'package:belluga_boilerplate/domain/services/course_enrollment_service.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_screen/controllers/course_screen_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/courses_list_screen/controllers/courses_list_screen_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/fast_tracks_list_screen/controllers/fast_tracks_list_screen_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/notes/screens/notes_screen/controllers/notes_screen_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/notes/widgets/add_note/controller/add_note_bottom_modal_controller.dart';
import 'package:get_it/get_it.dart';
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
    RouteResolverRegistry.instance.register<CourseItemModel>(
      CourseItemRouteResolver(
        GetIt.I.get<LearningExperienceRepositoryContract>(),
      ),
    );
    registerLazySingleton(() => FastTracksListScreenController());
    registerLazySingleton(() => CourseScreenController());
    registerLazySingleton(() => CoursesListScreenController());
    registerLazySingleton(() => NotesScreenController());
    registerLazySingleton(
      () => CourseEnrollmentService(
        GetIt.I.get<EnrollmentRepository>(),
      ),
    );
    
    registerLazySingleton(
      () => CourseEnrollmentController(
        GetIt.I.get<CourseEnrollmentService>(),
      ),
    );
    registerFactory(() => AddNoteBottomModalController());
  }

  @override
  List<AutoRoute> get routes => _routes.build();
}
