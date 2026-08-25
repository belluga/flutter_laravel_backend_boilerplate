import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'package:dio/dio.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/laravel_backend/app_data_backend/app_data_backend_contract.dart';
import 'package:web/web.dart' as web;

// This is a top-level function that binds to the global JavaScript JSON.stringify.
@JS('JSON.stringify')
external JSString stringify(JSAny? value);

// --- REMOVED THE CUSTOM EventListenerOptions EXTENSION TYPE ---

class AppDataBackend implements AppDataBackendContract {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Uri.base.origin,
    ),
  );

  @override
  Future<Map<String, dynamic>> fetch() async {
    final cachedData = _readCachedBranding();
    if (cachedData != null) {
      return cachedData;
    }

    final remoteData = await _fetchRemoteData();
    _cacheBranding(remoteData);
    return remoteData;
  }

  Future<Map<String, dynamic>> _fetchRemoteData() async {
    try {
      final response = await _dio.get('/api/v1/environment');
      return _normalizePayload(response.data);
    } on DioException {
      final eventData = await _waitForBrandingEvent();
      if (eventData != null) {
        return eventData;
      }

      rethrow;
    }
  }

  Future<Map<String, dynamic>?> _waitForBrandingEvent() {
    final completer = Completer<Map<String, dynamic>?>();
    Timer? timeout;
    late final JSFunction listener;

    listener = (web.Event event) {
      timeout?.cancel();
      web.window.removeEventListener('brandingReady', listener);

      final customEvent = event as web.CustomEvent;
      final jsDetail = customEvent.detail;

      if (jsDetail == null) {
        completer.complete(null);
        return;
      }

      try {
        final jsonString = stringify(jsDetail).toDart;
        final data = _normalizePayload(jsonDecode(jsonString));
        completer.complete(data);
      } catch (_) {
        completer.complete(null);
      }
    }.toJS;

    web.window.addEventListener(
      'brandingReady',
      listener,
      web.AddEventListenerOptions(once: true),
    );

    timeout = Timer(const Duration(milliseconds: 1500), () {
      web.window.removeEventListener('brandingReady', listener);
      if (!completer.isCompleted) {
        completer.complete(_readCachedBranding());
      }
    });

    return completer.future;
  }

  Map<String, dynamic>? _readCachedBranding() {
    final cachedDataString =
        web.window.localStorage.getItem('tenantBrandingData');
    if (cachedDataString == null || cachedDataString.isEmpty) {
      return null;
    }

    try {
      return jsonDecode(cachedDataString) as Map<String, dynamic>;
    } catch (_) {
      web.window.localStorage.removeItem('tenantBrandingData');
      return null;
    }
  }

  void _cacheBranding(Map<String, dynamic> data) {
    web.window.localStorage.setItem('tenantBrandingData', jsonEncode(data));
  }

  Map<String, dynamic> _normalizePayload(Object? payload) {
    if (payload is Map<String, dynamic>) {
      return payload;
    }

    if (payload is Map) {
      return Map<String, dynamic>.from(payload);
    }

    throw Exception('Could not retrieve branding data.');
  }
}
