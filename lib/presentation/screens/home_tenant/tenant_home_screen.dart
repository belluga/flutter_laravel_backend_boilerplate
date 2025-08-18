import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:belluga_boilerplate/application/configurations/belluga_constants.dart';
import 'package:belluga_boilerplate/application/configurations/widget_keys.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/presentation/screens/home_tenant/controllers/tenant_home_screen_controller.dart';

@RoutePage()
class TenantHomeScreen extends StatefulWidget {
  const TenantHomeScreen({super.key});

  @override
  State<TenantHomeScreen> createState() => _TenantHomeScreenState();
}

class _TenantHomeScreenState extends State<TenantHomeScreen> {
  late TenantHomeScreenController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GetIt.I.registerSingleton<TenantHomeScreenController>(
      TenantHomeScreenController(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("This is HOME"),
            Text(_controller.tenant.name.value),
            Text(BellugaConstants.settings.platform),
            ElevatedButton(
              key: WidgetKeys.auth.navigateToProtectedButton,
              onPressed: () => context.router.push(const DashboardRoute()),
              child: const Text("goto Protected"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    GetIt.I.unregister<TenantHomeScreenController>();
    super.dispose();
  }
}
