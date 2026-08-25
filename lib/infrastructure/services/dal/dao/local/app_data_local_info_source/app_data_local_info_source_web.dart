import 'dart:math';

import 'package:belluga_boilerplate/domain/app_data/value_object/platform_type_value.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/local/app_data_local_info_source/app_data_local_info_source_contract.dart';
import 'package:value_object_pattern/domain/value_objects/generic_string_value.dart';
import 'package:web/web.dart' as web;

class AppDataLocalInfoSource implements AppDataLocalInfoSourceContract {
  static const String _deviceIdStorageKey = 'belluga_device_id';

  @override
  Future<Map<String, dynamic>> getInfo() async {
    final platform = PlatformTypeValue()..parse("web");
    final deviceId = _loadOrCreateDeviceId();
    return {
      'platformType': platform,
      'port': GenericStringValue()..tryParse(web.window.location.port),
      'hostname': GenericStringValue()..parse(web.window.location.hostname),
      'href': GenericStringValue()..parse(web.window.location.href),
      'device': GenericStringValue()..parse("${platform.value}_$deviceId"),
    };
  }

  String _loadOrCreateDeviceId() {
    final storage = web.window.localStorage;
    final existing = storage.getItem(_deviceIdStorageKey);
    if (existing != null && existing.isNotEmpty) {
      return existing;
    }

    final deviceId = _generateDeviceId();
    storage.setItem(_deviceIdStorageKey, deviceId);
    return deviceId;
  }

  String _generateDeviceId() {
    final random = Random();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    return bytes
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();
  }
}
