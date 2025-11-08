import 'package:belluga_boilerplate/domain/app_data/value_object/platform_type_value.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/local/app_data_local_info_source/app_data_local_info_source_contract.dart';
import 'package:value_object_pattern/domain/value_objects/generic_string_value.dart';
import 'package:web/web.dart' as web;

class AppDataLocalInfoSource implements AppDataLocalInfoSourceContract {
  @override
  Future<Map<String, dynamic>> getInfo() async {
    final platform = PlatformTypeValue()..parse("web");
    return {
      'platformType': platform,
      'port': GenericStringValue()..tryParse(web.window.location.port),
      'hostname': GenericStringValue()..parse(web.window.location.hostname),
      'href': GenericStringValue()..parse(web.window.location.href),
      'device': GenericStringValue()..parse("web"),
    };
  }
}