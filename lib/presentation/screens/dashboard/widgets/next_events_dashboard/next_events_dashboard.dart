import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value_builder.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/domain/schedule/event_model.dart';
import 'package:belluga_boilerplate/presentation/common/widgets/calendar_box.dart';
import 'package:belluga_boilerplate/presentation/common/widgets/dashboard_items_summary.dart';
import 'package:belluga_boilerplate/presentation/screens/dashboard/controllers/next_events_dashboard_controller.dart';

class NextEventsDashboard extends StatefulWidget {
  const NextEventsDashboard({super.key});

  @override
  State<NextEventsDashboard> createState() => _NextEventsDashboardState();
}

class _NextEventsDashboardState extends State<NextEventsDashboard> {
  late NextEventsDashboardController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GetIt.I.registerSingleton(NextEventsDashboardController());
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return StreamValueBuilder<List<EventModel>?>(
        streamValue: _controller.nextEventsStreamValue,
        builder: (context, evemts) {
          return AnimatedSlide(
            offset: evemts != null ? Offset.zero : Offset(1, 0),
            duration: Duration(milliseconds: 300),
            child: DashboardItemsSummary(
              title: "Próximos Eventos",
              itemsPerRow: 1.2,
              onShowAllPressed: _navigateToSchedule,
              showAllLabel: "Ver todos",
              itemsBuilder: _itemsBuilder,
            ),
          );
        });
  }

  Widget? _itemsBuilder(BuildContext context, int index) {
    final List<EventModel> _events =
        _controller.nextEventsStreamValue.value ?? [];

    if (index >= _events.length) {
      return null;
    }

    final EventModel _currentEvent = _events[index];

    return Card.filled(
      color: Theme.of(context).colorScheme.surfaceDim,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            CalendarBox(date: _currentEvent.dateTimeStart.value!),
            SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_currentEvent.type.name.value,
                      style: Theme.of(context).textTheme.bodySmall),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _currentEvent.title.value,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSchedule() => context.router.push(const ScheduleRoute());

  @override
  void dispose() {
    super.dispose();
    GetIt.I.unregister<NextEventsDashboardController>();
  }
}
