import 'package:belluga_boilerplate/application/extensions/to_hex.dart';
import 'package:belluga_boilerplate/domain/tenant/tenant.dart';
import 'package:belluga_boilerplate/domain/tenant/value_objects/app_domain_value.dart';
import 'package:belluga_boilerplate/domain/tenant/value_objects/main_logo_url_value.dart';
import 'package:belluga_boilerplate/domain/tenant/value_objects/subdomain_value.dart';
import 'package:belluga_boilerplate/domain/tenant/value_objects/tenant_name_value.dart';
import 'package:belluga_boilerplate/domain/theme_data_settings/color_scheme_data.dart';
import 'package:belluga_boilerplate/domain/theme_data_settings/theme_data_settings.dart';
import 'package:belluga_boilerplate/domain/theme_data_settings/value_objects/brightness_value.dart';
import 'package:belluga_boilerplate/domain/theme_data_settings/value_objects/use_material3_value.dart';
import 'package:belluga_boilerplate/domain/value_objects/color_required_value.dart';
import 'package:belluga_boilerplate/infrastructure/services/tenant_backend_contract.dart';

class MockTenantBackend extends TenantBackendContract {
  @override
  Future<Tenant> getTenant() async {
    return Tenant(
        name: TenantNameValue()..parse("Belluga Tenant"),
        mainLogoUrl: MainLogoUrlValue()
          ..parse(
              "https://logodownload.org/wp-content/uploads/2018/08/aurora-logo-0.png"),
        subdomain: SubdomainValue()..parse("belluga"),
        themeDataSettings: ThemeDataSettings(
          darkSchemeData: ColorSchemeData(
            brightnessValue: BrightnessValue()..parse("dark"),
            primarySeedColorValue:
                ColorRequiredValue(defaultValue: "007FF9".toColor()),
            secondarySeedColorValue:
                ColorRequiredValue(defaultValue: "00E6B8".toColor()),
          ),
          lightSchemeData: ColorSchemeData(
            brightnessValue: BrightnessValue()..parse("light"),
            primarySeedColorValue:
                ColorRequiredValue(defaultValue: "FFFFFF".toColor()),
            secondarySeedColorValue:
                ColorRequiredValue(defaultValue: "007FF9".toColor()),
          ),
          useMaterial3Value: UseMaterial3Value()..parse("true"),
        ),
        domains: [
          // DomainValue()..parse("https://guarappari.com.br"),
        ],
        appDomains: [
          AppDomainValue()..parse("com.boilerplatebellugatenant.app"),
        ]);
  }
}
