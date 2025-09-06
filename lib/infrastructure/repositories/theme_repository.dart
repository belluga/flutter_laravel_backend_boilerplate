import 'package:belluga_boilerplate/domain/theme_data_settings/theme_data_settings.dart';
import 'package:flutter/material.dart';
import 'package:stream_value/core/stream_value.dart';

class ThemeRepository {
  late ThemeDataSettings settings;

  void init(ThemeDataSettings dataThemeSettings) {
    settings = dataThemeSettings;
  }

  final themeStreamValue = StreamValue<ThemeData?>();

  void setTheme(Brightness brightness) =>
      themeStreamValue.addValue(settings.themeData(brightness));
}
