import 'package:belluga_boilerplate/domain/app_data/environment_type.dart';
import 'package:belluga_boilerplate/domain/app_data/value_object/app_domain_value.dart';
import 'package:belluga_boilerplate/domain/app_data/value_object/domain_value.dart';
import 'package:belluga_boilerplate/domain/app_data/value_object/environment_name_value.dart';
import 'package:belluga_boilerplate/domain/app_data/value_object/environment_type_value.dart';
import 'package:belluga_boilerplate/domain/app_data/value_object/platform_type_value.dart';
import 'package:belluga_boilerplate/domain/theme_data_settings/theme_data_settings.dart';
import 'package:event_tracker_handler/event_tracker_handler.dart';
import 'package:value_object_pattern/domain/value_objects/generic_string_value.dart';

/// A pure data model that holds all application configuration.
/// It has no knowledge of how its data is fetched or stored.
class AppData {
  // --- Final, Initialized Fields ---
  final PlatformTypeValue platformType;
  final GenericStringValue? port;
  final GenericStringValue hostname;
  final GenericStringValue href;
  final GenericStringValue device;
  final EnvironmentNameValue nameValue;
  final EnvironmentTypeValue typeValue;
  final ThemeDataSettings themeDataSettings;
  final DomainValue mainDomainValue;
  final List<DomainValue>? domains;
  final List<AppDomainValue>? appDomains;
  final String? tenantId;
  final Map<String, dynamic>? firebaseSettings;
  final List<EventTrackerSettingsModel> telemetryTrackers;

  AppData._({
    required this.platformType,
    this.port,
    required this.hostname,
    required this.href,
    required this.device,
    required this.nameValue,
    required this.typeValue,
    required this.themeDataSettings,
    required this.mainDomainValue,
    this.domains,
    this.appDomains,
    this.tenantId,
    this.firebaseSettings,
    this.telemetryTrackers = const [],
  });

  factory AppData.fromInitialization({
    required Map<String, dynamic> remoteData,
    required Map<String, dynamic> localInfo,
  }) {
    return AppData._(
      platformType: localInfo['platformType'],
      port: localInfo['port'],
      hostname: localInfo['hostname'],
      href: localInfo['href'],
      device: localInfo['device'],
      nameValue: EnvironmentNameValue()..parse(remoteData['name']),
      themeDataSettings:
          ThemeDataSettings.fromJson(remoteData['theme_data_settings']),
      mainDomainValue:
          DomainValue(defaultValue: Uri.parse(remoteData['main_domain'])),
      typeValue: EnvironmentTypeValue()..parse(remoteData['type']),
      domains: (remoteData['domains'] as List<dynamic>?)
              ?.map((domain) => DomainValue(defaultValue: Uri.parse(domain)))
              .toList() ??
          [],
      appDomains: (remoteData['app_domains'] as List<dynamic>?)
          ?.map((appDomain) => AppDomainValue()..parse(appDomain))
          .toList(),
      tenantId: _readOptionalString(
          remoteData['tenant_id'] ?? remoteData['tenantId']),
      firebaseSettings: _readOptionalMap(
        remoteData['firebase_settings'] ?? remoteData['firebase'],
      ),
      telemetryTrackers: _parseTelemetryTrackers(
        remoteData['telemetry_settings'] ?? remoteData['telemetry'],
      ),
    );
  }

  static String? _readOptionalString(Object? value) {
    final resolved = value?.toString().trim();
    return resolved == null || resolved.isEmpty ? null : resolved;
  }

  static Map<String, dynamic>? _readOptionalMap(Object? value) {
    if (value is Map<String, dynamic>) {
      return Map<String, dynamic>.from(value);
    }
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }
    return null;
  }

  static List<EventTrackerSettingsModel> _parseTelemetryTrackers(
      Object? value) {
    final rawTrackers =
        value is Map ? value['trackers'] ?? value['providers'] : value;
    if (rawTrackers is! List) {
      return const [];
    }

    final trackers = <EventTrackerSettingsModel>[];
    for (final rawTracker in rawTrackers) {
      final tracker = _readOptionalMap(rawTracker);
      if (tracker == null || tracker['type'] == null) {
        continue;
      }
      try {
        trackers.add(EventTrackerSettingsModel.fromMap(tracker));
      } catch (_) {
        // Invalid optional telemetry configuration must not block app startup.
      }
    }
    return trackers;
  }

  bool get isTenant => typeValue.value == EnvironmentType.tenant;

  //TODO: check if system is initialized
  bool get isSystemActive => typeValue.value.runtimeType == EnvironmentType;
}
