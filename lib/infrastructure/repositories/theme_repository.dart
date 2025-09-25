import 'package:belluga_boilerplate/domain/repositories/environment_repository_contract.dart';
import 'package:belluga_boilerplate/domain/theme_data_settings/theme_data_settings.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value.dart';

class ThemeRepository {

  ThemeRepository(){
    setTheme(Brightness.light);
  }

  final _environmentRepository = GetIt.I.get<EnvironmentRepositoryContract>();


  ThemeDataSettings get settings => _environmentRepository.environment.themeDataSettings;

  final themeStreamValue = StreamValue<ThemeData?>();

  void setTheme(Brightness brightness) =>
      themeStreamValue.addValue(settings.themeData(brightness));
}
