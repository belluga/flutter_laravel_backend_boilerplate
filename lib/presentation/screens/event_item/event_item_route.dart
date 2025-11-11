import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/schedule_module.dart';
import 'package:belluga_boilerplate/presentation/screens/event_item/screens/event_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

@RoutePage()
class EventItemRoute extends StatelessWidget {
  final String eventId;

  const EventItemRoute({
    super.key,
    @PathParam('event_id') required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    return ModuleScope<ScheduleModule>(
      child: EventItemScreen(eventId: eventId),
    );
  }
}
