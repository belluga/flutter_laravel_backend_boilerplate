import 'package:flutter/material.dart';

class CourseDetailCard extends StatelessWidget {
  const CourseDetailCard({
    super.key,
    required this.title,
    required this.icon,
    required this.body,
    this.action,
  });

  final String title;
  final IconData icon;
  final Widget body;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: colorScheme.onSurface),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: colorScheme.onSurface),
                  ),
                ),
                if (action != null) action!,
              ],
            ),
            const Divider(),
            body,
          ],
        ),
      ),
    );
  }
}
