

import 'dart:async';

import 'package:belluga_boilerplate/application/router/modular_app/modules/auth_module.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/dashboard_module.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/fast_tracks_module.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/initialization_module.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/my_courses_module.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/profile_module.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/schedule_module.dart';
import 'package:belluga_boilerplate/domain/repositories/auth_repository_contract.dart';
import 'package:belluga_boilerplate/domain/repositories/courses_repository_contract.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/app_data_repository.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/auth_repository.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/courses_repository.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/theme_repository.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/laravel_backend/app_data_backend/app_data_backend.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/local/app_data_local_cache/app_data_local_cache.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/local/app_data_local_info_source/app_data_local_info_source.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

class ModuleSettings extends ModuleSettingsContract {

  @override
  FutureOr<void> registerGlobalDependencies() async {  
    
    final _authRepository = AuthRepository();
    await _authRepository.init();

    GetIt.I.registerLazySingleton<AuthRepositoryContract>(
      () => _authRepository,
    );

    final _localCache = AppDataLocalCache();
    final _backend = AppDataBackend();
    final _localInfoSource = AppDataLocalInfoSource();

    final appDataRepo = AppDataRepository(
      localCache: _localCache,
      backend: _backend,
      localInfoSource: _localInfoSource,
    );

    await appDataRepo.init();

    GetIt.I.registerSingleton<AppDataRepository>(appDataRepo);
    GetIt.I.registerLazySingleton(() => ThemeRepository());
    GetIt.I.registerLazySingleton<CoursesRepositoryContract>(
      () => CoursesRepository(),
    );
  }

  @override
  Future<void> initializeSubmodules() async {
    await registerSubModule(InitializationModule());
    await registerSubModule(AuthModule());
    await registerSubModule(DashboardModule());
    await registerSubModule(FastTracksModule());
    await registerSubModule(MyCoursesModule());
    await registerSubModule(ProfileModule());
    await registerSubModule(ScheduleModule());
  }

}