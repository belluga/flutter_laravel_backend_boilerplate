import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value_builder.dart';
import 'package:unifast_portal/domain/schedule/event_model.dart';
import 'package:unifast_portal/presentation/screens/schedule/controller/schedule_screen_controller.dart';
import 'package:unifast_portal/presentation/screens/schedule/widgets/dates_row.dart';
import 'package:unifast_portal/presentation/screens/schedule/widgets/event_card.dart';

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
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: StreamValueBuilder<List<EventModel>>(
                      streamValue: _controller.eventsStreamValue,
                      onNullWidget: Center(
                        child: CircularProgressIndicator(),
                      ),
                      builder: (context, events) {
                        if (events.isEmpty) {
                          return Center(
                            child: Text("Nenhum evento encontrado."),
                          );
                        }
                  
                        return SingleChildScrollView(
                          padding: EdgeInsets.only(top: 16),
                          child: Column(
                            children: List.generate(
                              events.length,
                              (index) => EventCard(event: events[index]),
                            ),
                          ),
                        );
                      }),
                ),
              )),
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
