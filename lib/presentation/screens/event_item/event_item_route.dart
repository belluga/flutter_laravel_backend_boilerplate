import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/schedule_module.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';
import 'package:belluga_boilerplate/domain/schedule/event_model.dart';
import 'package:belluga_boilerplate/presentation/screens/event_item/screens/event_item_screen.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EventItemRoute
    extends ResolverRoute<EventModel, ScheduleModule> {
  const EventItemRoute({
    super.key,
    @PathParam('event_id') required this.eventId,
  });

  final String eventId;

  @override
  RouteResolverParams get resolverParams => {'event_id': eventId};

  @override
  Widget buildScreen(BuildContext context, EventModel model) {
    return EventItemScreen(event: model);
  }
}
