import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/profile_module.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/profile/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

@RoutePage()
class ProfileRoute extends StatelessWidget {
  const ProfileRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return ModuleScope<ProfileModule>(
      onPopRoute: DashboardRoute(),
      child: ProfileScreen(),
    );
  }
}