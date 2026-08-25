import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/auth/widgets/auth_flow_shell.dart';
import 'package:flutter/material.dart';

class RecoveryPasswordScreen extends StatelessWidget {
  final String? initialEmail;

  const RecoveryPasswordScreen({super.key, this.initialEmail});

  @override
  Widget build(BuildContext context) {
    return AuthFlowShell(
      heroEyebrow: 'Recovery',
      heroTitle: 'Password recovery is a downstream extension point.',
      heroDescription:
          'The upstream boilerplate keeps this route generic while downstream products wire their own recovery delivery flow.',
      sectionTitle: 'Recovery placeholder',
      sectionDescription:
          'Use this surface to connect email, SMS, or tenant-specific recovery behavior in downstream projects.',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'No reset transport is implemented in the upstream boilerplate.',
                style: TextTheme.of(context).titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                initialEmail == null || initialEmail!.trim().isEmpty
                    ? 'Downstream projects should replace this placeholder with their own recovery transport and verification flow.'
                    : 'The last sign-in email was "${initialEmail!}". Downstream projects should replace this placeholder with their own recovery transport and verification flow.',
                style: TextTheme.of(context).bodyMedium,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => context.router.replace(const AuthLoginRoute()),
                child: const Text('Back to Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
