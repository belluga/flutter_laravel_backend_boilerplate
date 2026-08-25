import 'package:belluga_boilerplate/presentation/common/widgets/main_logo/main_logo.dart';
import 'package:flutter/material.dart';

class AuthFlowShell extends StatelessWidget {
  const AuthFlowShell({
    super.key,
    required this.heroEyebrow,
    required this.heroTitle,
    required this.heroDescription,
    required this.sectionTitle,
    this.sectionDescription,
    required this.child,
  });

  final String heroEyebrow;
  final String heroTitle;
  final String heroDescription;
  final String sectionTitle;
  final String? sectionDescription;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const MainLogo(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colorScheme.primary,
                    colorScheme.secondaryContainer,
                  ],
                ),
              ),
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.onPrimary.withValues(alpha: .14),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        heroEyebrow,
                        style: TextTheme.of(context).labelLarge?.copyWith(
                              color: colorScheme.onPrimary,
                            ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      heroTitle,
                      style: TextTheme.of(context).headlineSmall?.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      heroDescription,
                      style: TextTheme.of(context).bodyMedium?.copyWith(
                            color: colorScheme.onPrimary.withValues(alpha: .92),
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: colorScheme.surface,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Icon(Icons.login_rounded, color: colorScheme.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      sectionTitle,
                      style: TextTheme.of(context).titleMedium?.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      if (sectionDescription != null) ...[
                        Text(
                          sectionDescription!,
                          textAlign: TextAlign.center,
                          style: TextTheme.of(context).bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                        ),
                        const SizedBox(height: 24),
                      ],
                      child,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
