import 'package:flutter/material.dart';

class AuthHeaderExpandedContent extends StatelessWidget {
  const AuthHeaderExpandedContent({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: colorScheme.onPrimary.withValues(alpha: .14),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                'Tenant access',
                style: TextTheme.of(context).labelLarge?.copyWith(
                      color: colorScheme.onPrimary,
                    ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Continue with the boilerplate tenant flow.',
              style: TextTheme.of(context).headlineSmall?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              'Downstream products can replace this entry surface with their own sign-in experience without changing the base auth contract.',
              style: TextTheme.of(context).bodyMedium?.copyWith(
                    color: colorScheme.onPrimary.withValues(alpha: .92),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
