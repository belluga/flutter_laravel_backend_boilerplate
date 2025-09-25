import 'package:belluga_boilerplate/domain/environment/environment.dart';
import 'package:belluga_boilerplate/infrastructure/services/environment_backend_contract.dart';

class MockEnvironmentBackend extends EnvironmentBackendContract {

  @override
  late Environment environment;

  @override
  Future<void> getEnvironment() async {

    // environment = Environment.fromJson({
    //   "name": "Belluga Tenant",
    //   "subdomain": "belluga",
    //   "type": "tenant",
    //   "main_domain": "belluga.com",
    //   "theme_data_settings": {
    //     "dark_scheme_data": {
    //       "brightness": "dark",
    //       "primary_seed_color": "007FF9",
    //       "secondary_seed_color": "00E6B8"
    //     },
    //     "light_scheme_data": {
    //       "brightness": "light",
    //       "primary_seed_color": "FFFFFF",
    //       "secondary_seed_color": "007FF9"
    //     },
    //     "use_material3": "true"
    //   },
    //   "domains": [
    //     // "https://guarappari.com.br"
    //   ],
    //   "app_domains": [
    //     "com.boilerplatebellugatenant.app"
    //   ]
    // });

  environment = Environment.fromJson({
      "name": "Belluga Landlord",
      "subdomain": "belluga",
      "type": "landlord",
      "main_domain": "belluga.com",
      "theme_data_settings": {
        "dark_scheme_data": {
          "brightness": "dark",
          "primary_seed_color": "007FF9",
          "secondary_seed_color": "00E6B8"
        },
        "light_scheme_data": {
          "brightness": "light",
          "primary_seed_color": "FFFFFF",
          "secondary_seed_color": "007FF9"
        },
        "use_material3": "true"
      },
      "domains": [
        // "https://guarappari.com.br"
      ],
      "app_domains": [
        "com.boilerplatebellugatenant.app"
      ]
    });
  }
}
