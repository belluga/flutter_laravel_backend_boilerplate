import 'package:belluga_boilerplate/application/configurations/belluga_constants.dart';
import 'package:belluga_boilerplate/domain/environment/environment.dart';
import 'package:belluga_boilerplate/domain/environment/value_objects/domain_value.dart';
import 'package:belluga_boilerplate/domain/environment/value_objects/environment_name_value.dart';
import 'package:belluga_boilerplate/domain/theme_data_settings/theme_data_settings.dart';

class Landlord extends Environment {

  Landlord({
    required super.nameValue,
    required super.themeDataSettings,
    required super.mainDomainValue,

  });

  String get landlordUrl => BellugaConstants.env.environment;

  factory Landlord.fromJson(Map<String, dynamic> json) {

    final _nameValue = EnvironmentNameValue()..parse(json['name']);
    final _mainDomain = DomainValue(defaultValue: Uri.parse(json['main_domain']));
    final _themeDataSettings = ThemeDataSettings.fromJson(json['theme_data_settings']);

    return Landlord(
      nameValue: _nameValue,
      mainDomainValue: _mainDomain,
      themeDataSettings: _themeDataSettings,
    );
  }
}
