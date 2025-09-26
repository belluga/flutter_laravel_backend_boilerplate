import 'package:flutter/material.dart';

extension HexToColor on String {
  Color toColor() {
    final buffer = StringBuffer();
    String hex = replaceFirst('#', '').toUpperCase();
    if (hex.length == 6) {
      buffer.write('FF');
    }
    buffer.write(hex);
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
