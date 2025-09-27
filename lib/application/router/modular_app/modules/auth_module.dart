

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

class AuthModule extends ModuleContract {

    @override
  FutureOr<void> registerDependencies() {
    //
  }

  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: "/login", page: AuthLoginRoute.page),
    AutoRoute(path: "/recover_password", page: RecoveryPasswordRoute.page),
    // AutoRoute(page: AuthPasswordRecoverRoute.page),
    // AutoRoute(page: AuthPasswordRecoverConfirmationRoute.page),
  ];

}