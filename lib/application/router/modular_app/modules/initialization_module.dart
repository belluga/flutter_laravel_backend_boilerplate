import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/presentation/screens/landlord/home_landlord/controllers/landlord_home_screen_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/home_tenant/controllers/tenant_home_screen_controller.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

class InitializationModule extends ModuleContract {
  @override
  FutureOr<void> registerDependencies() {
    _registerRepositories();
    _registerControllers();
  }

  @override
  List<AutoRoute> get routes => [];

  void _registerRepositories() {
    // registerLazySingleton<NotesRepositoryContract>(() => NotesRepository());
  }

  void _registerControllers() {
    registerLazySingleton(() => LandlordHomeScreenController());
    registerLazySingleton(() => TenantHomeScreenController());
  }
}
