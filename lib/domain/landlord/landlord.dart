import 'package:belluga_boilerplate/domain/landlord/value_objects/landlord_name_value.dart';
import 'package:belluga_boilerplate/domain/theme_data_settings/theme_data_settings.dart';

class Landlord {
  final LandlordNameValue nameValue;
  final ThemeDataSettings themeDataSettings;

  Landlord({
    required this.nameValue,
    required this.themeDataSettings,
  });
}
