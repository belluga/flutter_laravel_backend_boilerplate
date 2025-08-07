import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value_builder.dart';
import 'package:unifast_portal/domain/schedule/event_model.dart';
import 'package:unifast_portal/presentation/screens/schedule/controller/schedule_screen_controller.dart';
import 'package:unifast_portal/presentation/screens/schedule/widgets/dates_row.dart';

@RoutePage()
class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late ScheduleScreenController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GetIt.I.registerSingleton(ScheduleScreenController());
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agenda"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.surfaceDim,
                  child: DateRow(),
                ),
              ),
            ],
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: StreamValueBuilder<List<EventModel>>(
                      streamValue: _controller.eventsStreamValue,
                      onNullWidget: Center(child: CircularProgressIndicator(),),
                      builder: (context, events) {
                        return Column(
                          children: List.generate(
                            events.length,
                            (index) => ListTile(
                              title: Text(events[index].title.value),
                            ),
                          ),
                        );
                      }))),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    GetIt.I.unregister<ScheduleScreenController>();
  }
}
