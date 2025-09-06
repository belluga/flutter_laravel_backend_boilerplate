import 'package:belluga_boilerplate/domain/app_data/app_data.dart';
import 'package:belluga_boilerplate/domain/app_data/app_type.dart';
import 'package:belluga_boilerplate/domain/tenant/value_objects/app_domain_value.dart';
import 'package:belluga_boilerplate/domain/tenant/value_objects/domain_value.dart';
import 'package:belluga_boilerplate/domain/tenant/value_objects/subdomain_value.dart';
import 'package:belluga_boilerplate/domain/tenant/value_objects/tenant_name_value.dart';
import 'package:belluga_boilerplate/domain/theme_data_settings/logo_settings.dart';
import 'package:belluga_boilerplate/domain/theme_data_settings/theme_data_settings.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

class Tenant {
  final TenantNameValue name;
  final SubdomainValue subdomain;
  final List<DomainValue>? domains;
  final List<AppDomainValue>? appDomains;
  final LogoSettings logoSettings;
  final ThemeDataSettings themeDataSettings;

  Tenant({
    required this.name,
    required this.subdomain,
    required this.logoSettings,
    required this.themeDataSettings,
    this.domains,
    this.appDomains,
  });

  AppData get appData => GetIt.I.get<AppData>();

  String get landlordUrl => dotenv.env['LANDLORD_DOMAIN']!;

  String get subdomainFull => "${subdomain.value}.$landlordUrl";

  bool hasDomain(String domainTry) {
    switch (appData.appType) {
      case AppType.web:
        return hasWebDomain(domainTry);
      case AppType.mobile:
      case AppType.desktop:
        return hasAppDomain(domainTry);
    }
  }

  bool hasAppDomain(String domainTry) {
    return appDomains?.any((appDomain) {
          return appDomain.value == domainTry;
        }) ??
        false;
  }

  bool hasWebDomain(String domainTry) {
    final List<String> _splitted = domainTry.split(".$landlordUrl");

    if (_splitted.length == 1) {
      return domains?.any((domain) {
            return domain.value!.host == _splitted.first;
          }) ??
          false;
    }

    if (_splitted.length > 1) {
      return subdomainFull == domainTry;
    }

    return true;
  }
}
