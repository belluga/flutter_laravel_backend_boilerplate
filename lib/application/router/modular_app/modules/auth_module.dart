import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/domain/controllers/auth_login_controller_contract.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/auth/login/controller/auth_login_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

class AuthModule extends ModuleContract {
  @override
  FutureOr<void> registerDependencies() {
    GetIt.I.registerLazySingleton<AuthLoginControllerContract>(
      () => AuthLoginController(),
    );
  }

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: "/login",
          page: AuthLoginRoute.page,
        ),
        AutoRoute(
          path: "/recover_password",
          page: RecoveryPasswordRoute.page,
        ),
        AutoRoute(
          path: "/create_new_password",
          page: AuthCreateNewPasswordRoute.page,
        ),
        // AutoRoute(page: AuthPasswordRecoverRoute.page),
        // AutoRoute(page: AuthPasswordRecoverConfirmationRoute.page),
      ];
}
