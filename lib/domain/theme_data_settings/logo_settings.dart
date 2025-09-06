import 'package:belluga_boilerplate/domain/tenant/value_objects/logo_url_value.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LogoSettings {
  late LogoUriValue darkLogoUri;
  late LogoUriValue lightLogoUri;
  late LogoUriValue darkIconUri;
  late LogoUriValue lightIconUri;

  LogoSettings({
    LogoUriValue? lightIconUri,
    LogoUriValue? lightLogoUri,
    LogoUriValue? darkIconUri,
    LogoUriValue? darkLogoUri,
  })  : assert(lightIconUri != null || darkIconUri != null,
            "At least one of lightIconUri or darkIconUri must be provided."),
        assert(lightLogoUri != null || darkLogoUri != null,
            "At least one of lightLogoUri or darkLogoUri must be provided.") {
    this.lightIconUri = lightIconUri ?? darkIconUri!;
    this.darkIconUri = darkIconUri ?? lightIconUri!;
    this.lightLogoUri = lightLogoUri ?? darkLogoUri!;
    this.darkLogoUri = darkLogoUri ?? lightLogoUri!;
  }

  Brightness? get brightness =>
      GetIt.I.get<ThemeRepository>().themeStreamValue.value?.brightness;

  LogoUriValue get logoUri {
    switch (brightness) {
      case Brightness.dark:
        return darkLogoUri;
      default:
        return lightLogoUri;
    }
  }

  LogoUriValue get iconUri {
    switch (brightness) {
      case Brightness.dark:
        return darkIconUri;
      default:
        return lightIconUri;
    }
  }
}
