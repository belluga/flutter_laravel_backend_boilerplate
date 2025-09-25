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

  // Add this factory constructor inside your ThemeDataSettings class
factory ThemeDataSettings.fromJson(Map<String, dynamic> json) {

  final _darkSchemeData =  ColorSchemeData.fromJson(<String,dynamic>{
      "brightness": "dark",
      ...json['dark_scheme_data']
    });

  final _lightSchemeData = ColorSchemeData.fromJson(
    <String,dynamic>{
      "brightness": "light",
      ...json['light_scheme_data']
    }
  );

  final _useMateial3 =  UseMaterial3Value()..tryParse(json['use_material3']);

  return ThemeDataSettings(
    darkSchemeData: _darkSchemeData,
    lightSchemeData: _lightSchemeData,
    useMaterial3Value: _useMateial3,
  );
}
}
