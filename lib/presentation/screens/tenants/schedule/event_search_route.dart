import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/schedule_module.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/schedule/screens/event_search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

@RoutePage()
class EventSearchRoute extends StatelessWidget {
  final bool autoFocusSearchField;

  const EventSearchRoute({
    super.key,
    this.autoFocusSearchField = true,
  });

  @override
  Widget build(BuildContext context) {
    return ModuleScope<ScheduleModule>(
      child: EventSearchScreen(
        autoFocusSearchField: autoFocusSearchField,
      ),
    );
  }
}
