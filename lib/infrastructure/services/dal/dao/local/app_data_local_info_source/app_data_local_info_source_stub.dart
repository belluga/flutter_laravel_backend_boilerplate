import 'package:belluga_boilerplate/domain/app_data/value_object/platform_type_value.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/local/app_data_local_info_source/app_data_local_info_source_contract.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:platform_device_id_plus/platform_device_id.dart';
import 'package:value_object_pattern/domain/value_objects/generic_string_value.dart';

class AppDataLocalInfoSource implements AppDataLocalInfoSourceContract {
  @override
  Future<Map<String, dynamic>> getInfo() async {
    final platform = PlatformTypeValue()..parse("mobile");
    final packageInfo = await PackageInfo.fromPlatform();
    final deviceId = await PlatformDeviceId.getDeviceId ?? "unknown_device";

    return {
      'platformType': platform,
      'port': GenericStringValue()..tryParse(packageInfo.version),
      'hostname': GenericStringValue()..parse(packageInfo.packageName),
      'href': GenericStringValue()..parse(packageInfo.appName),
      'device': GenericStringValue()..parse("${platform.value}_$deviceId"),
    };
  }
}