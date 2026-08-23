import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/account_workspace_module.dart';
import 'package:flutter/material.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

@RoutePage(name: 'AccountWorkspaceHomeRoute')
class AccountWorkspaceHomeRoutePage extends StatelessWidget {
  const AccountWorkspaceHomeRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ModuleScope<AccountWorkspaceModule>(
      child: const _AccountWorkspaceHomeView(),
    );
  }
}

class _AccountWorkspaceHomeView extends StatelessWidget {
  const _AccountWorkspaceHomeView();

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
                        Icons.workspaces_outline,
                        size: 36,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Account Workspace',
                        style: textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Generic protected workspace boundary for the upstream boilerplate. '
                        'Downstream products can replace this surface with account-scoped operations '
                        'without changing the base tenant and auth route contract.',
                        style: textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),
                      OutlinedButton.icon(
                        onPressed: () =>
                            context.router.replace(const DashboardRoute()),
                        icon: const Icon(Icons.dashboard_outlined),
                        label: const Text('Open Dashboard'),
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
