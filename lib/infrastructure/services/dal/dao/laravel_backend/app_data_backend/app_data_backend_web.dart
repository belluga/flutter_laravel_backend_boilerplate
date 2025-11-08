import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/laravel_backend/app_data_backend/app_data_backend_contract.dart';
import 'package:web/web.dart' as web;

// This is a top-level function that binds to the global JavaScript JSON.stringify.
@JS('JSON.stringify')
external JSString stringify(JSAny? value);

// --- REMOVED THE CUSTOM EventListenerOptions EXTENSION TYPE ---

class AppDataBackend implements AppDataBackendContract {
  @override
  Future<Map<String, dynamic>> fetch() {
    final completer = Completer<Map<String, dynamic>>();

    final listener = (web.Event event) {
      final customEvent = event as web.CustomEvent;
      final jsDetail = customEvent.detail;

      if (jsDetail != null) {
        final jsonString = stringify(jsDetail).toDart;
        final data = jsonDecode(jsonString) as Map<String, dynamic>;
        completer.complete(data);
      } else {
        completer.complete({});
      }
    }.toJS;

    // --- CORRECTED THIS CALL ---
    // Use the built-in `web.AddEventListenerOptions` from the web package.
    web.window.addEventListener(
      'brandingReady',
      listener,
      web.AddEventListenerOptions(once: true),
    );

    return completer.future;
  }
}