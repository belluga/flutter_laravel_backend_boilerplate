import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unifast_portal/presentation/screens/schedule/controller/date_row_controller.dart';
import 'package:unifast_portal/presentation/screens/schedule/widgets/dates_row.dart';

@RoutePage()
class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
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
          Column(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    GetIt.I.unregister<DateRowController>();
  }
}
