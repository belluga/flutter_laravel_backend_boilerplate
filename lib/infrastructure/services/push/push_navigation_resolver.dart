import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:push_handler/push_handler.dart';

class BoilerplatePushNavigationResolver {
  const BoilerplatePushNavigationResolver({required this.router});

  final RootStackRouter router;

  Future<void> resolve(PushRouteRequest request) async {
    final eventId = eventIdFromRequest(request);
    if (_isEventRequest(request) && eventId != null) {
      await router.navigate(EventItemRoute(eventId: eventId));
      return;
    }

    // Invite routes and arbitrary backend paths are intentionally ignored until
    // the boilerplate exposes an owned surface for them.
  }

  String? eventIdFromRequest(PushRouteRequest request) {
    return _eventId(request);
  }

  bool _isEventRequest(PushRouteRequest request) {
    final routeKey = request.routeKey?.trim().toLowerCase();
    if (routeKey == 'event' || routeKey == 'event_detail') {
      return true;
    }
    return request.route.startsWith('/agenda/');
  }

  String? _eventId(PushRouteRequest request) {
    final explicit = request.pathParameters['event_id'] ?? request.itemKey;
    if (explicit != null && explicit.trim().isNotEmpty) {
      return explicit.trim();
    }

    final segments = Uri.tryParse(request.route)?.pathSegments ?? const [];
    final agendaIndex = segments.indexOf('agenda');
    if (agendaIndex >= 0 && agendaIndex + 1 < segments.length) {
      final candidate = segments[agendaIndex + 1].trim();
      return candidate.isEmpty ? null : candidate;
    }
    return null;
  }
}
