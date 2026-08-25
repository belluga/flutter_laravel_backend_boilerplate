import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';
import 'package:belluga_boilerplate/domain/repositories/schedule_repository_contract.dart';
import 'package:belluga_boilerplate/domain/schedule/event_model.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

class EventItemRouteResolver
    implements RouteModelResolver<EventModel> {
  EventItemRouteResolver({@visibleForTesting ScheduleRepositoryContract? scheduleRepository})
      : _scheduleRepository = scheduleRepository ?? GetIt.I.get<ScheduleRepositoryContract>();

  final ScheduleRepositoryContract _scheduleRepository;

  @override
  @override
  Future<EventModel> resolve(RouteResolverParams params) {
    final eventId = params['event_id'] as String?;
    if (eventId == null || eventId.isEmpty) {
      throw ArgumentError.value(
        eventId,
        'event_id',
        'Event ID must be provided',
      );
    }
    return _scheduleRepository.getEvent(eventId);
  }
}
