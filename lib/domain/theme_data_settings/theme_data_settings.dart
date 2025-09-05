import 'package:belluga_boilerplate/domain/theme_data_settings/color_scheme_data.dart';
import 'package:belluga_boilerplate/domain/theme_data_settings/value_objects/use_material3_value.dart';
import 'package:flutter/material.dart';

class ThemeDataSettings {
  final ColorSchemeData lightSchemeData;
  final ColorSchemeData darkSchemeData;
  final UseMaterial3Value useMaterial3Value;

  ThemeDataSettings({
    required this.darkSchemeData,
    required this.lightSchemeData,
    required this.useMaterial3Value,
  });

  ThemeData themeData(Brightness brightness) {
    late ColorScheme _colorScheme;

    switch (brightness) {
      case Brightness.dark:
        _colorScheme = darkSchemeData.colorScheme;
        break;
      case Brightness.light:
        _colorScheme = lightSchemeData.colorScheme;
        break;
    }

    return ThemeData.from(
      colorScheme: _colorScheme,
      useMaterial3: useMaterial3Value.value,
    );
  }
}
