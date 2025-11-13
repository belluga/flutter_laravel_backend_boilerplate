import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/dashboard_module.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/menu/screens/menu_screen/menu_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

@RoutePage()
class TenantMenuRoute extends StatelessWidget {
  const TenantMenuRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return ModuleScope<DashboardModule>(
      child: const MenuScreen(),
    );
  }
}
