import 'package:belluga_boilerplate/domain/landlord/landlord.dart';
import 'package:belluga_boilerplate/domain/landlord/value_objects/landlord_name_value.dart';
import 'package:belluga_boilerplate/domain/tenant/value_objects/logo_url_value.dart';
import 'package:belluga_boilerplate/domain/theme_data_settings/color_scheme_data.dart';
import 'package:belluga_boilerplate/domain/theme_data_settings/logo_settings.dart';
import 'package:belluga_boilerplate/domain/theme_data_settings/theme_data_settings.dart';
import 'package:belluga_boilerplate/domain/theme_data_settings/value_objects/brightness_value.dart';
import 'package:belluga_boilerplate/domain/theme_data_settings/value_objects/use_material3_value.dart';
import 'package:belluga_boilerplate/domain/value_objects/color_required_value.dart';
import 'package:belluga_boilerplate/infrastructure/services/landlord_backend_contract.dart';
import 'package:flutter/material.dart';

class MockLandlordBackend extends LandlordBackendContract {
  @override
  Future<bool> isInitialized() async {
    await Future.delayed(Duration(seconds: 2));
    return Future.value(false);
  }

  @override
  Future<Landlord> getLandlord() async {
    return Landlord(
      nameValue: LandlordNameValue()..parse("Belluga NOW"),
      logoSettings: LogoSettings(
        lightLogoUri: LogoUriValue()
          ..parse(
              "https://logodownload.org/wp-content/uploads/2018/08/aurora-logo-0.png"),
        lightIconUri: LogoUriValue()
          ..parse(
              "https://logodownload.org/wp-content/uploads/2018/08/aurora-logo-0.png"),
      ),
      themeDataSettings: ThemeDataSettings(
        darkSchemeData: ColorSchemeData(
          brightnessValue: BrightnessValue()..parse("dark"),
          primarySeedColorValue: ColorRequiredValue(defaultValue: Colors.black),
          secondarySeedColorValue:
              ColorRequiredValue(defaultValue: Colors.orange),
        ),
        lightSchemeData: ColorSchemeData(
          brightnessValue: BrightnessValue()..parse("light"),
          primarySeedColorValue:
              ColorRequiredValue(defaultValue: Colors.orange),
          secondarySeedColorValue:
              ColorRequiredValue(defaultValue: Colors.black),
        ),
        useMaterial3Value: UseMaterial3Value()..parse("true"),
      ),
    );
  }
}
