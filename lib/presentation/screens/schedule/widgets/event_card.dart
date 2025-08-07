import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:unifast_portal/domain/schedule/event_model.dart';

class EventCard extends StatelessWidget {
  final EventModel event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceDim,
      child: Padding(
        padding: EdgeInsetsGeometry.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    event.title.value,
                    style: TextTheme.of(context).titleMedium,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Data: ${DateFormat.MMMMEEEEd().format(event.dateTimeStart.value!)} às ${DateFormat.Hm().format(event.dateTimeStart.value!)}h",
                    style: TextTheme.of(context).bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ],
            ),
            Html(
              data: event.content.value,
              shrinkWrap: true,
            ),
            Wrap(
              spacing: 8,
              children: List.generate(event.actions.length, (index) {
                final _action = event.actions[index];

                final _buttonColor = _action.color?.value ??
                    Theme.of(context).colorScheme.secondary;

                final _foregroundColor =
                    ThemeData.estimateBrightnessForColor(_buttonColor) ==
                            Brightness.dark
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.surfaceDim;

                return ElevatedButton(
                    style: ButtonStyle(
                      visualDensity: VisualDensity.compact,
                      foregroundColor: WidgetStateColor.resolveWith(
                          (_) => _foregroundColor),
                      backgroundColor: WidgetStateProperty.resolveWith(
                          (states) =>
                              _action.color?.value ??
                              Theme.of(context).colorScheme.secondary),
                    ),
                    onPressed: () {},
                    child: Text(_action.label.value));
              }),
            ),
          ],
        ),
      ),
    );
  }
}
