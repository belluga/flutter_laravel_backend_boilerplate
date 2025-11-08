import 'package:belluga_boilerplate/infrastructure/repositories/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value.dart';

class MainLogoController {
  final _themeRepository = GetIt.I.get<ThemeRepository>();

  StreamValue<ThemeData?> get themeDataStreamValue => _themeRepository.themeStreamValue;
}