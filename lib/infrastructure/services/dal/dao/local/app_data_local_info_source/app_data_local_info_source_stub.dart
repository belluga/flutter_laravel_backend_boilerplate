import 'dart:io';
import 'dart:math';

import 'package:belluga_boilerplate/domain/app_data/value_object/platform_type_value.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/local/app_data_local_info_source/app_data_local_info_source_contract.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:value_object_pattern/domain/value_objects/generic_string_value.dart';

class AppDataLocalInfoSource implements AppDataLocalInfoSourceContract {
  static const String _deviceIdFileName = 'device_id.txt';

  @override
  Future<Map<String, dynamic>> getInfo() async {
    final platform = PlatformTypeValue()..parse("mobile");
    final packageInfo = await PackageInfo.fromPlatform();
    final deviceId = await _loadOrCreateDeviceId();

    return {
      'platformType': platform,
      'port': GenericStringValue()..tryParse(packageInfo.version),
      'hostname': GenericStringValue()..parse(packageInfo.packageName),
      'href': GenericStringValue()..parse(packageInfo.appName),
      'device': GenericStringValue()..parse("${platform.value}_$deviceId"),
    };
  }

  Future<String> _loadOrCreateDeviceId() async {
    final directory = await getApplicationSupportDirectory();
    final file = File('${directory.path}/$_deviceIdFileName');

    if (await file.exists()) {
      final existing = (await file.readAsString()).trim();
      if (existing.isNotEmpty) {
        return existing;
      }
    }

    final deviceId = _generateDeviceId();
    await file.writeAsString(deviceId, flush: true);
    return deviceId;
  }

  String _generateDeviceId() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    return bytes
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();
  }
}
