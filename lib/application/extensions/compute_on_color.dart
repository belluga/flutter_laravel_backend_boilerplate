import 'package:flutter/material.dart';

extension ComputeOnColor on Color {
  Color computeIconColor(BuildContext context) {
    final isLight = computeLuminance() > 0.5;
    final brightness = Theme.of(context).brightness;

    switch (brightness) {
      case Brightness.light:
        return isLight
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Theme.of(context).colorScheme.onPrimary;
      case Brightness.dark:
        return isLight
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.onPrimaryContainer;
    }
  }
}