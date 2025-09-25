import 'package:belluga_boilerplate/application/configurations/belluga_constants.dart';
import 'package:belluga_boilerplate/domain/app_data/app_data.dart';
import 'package:belluga_boilerplate/domain/environment/landlord.dart';
import 'package:belluga_boilerplate/domain/environment/tenant.dart';
import 'package:belluga_boilerplate/domain/environment/value_objects/domain_value.dart';
import 'package:belluga_boilerplate/domain/environment/value_objects/logo_url_value.dart';
import 'package:belluga_boilerplate/domain/environment/value_objects/environment_name_value.dart';
import 'package:belluga_boilerplate/domain/theme_data_settings/theme_data_settings.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

abstract class Environment {
  
  final EnvironmentNameValue nameValue;
  final ThemeDataSettings themeDataSettings;
  final DomainValue mainDomainValue;

  Environment({
    required this.nameValue,
    required this.themeDataSettings,
    required this.mainDomainValue,
  });

  AppData get appData => GetIt.I.get<AppData>();

  String get landlordDomain => BellugaConstants.env.environment;

  Brightness? get brightness =>
      GetIt.I.get<ThemeRepository>().themeStreamValue.value?.brightness;

  LogoUriValue get logoUri {
    switch (brightness) {
      case Brightness.dark:
        return LogoUriValue()..parse("${mainDomainValue.value}/dark-logo.png");
      default:
        return LogoUriValue()..parse("${mainDomainValue.value}/light-logo.png");
    }
  }

  LogoUriValue get iconUri {
    switch (brightness) {
      case Brightness.dark:
        return LogoUriValue()..parse("${mainDomainValue.value}/dark-icon.png");
      default:
        return LogoUriValue()..parse("${mainDomainValue.value}/light-icon.png");
    }
  }

  static Environment fromJson(Map<String, dynamic> json) {
    final _type = json['type'] as String;

    switch (_type) {
      case 'tenant':
        return Tenant.fromJson(json);
      case 'landlord':
      default:
        return Landlord.fromJson(json);
    }
  }
}
