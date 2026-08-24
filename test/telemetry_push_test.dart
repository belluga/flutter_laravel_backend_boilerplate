import 'package:belluga_boilerplate/application/configurations/app_environment_fallback.dart';
import 'package:belluga_boilerplate/application/router/app_router.dart';
import 'package:belluga_boilerplate/domain/app_data/app_data.dart';
import 'package:belluga_boilerplate/domain/app_data/platform_type.dart';
import 'package:belluga_boilerplate/domain/app_data/value_object/platform_type_value.dart';
import 'package:belluga_boilerplate/domain/repositories/auth_repository_contract.dart';
import 'package:belluga_boilerplate/domain/repositories/telemetry_repository_contract.dart';
import 'package:belluga_boilerplate/domain/user/user_belluga.dart';
import 'package:belluga_boilerplate/domain/user/user_profile.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/app_data_repository.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/telemetry_repository.dart';
import 'package:belluga_boilerplate/infrastructure/services/auth_backend_contract.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/laravel_backend/app_data_backend/app_data_backend.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/local/app_data_local_cache/app_data_local_cache.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/local/app_data_local_info_source/app_data_local_info_source.dart';
import 'package:belluga_boilerplate/infrastructure/services/push/push_navigation_resolver.dart';
import 'package:belluga_boilerplate/infrastructure/services/push/push_telemetry_forwarder.dart';
import 'package:belluga_boilerplate/infrastructure/services/push/push_transport_configurator.dart';
import 'package:belluga_boilerplate/infrastructure/services/telemetry/telemetry_queue.dart';
import 'package:event_tracker_handler/event_tracker_handler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:push_handler/push_handler.dart';
import 'package:value_object_pattern/domain/value_objects/generic_string_value.dart';
import 'package:value_object_pattern/domain/value_objects/mongo_id_value.dart';

void main() {
  test('TelemetryQueue retries a failed job using the bounded sequence',
      () async {
    var attempts = 0;
    final queue = TelemetryQueue(
      retryDelays: const [Duration.zero, Duration.zero, Duration.zero],
    );

    final result = await queue.enqueue(() async {
      attempts += 1;
      if (attempts < 3) {
        throw StateError('transient');
      }
    });

    expect(result, isTrue);
    expect(attempts, 3);
  });

  test('TelemetryRepository attaches context and idempotency to delivery',
      () async {
    final handler = _RecordingEventTrackerHandler();
    final auth = _FakeAuthRepository();
    final repository = TelemetryRepository(
      appDataRepository: _appDataRepository(),
      authRepository: auth,
      handler: handler,
      queue: TelemetryQueue(retryDelays: const [Duration.zero]),
    );
    await repository.init();

    final result = await repository.logEvent(
      EventTrackerEvents.viewContent,
      eventName: 'event_opened',
      idempotencyKey: 'event-opened:event-1',
      properties: const {'source': 'push', 'event_id': 'event-1'},
    );

    expect(result, isTrue);
    expect(handler.lastData?.toMap(),
        containsPair(r'$insert_id', 'event-opened:event-1'));
    expect(handler.lastData?.customData, containsPair('tenant_id', 'tenant-1'));
    expect(handler.lastData?.customData, containsPair('event_id', 'event-1'));
    expect(handler.lastUser?.isAnonymous, isTrue);
  });

  test('push navigation extracts only owned event surfaces', () {
    final resolver = BoilerplatePushNavigationResolver(router: AppRouter());
    final eventRequest = PushRouteRequest(
      type: ButtonRouteType.internalRouteWithItem,
      route: '/unsupported',
      routeKey: 'event_detail',
      itemKey: 'event-1',
    );
    final routeRequest = PushRouteRequest(
      type: ButtonRouteType.internalRoute,
      route: '/agenda/event-2',
    );
    final inviteRequest = PushRouteRequest(
      type: ButtonRouteType.internalRoute,
      route: '/invite/1',
      routeKey: 'invite',
    );

    expect(resolver.eventIdFromRequest(eventRequest), 'event-1');
    expect(resolver.eventIdFromRequest(routeRequest), 'event-2');
    expect(resolver.eventIdFromRequest(inviteRequest), isNull);
  });

  test('TelemetryRepository merges the pending anonymous identity after login',
      () async {
    final handler = _RecordingEventTrackerHandler();
    final auth = _FakeAuthRepository();
    final repository = TelemetryRepository(
      appDataRepository: _appDataRepository(),
      authRepository: auth,
      handler: handler,
      queue: TelemetryQueue(retryDelays: const [Duration.zero]),
    );
    await repository.init();
    auth.setLoggedIn();
    await Future<void>.delayed(Duration.zero);

    expect(handler.lastPreviousUserId, 'web-test-device');
  });

  test(
      'push transport uses the canonical API base and bearer provider contract',
      () async {
    final auth = _FakeAuthRepository();
    final config = PushTransportConfigurator.build(
      appDataRepository: _appDataRepository(),
      authRepository: auth,
    );

    expect(config.resolvedBaseUrl, 'https://tenant.example.test/api/v1/');
    expect(await config.tokenProvider!(), isNull);
  });

  test('push events are forwarded with a stable idempotency key', () async {
    final telemetry = _RecordingTelemetryRepository();
    final forwarder = PushTelemetryForwarder(telemetryRepository: telemetry);

    await forwarder.forward(
      PushEvent(
        type: 'button_tap',
        pushId: 'push-1',
        messageInstanceId: 'message-1',
        buttonKey: 'open',
        appState: 'foreground',
        source: 'notification_tap',
        timestamp: DateTime.utc(2026, 8, 24),
      ),
    );

    expect(telemetry.type, EventTrackerEvents.buttonClick);
    expect(telemetry.idempotencyKey, 'push:button_tap:push-1:message-1::open');
    expect(telemetry.properties, containsPair('push_id', 'push-1'));
  });

  test('push package treats an ok=false payload as a no-op', () {
    const service = PushMessageDataService();

    expect(service.fromApiResponse(const {'ok': false}), isNull);
    expect(service.fromApiResponse(const {'ok': true}), isNull);
  });

  test('push package builds action idempotency from delivery identity', () {
    final client = PushTransportClient(
      const PushTransportConfig(baseUrl: 'https://tenant.example.test/api'),
    );

    expect(
      client.buildIdempotencyKey(
        pushMessageId: 'push-1',
        action: 'delivered',
        stepIndex: 0,
        deviceId: 'web-test-device',
        messageId: 'message-1',
      ),
      'action:message-1:delivered:0:none:web-test-device',
    );
  });
}

AppDataRepository _appDataRepository() {
  final repository = AppDataRepository(
    localCache: AppDataLocalCache(),
    backend: AppDataBackend(),
    localInfoSource: AppDataLocalInfoSource(),
  );
  repository.appData = AppData.fromInitialization(
    remoteData: <String, dynamic>{
      ...kLocalEnvironmentFallback,
      'type': 'tenant',
      'tenant_id': 'tenant-1',
      'main_domain': 'https://tenant.example.test',
      'telemetry_settings': <String, dynamic>{
        'trackers': <Map<String, dynamic>>[
          <String, dynamic>{
            'type': 'EventTrackerType.webhook',
            'url': 'https://telemetry.example.test/events',
            'track_all': true,
          },
        ],
      },
    },
    localInfo: <String, dynamic>{
      'platformType': PlatformTypeValue(defaultValue: PlatformType.web),
      'port': GenericStringValue(defaultValue: '443'),
      'hostname': GenericStringValue(defaultValue: 'tenant.example.test'),
      'href': GenericStringValue(defaultValue: 'https://tenant.example.test'),
      'device': GenericStringValue(defaultValue: 'web-test-device'),
    },
  );
  return repository;
}

final class _FakeAuthRepository extends AuthRepositoryContract<UserBelluga> {
  void setLoggedIn() {
    userStreamValue.addValue(
      UserBelluga(
        uuidValue: MongoIDValue()..parse('507f1f77bcf86cd799439011'),
        profile: UserProfile(),
      ),
    );
  }

  @override
  AuthBackendContract get authBackend => throw UnimplementedError();

  @override
  bool get isAuthorized => userStreamValue.value != null;

  @override
  bool get isUserLoggedIn => userStreamValue.value != null;

  @override
  String get userToken => 'test-token';

  @override
  Future<void> autoLogin() async {}

  @override
  Future<void> createNewPassword(
      String newPassword, String confirmPassword) async {}

  @override
  Future<void> init() async {}

  @override
  Future<void> loginWithEmailPassword(String email, String password) async {}

  @override
  Future<void> logout() async {}

  @override
  Future<void> sendPasswordResetEmail(String email) async {}

  @override
  Future<void> sendTokenRecoveryPassword(
      String email, String codigoEnviado) async {}

  @override
  Future<void> signUpWithEmailPassword(String email, String password) async {}

  @override
  Future<void> updateUser(Map<String, Object?> data) async {}
}

final class _RecordingEventTrackerHandler extends EventTrackerHandlerContract {
  EventTrackerData? lastData;
  EventTrackerUserData? lastUser;
  String? lastPreviousUserId;

  @override
  List<EventTrackerContract> get trackers => const [];

  @override
  Future<void> init() async {}

  @override
  Future<void> mergeIdentity({
    required String previousUserId,
    required EventTrackerUserData userData,
  }) async {
    lastPreviousUserId = previousUserId;
  }

  @override
  Future<void> timeEvent(EventTrackerEvents type, {String? eventName}) async {}

  @override
  Future<List<EventTrackerDeliveryOutcome>> logEvent({
    required EventTrackerEvents type,
    required EventTrackerUserData userData,
    EventTrackerData? data,
  }) async {
    lastData = data;
    lastUser = userData;
    return [
      EventTrackerDeliveryOutcome(
        trackerType: EventTrackerType.webhook,
        status: EventTrackerDeliveryStatus.delivered,
      ),
    ];
  }
}

final class _RecordingTelemetryRepository
    implements TelemetryRepositoryContract {
  EventTrackerEvents? type;
  String? idempotencyKey;
  Map<String, dynamic>? properties;

  @override
  Future<bool> logEvent(
    EventTrackerEvents type, {
    String? eventName,
    Map<String, dynamic>? properties,
    String? idempotencyKey,
  }) async {
    this.type = type;
    this.properties = properties;
    this.idempotencyKey = idempotencyKey;
    return true;
  }

  @override
  Future<bool> mergeIdentity({required String previousUserId}) async => true;
}
