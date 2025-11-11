import 'package:flutter/material.dart';

/// A widget that visually displays all the key colors of a given ColorScheme.
class ColorSchemeViewer extends StatelessWidget {
  final ColorScheme colorScheme;

  const ColorSchemeViewer({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Wrap(
          spacing: 12.0, // Horizontal space between tiles
          runSpacing: 12.0, // Vertical space between lines of tiles
          children: [
            _ColorTile(
              name: 'Primary',
              color: colorScheme.primary,
              onColor: colorScheme.onPrimary,
            ),
            _ColorTile(
              name: 'On Primary',
              color: colorScheme.onPrimary,
              onColor: colorScheme.primary,
            ),
            _ColorTile(
              name: 'Primary Container',
              color: colorScheme.primaryContainer,
              onColor: colorScheme.onPrimaryContainer,
            ),
            _ColorTile(
              name: 'On Primary Container',
              color: colorScheme.onPrimaryContainer,
              onColor: colorScheme.primaryContainer,
            ),
            _ColorTile(
              name: 'Secondary',
              color: colorScheme.secondary,
              onColor: colorScheme.onSecondary,
            ),
            _ColorTile(
              name: 'On Secondary',
              color: colorScheme.onSecondary,
              onColor: colorScheme.secondary,
            ),
            _ColorTile(
              name: 'Secondary Container',
              color: colorScheme.secondaryContainer,
              onColor: colorScheme.onSecondaryContainer,
            ),
            _ColorTile(
              name: 'On Secondary Container',
              color: colorScheme.onSecondaryContainer,
              onColor: colorScheme.secondaryContainer,
            ),
            _ColorTile(
              name: 'Tertiary',
              color: colorScheme.tertiary,
              onColor: colorScheme.onTertiary,
            ),
            _ColorTile(
              name: 'On Tertiary',
              color: colorScheme.onTertiary,
              onColor: colorScheme.tertiary,
            ),
            _ColorTile(
              name: 'Error',
              color: colorScheme.error,
              onColor: colorScheme.onError,
            ),
            _ColorTile(
              name: 'On Error',
              color: colorScheme.onError,
              onColor: colorScheme.error,
            ),
            _ColorTile(
              name: 'Background',
              color: colorScheme.background,
              onColor: colorScheme.onBackground,
            ),
            _ColorTile(
              name: 'On Background',
              color: colorScheme.onBackground,
              onColor: colorScheme.background,
            ),
            _ColorTile(
              name: 'Surface',
              color: colorScheme.surface,
              onColor: colorScheme.onSurface,
            ),
            _ColorTile(
              name: 'On Surface',
              color: colorScheme.onSurface,
              onColor: colorScheme.surface,
            ),
            _ColorTile(
              name: 'Surface Variant',
              color: colorScheme.surfaceVariant,
              onColor: colorScheme.onSurfaceVariant,
            ),
            _ColorTile(
              name: 'Outline',
              color: colorScheme.outline,
              onColor: colorScheme.surface, // Often shown on a surface
            ),
          ],
        ),
      ),
    );
  }
}

/// A helper widget to display a single color swatch with its name.
class _ColorTile extends StatelessWidget {
  final String name;
  final Color color;
  final Color onColor;

  const _ColorTile({
    required this.name,
    required this.color,
    required this.onColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 75,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
        ),
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            color: onColor, // Ensures text is readable
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
