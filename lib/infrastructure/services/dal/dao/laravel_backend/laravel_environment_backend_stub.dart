import 'package:belluga_boilerplate/infrastructure/services/dal/dao/laravel_backend/laravel_environment_backend_contract.dart';


class LaravelEnvironmentBackend extends LaravelEnvironmentBackendContract {

  @override
  String get getEnvironmentEndpoint =>
      "$landlordUrl/environment?app_domain=${packageInfo.packageName}";
}
