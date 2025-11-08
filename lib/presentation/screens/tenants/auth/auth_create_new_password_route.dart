import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/auth_module.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/auth/create_new_password/auth_create_new_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

@RoutePage()
class AuthCreateNewPasswordRoute extends StatelessWidget {
  const AuthCreateNewPasswordRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return ModuleScope<AuthModule>(
      child: AuthCreateNewPasswordScreen(),
    );
  }
}