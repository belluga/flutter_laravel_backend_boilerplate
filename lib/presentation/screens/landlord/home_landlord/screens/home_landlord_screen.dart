import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/configurations/belluga_constants.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:flutter/material.dart';

class HomeLandlordScreen extends StatefulWidget {
  const HomeLandlordScreen({super.key});

  @override
  State<HomeLandlordScreen> createState() => _HomeLandlordScreenState();
}

class _HomeLandlordScreenState extends State<HomeLandlordScreen> {
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
                        Icons.hub_outlined,
                        size: 36,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Platform Boilerplate',
                        style: textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Generic public and landlord shell for the upstream boilerplate. '
                        'Downstream products can replace this surface with branded discovery, '
                        'operations, or commerce experiences without changing the base runtime contract.',
                        style: textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Chip(
                            avatar: const Icon(Icons.public, size: 18),
                            label: const Text('Public shell'),
                          ),
                          Chip(
                            avatar: const Icon(Icons.admin_panel_settings,
                                size: 18),
                            label: const Text('Landlord shell'),
                          ),
                          Chip(
                            avatar: const Icon(Icons.devices, size: 18),
                            label: Text(BellugaConstants.settings.platform),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      FilledButton.icon(
                        onPressed: () =>
                            context.router.push(const AuthLoginRoute()),
                        icon: const Icon(Icons.login),
                        label: const Text('Open Tenant Sign In'),
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
