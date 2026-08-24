import 'package:event_tracker_handler/event_tracker_handler.dart';

abstract class TelemetryRepositoryContract {
  Future<bool> logEvent(
    EventTrackerEvents type, {
    String? eventName,
    Map<String, dynamic>? properties,
    String? idempotencyKey,
  });

  Future<bool> mergeIdentity({required String previousUserId});
}
