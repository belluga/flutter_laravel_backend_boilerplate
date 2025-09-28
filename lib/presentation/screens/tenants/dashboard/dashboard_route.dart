import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/dashboard_module.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/dashboard/screens/dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

@RoutePage()
class DashboardRoute extends StatelessWidget {
  const DashboardRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return ModuleScope<DashboardModule>(
      child: DashboardScreen(),
    );
  }
}