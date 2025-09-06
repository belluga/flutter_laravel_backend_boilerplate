import 'dart:ui';

import 'package:belluga_boilerplate/domain/app_data/app_data.dart';
import 'package:belluga_boilerplate/domain/tenant/tenant.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/theme_repository.dart';
import 'package:belluga_boilerplate/infrastructure/services/backend_contract.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

abstract class TenantRepositoryContract {
  BackendContract get backend;
  ThemeRepository get themeRepository => GetIt.I.get<ThemeRepository>();
  AppData get appData;

  Tenant? tenant;

  String get landlordDomain => dotenv.env["LANDLORD_DOMAIN"]!;

  Future<void> init() async {
    final _tenant = await _getTenant();
    _setTenant(_tenant);
    themeRepository.init(_tenant.themeDataSettings);
    themeRepository.setTheme(Brightness.light);
  }

  bool get isLandlordRequest => landlordDomain == appData.hostname;

  bool get isProperTenantRegistered {
    final Tenant? _tenant = tenant;

    if (_tenant == null) {
      return false;
    }
    return _tenant.hasDomain(appData.hostname);
  }

  Future<Tenant> _getTenant() async {
    final _tenant = await backend.tenant.getTenant().catchError((error) {
      throw Exception("Failed to retrieve tenant: $error");
    });
    return _tenant;
  }

  void _setTenant(Tenant newTenant) => tenant = newTenant;

  void clearTenant() {
    tenant = null;
  }
}
