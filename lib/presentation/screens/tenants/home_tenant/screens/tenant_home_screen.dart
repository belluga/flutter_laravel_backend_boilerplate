import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:belluga_boilerplate/application/configurations/belluga_constants.dart';
import 'package:belluga_boilerplate/application/configurations/widget_keys.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/home_tenant/controllers/tenant_home_screen_controller.dart';

class TenantHomeScreen extends StatefulWidget {
  const TenantHomeScreen({super.key});

  @override
  State<TenantHomeScreen> createState() => _TenantHomeScreenState();
}

class _TenantHomeScreenState extends State<TenantHomeScreen> {
  final _controller = GetIt.I.get<TenantHomeScreenController>();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Card(
                elevation: 0,
                color: colorScheme.surfaceContainerHighest,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.apartment_outlined,
                        size: 36,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Tenant Workspace',
                        style: textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Generic upstream tenant shell. '
                        'Use this entry surface to validate authentication, dashboard routing, '
                        'and downstream capability composition without carrying project-specific branding.',
                        style: textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Chip(
                            avatar: const Icon(Icons.business, size: 18),
                            label: Text(_controller.appData.nameValue.value),
                          ),
                          Chip(
                            avatar: const Icon(Icons.devices, size: 18),
                            label: Text(BellugaConstants.settings.platform),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          FilledButton.icon(
                            onPressed: () =>
                                context.router.push(const AuthLoginRoute()),
                            icon: const Icon(Icons.login),
                            label: const Text('Sign In'),
                          ),
                          OutlinedButton.icon(
                            key: WidgetKeys.auth.navigateToProtectedButton,
                            onPressed: () =>
                                context.router.push(const DashboardRoute()),
                            icon: const Icon(Icons.dashboard_outlined),
                            label: const Text('Open Protected Flow'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
