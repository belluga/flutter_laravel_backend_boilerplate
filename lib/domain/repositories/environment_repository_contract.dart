import 'package:belluga_boilerplate/domain/app_data/app_data.dart';
import 'package:belluga_boilerplate/domain/environment/environment.dart';
import 'package:belluga_boilerplate/domain/environment/tenant.dart';
import 'package:belluga_boilerplate/infrastructure/services/environment_backend_contract.dart';
import 'package:flutter/foundation.dart';

abstract class EnvironmentRepositoryContract {

  EnvironmentBackendContract get environmentBackend;
  AppData get appData;

  Environment? _environment;
  Environment get environment => _environment!;

  Future<void> init() async {
    await getEnvironment();
  }

  bool get isProperTenantRegistered => _environment.runtimeType == Tenant;

  @protected
  Future<void> getEnvironment() async {
    await environmentBackend.getEnvironment();
    
    _environment = environmentBackend.environment;
  }

  void clearEnvironment() {
    _environment = null;
  }
}
