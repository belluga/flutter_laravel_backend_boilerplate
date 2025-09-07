import 'package:web/web.dart' as web;

import 'package:belluga_boilerplate/domain/app_data/app_type.dart';

class AppData {
  final AppType appType = AppType.web;
  late String? port;
  late String hostname;
  late String href;
  late String device;

  Future<void> initialize() async {    
    port = web.window.location.port;
    hostname = web.window.location.hostname;
    href = web.window.location.href;
    device = "web";
  }

  String get schema => href.split(hostname).first;
}
