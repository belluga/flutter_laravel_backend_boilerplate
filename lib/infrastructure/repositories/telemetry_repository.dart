import 'dart:async';

import 'package:belluga_boilerplate/domain/repositories/auth_repository_contract.dart';
import 'package:belluga_boilerplate/domain/repositories/telemetry_repository_contract.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/app_data_repository.dart';
import 'package:belluga_boilerplate/infrastructure/services/telemetry/telemetry_queue.dart';
import 'package:event_tracker_handler/event_tracker_handler.dart';

class TelemetryRepository implements TelemetryRepositoryContract {
  TelemetryRepository({
    required AppDataRepository appDataRepository,
    required AuthRepositoryContract authRepository,
    TelemetryQueue? queue,
    EventTrackerHandlerContract? handler,
  })  : _appDataRepository = appDataRepository,
        _authRepository = authRepository,
        _queue = queue ?? TelemetryQueue(),
        _handler = handler;

  final AppDataRepository _appDataRepository;
  final AuthRepositoryContract _authRepository;
  final TelemetryQueue _queue;
  EventTrackerHandlerContract? _handler;
  StreamSubscription<dynamic>? _authSubscription;
  String? _pendingAnonymousIdentity;

  Future<void> init() async {
    _handler ??= EventTrackerHandler.instance(
      _appDataRepository.appData.telemetryTrackers,
    );
    await _handler!.init();

    if (!_authRepository.isUserLoggedIn) {
      _pendingAnonymousIdentity = _deviceId;
    }
    _authSubscription ??= _authRepository.userStreamValue.stream.listen((user) {
      if (user != null && _pendingAnonymousIdentity != null) {
        unawaited(
          mergeIdentity(previousUserId: _pendingAnonymousIdentity!),
        );
      }
    });
  }

  @override
  Future<bool> logEvent(
    EventTrackerEvents type, {
    String? eventName,
    Map<String, dynamic>? properties,
    String? idempotencyKey,
  }) async {
    final handler = _handler;
    if (handler == null ||
        (_appDataRepository.appData.telemetryTrackers.isEmpty &&
            handler.trackers.isEmpty)) {
      return false;
    }

    final user = _authRepository.userStreamValue.value;
    final userId = user?.uuidValue.value ?? _deviceId;
    final mergedProperties = <String, dynamic>{
      if (_appDataRepository.appData.tenantId != null)
        'tenant_id': _appDataRepository.appData.tenantId,
      if (user != null) 'user_id': userId,
      'source': properties?['source'] ?? 'unknown',
      ...?properties,
    };
    final payload = EventTrackerData(
      eventName: eventName,
      insertId: idempotencyKey,
      customData: mergedProperties,
    );
    final userData = EventTrackerUserData(
      uuid: userId,
      email: user?.profile.emailValue?.value,
      fullName: user?.profile.nameValue?.value,
      isAnonymous: user == null,
    );

    return _queue.enqueue(() async {
      final outcomes = await handler.logEvent(
        type: type,
        userData: userData,
        data: payload,
      );
      if (outcomes.any((outcome) => outcome.isFailure)) {
        throw StateError('Telemetry delivery failed');
      }
    });
  }

  @override
  Future<bool> mergeIdentity({required String previousUserId}) async {
    final handler = _handler;
    final user = _authRepository.userStreamValue.value;
    if (handler == null || user == null || previousUserId.isEmpty) {
      return false;
    }

    final userData = EventTrackerUserData(
      uuid: user.uuidValue.value,
      email: user.profile.emailValue?.value,
      fullName: user.profile.nameValue?.value,
      isAnonymous: false,
    );
    final success = await _queue.enqueue(() async {
      await handler.mergeIdentity(
        previousUserId: previousUserId,
        userData: userData,
      );
    });
    if (success && _pendingAnonymousIdentity == previousUserId) {
      _pendingAnonymousIdentity = null;
    }
    return success;
  }

  String get _deviceId {
    final value = _appDataRepository.appData.device.value?.trim();
    return value == null || value.isEmpty ? 'anonymous-device' : value;
  }
}
