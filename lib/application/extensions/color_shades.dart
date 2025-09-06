import 'package:flutter/material.dart';
import 'dart:math'; // Required for min() and max()

extension ColorShades on Color {
  /// Darkens the color by a given amount.
  ///
  /// The [amount] should be between 0.0 (no change) and 1.0 (black).
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0 and 1');

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness(max(0.0, hsl.lightness - amount));

    return hslDark.toColor();
  }

  /// Lightens the color by a given amount.
  ///
  /// The [amount] should be between 0.0 (no change) and 1.0 (white).
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0 and 1');

    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness(min(1.0, hsl.lightness + amount));

    return hslLight.toColor();
  }
}