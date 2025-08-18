import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarBox extends StatefulWidget {
  final DateTime date;

  const CalendarBox({super.key, required this.date});

  @override
  State<CalendarBox> createState() => _CalendarBoxState();
}

class _CalendarBoxState extends State<CalendarBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Text(
              DateFormat.MMM().format(widget.date).toUpperCase(),
              textAlign: TextAlign.center,
              style: TextTheme.of(context).labelLarge,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            child: Text(
              widget.date.day.toString(),
              textAlign: TextAlign.center,
              style: TextTheme.of(context).titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
