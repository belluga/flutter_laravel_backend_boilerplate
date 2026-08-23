import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/auth/widgets/auth_flow_shell.dart';
import 'package:flutter/material.dart';

class AuthCreateNewPasswordScreen extends StatelessWidget {
  const AuthCreateNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthFlowShell(
      heroEyebrow: 'Password reset',
      heroTitle: 'Set-password completion is a downstream extension point.',
      heroDescription:
          'The upstream boilerplate keeps this route neutral while downstream projects decide how password resets are verified and completed.',
      sectionTitle: 'Reset placeholder',
      sectionDescription:
          'Use this surface to attach your project-specific reset token validation and password update flow.',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The upstream boilerplate does not complete password resets on its own.',
                style: TextTheme.of(context).titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Downstream products should replace this placeholder with the final password-reset confirmation experience that matches their identity flow.',
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
