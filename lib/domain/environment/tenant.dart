import 'package:belluga_boilerplate/domain/environment/environment.dart';
import 'package:belluga_boilerplate/domain/environment/value_objects/app_domain_value.dart';
import 'package:belluga_boilerplate/domain/environment/value_objects/domain_value.dart';
import 'package:belluga_boilerplate/domain/environment/value_objects/subdomain_value.dart';
import 'package:belluga_boilerplate/domain/environment/value_objects/environment_name_value.dart';
import 'package:belluga_boilerplate/domain/theme_data_settings/theme_data_settings.dart';

class Tenant extends Environment {
  final SubdomainValue subdomain;
  final List<DomainValue>? domains;
  final List<AppDomainValue>? appDomains;

  Tenant({
    required super.nameValue,
    required super.themeDataSettings,
    required this.subdomain,
    required super.mainDomainValue,
    this.domains,
    this.appDomains,
  });

  factory Tenant.fromJson(Map<String, dynamic> json) {
    return Tenant(
      nameValue: EnvironmentNameValue()..parse(json['name']),
      subdomain: SubdomainValue()..parse(json['subdomain']),
      mainDomainValue:
          DomainValue(defaultValue: Uri.parse(json['main_domain'])),
      themeDataSettings:
          ThemeDataSettings.fromJson(json['theme_data_settings']),
      domains: (json['domains'] as List<dynamic>?)
              ?.map((domain) =>
                  DomainValue(defaultValue: Uri.parse(json['main_domain'])))
              .toList() ??
          [],
      appDomains: (json['app_domains'] as List<dynamic>)
          .map((appDomain) => AppDomainValue()..parse(appDomain))
          .toList(),
    );
  }
}
