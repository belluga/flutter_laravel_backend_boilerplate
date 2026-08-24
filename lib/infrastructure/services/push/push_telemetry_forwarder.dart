import 'package:belluga_boilerplate/domain/repositories/telemetry_repository_contract.dart';
import 'package:event_tracker_handler/event_tracker_handler.dart';
import 'package:push_handler/push_handler.dart';

class PushTelemetryForwarder {
  const PushTelemetryForwarder({required this.telemetryRepository});

  final TelemetryRepositoryContract telemetryRepository;

  Future<void> forward(PushEvent event) {
    return telemetryRepository.logEvent(
      _mapEvent(event.type),
      eventName: 'push_${event.type}',
      idempotencyKey: _idempotencyKey(event),
      properties: {
        'push_id': event.pushId,
        if (event.messageInstanceId != null)
          'message_instance_id': event.messageInstanceId,
        if (event.stepSlug != null) 'step_slug': event.stepSlug,
        if (event.stepType != null) 'step_type': event.stepType,
        if (event.buttonKey != null) 'button_key': event.buttonKey,
        if (event.actionType != null) 'action_type': event.actionType,
        if (event.routeKey != null) 'route_key': event.routeKey,
        'app_state': event.appState,
        'source': event.source,
        'timestamp': event.timestamp.toIso8601String(),
        ...?event.metadata,
      },
    ).then((_) {});
  }

  EventTrackerEvents _mapEvent(String type) {
    switch (type) {
      case 'button_tap':
        return EventTrackerEvents.buttonClick;
      case 'submit':
        return EventTrackerEvents.selectItem;
      case 'delivered':
      case 'opened':
      default:
        return EventTrackerEvents.viewContent;
    }
  }

  String _idempotencyKey(PushEvent event) {
    return [
      'push',
      event.type,
      event.pushId,
      event.messageInstanceId ?? '',
      event.stepSlug ?? '',
      event.buttonKey ?? '',
    ].join(':');
  }
}
