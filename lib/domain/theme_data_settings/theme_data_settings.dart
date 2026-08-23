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

  factory ThemeDataSettings.fromJson(Map<String, dynamic> json) {
    final _darkSchemeData = ColorSchemeData.fromJson(
      _resolveSchemeData(
        json: json,
        brightness: 'dark',
        schemeKey: 'dark_scheme_data',
      ),
    );

    final _lightSchemeData = ColorSchemeData.fromJson(
      _resolveSchemeData(
        json: json,
        brightness: 'light',
        schemeKey: 'light_scheme_data',
      ),
    );

    final dynamic _rawUseMaterial = json['use_material3'];
    final _useMateial3 = UseMaterial3Value()
      ..tryParse(
        _rawUseMaterial is bool
            ? _rawUseMaterial.toString()
            : _rawUseMaterial?.toString(),
      );

    return ThemeDataSettings(
      darkSchemeData: _darkSchemeData,
      lightSchemeData: _lightSchemeData,
      useMaterial3Value: _useMateial3,
    );
  }

  static Map<String, dynamic> _resolveSchemeData({
    required Map<String, dynamic> json,
    required String brightness,
    required String schemeKey,
  }) {
    final schemeData = json[schemeKey];
    if (schemeData is Map) {
      return <String, dynamic>{
        "brightness": brightness,
        ...Map<String, dynamic>.from(schemeData),
      };
    }

    return <String, dynamic>{
      "brightness": brightness,
      "primary_seed_color": json['primary_seed_color'] ?? '#6750A4',
      "secondary_seed_color": json['secondary_seed_color'] ??
          json['primary_seed_color'] ??
          '#625B71',
    };
  }
}
