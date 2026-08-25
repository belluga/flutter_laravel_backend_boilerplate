import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/auth_module.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/auth/login/screens/auth_login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

@RoutePage()
class AuthLoginRoute extends StatelessWidget {
  const AuthLoginRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return ModuleScope<AuthModule>(
      child: AuthLoginScreen(),
    );
  }
}