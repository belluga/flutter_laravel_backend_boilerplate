import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:stream_value/core/stream_value_builder.dart';
import 'package:unifast_portal/presentation/screens/schedule/controller/date_row_controller.dart';
import 'package:unifast_portal/presentation/screens/schedule/widgets/dates_row.dart';

@RoutePage()
class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {

  late DateRowController _rowDateController;

  @override
  void initState() {
    super.initState();
    _rowDateController = GetIt.I.registerSingleton(DateRowController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agenda"),
      ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.surfaceDim,
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              children: [
                Expanded(
                  child: StreamValueBuilder<DateTime>(
                    streamValue: _rowDateController.firsVisibleDateStreamValue,
                    builder: (context, firstDate) {
                      final currentVisibleMonth = DateFormat.MMMM().format(firstDate);
                      final capitalizedMonth = currentVisibleMonth[0].toUpperCase() + currentVisibleMonth.substring(1);
                      return Text(capitalizedMonth);
                    }
                  ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
              ],
            ),
          ),
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
