import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/auth_module.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/auth/recovery_password_bug/recovery_password_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

@RoutePage()
class RecoveryPasswordRoute extends StatelessWidget {
  
  final String? initialEmail;

  const RecoveryPasswordRoute({super.key, this.initialEmail});

  @override
  Widget build(BuildContext context) {
    return ModuleScope<AuthModule>(
      child: RecoveryPasswordScreen(
        initialEmail: initialEmail
      ),
    );
  }
}