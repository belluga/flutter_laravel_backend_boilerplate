import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/laravel_backend/app_data_backend/app_data_backend_contract.dart';
import 'package:web/web.dart' as web;

@JS()
@anonymous
extension type EventListenerOptions._(JSObject o) {
  external factory EventListenerOptions({JSBoolean? once});
}

class AppDataBackend implements AppDataBackendContract {
  @override
  Future<Map<String, dynamic>> fetch() {

    const String key = 'tenantBrandingData';
    final completer = Completer<Map<String, dynamic>>();

    final listener = (web.Event event) {

      final freshDataString = web.window.localStorage.getItem(key);

      if (freshDataString != null) {
        completer.complete(jsonDecode(freshDataString) as Map<String, dynamic>);
      } else {
        completer.completeError(
            StateError('brandingReady event fired but no data found.'));
      }
    }.toJS;

    web.window.addEventListener('brandingReady', listener,
        EventListenerOptions(once: true.toJS).jsify()!);

    return completer.future;
  }
}
