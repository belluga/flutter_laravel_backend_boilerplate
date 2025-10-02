import 'package:belluga_boilerplate/presentation/screens/tenants/schedule/widgets/event_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:belluga_boilerplate/domain/schedule/event_model.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/schedule/widgets/event_action_button.dart';

class EventCard extends StatefulWidget {
  final EventModel event;

  const EventCard({super.key, required this.event});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceDim,
      child: InkWell(
        onTap: () => _showEventBottomSheet(context, widget.event),
        child: Padding(
          padding: EdgeInsetsGeometry.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.event.title.value,
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
                      "Data: ${DateFormat.MMMMEEEEd().format(widget.event.dateTimeStart.value!)} às ${DateFormat.Hm().format(widget.event.dateTimeStart.value!)}h",
                      style: TextTheme.of(context).bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ],
              ),
              Html(
                data: widget.event.content.value,
                shrinkWrap: true,
              ),
              Wrap(
                spacing: 8,
                children: List.generate(
                    widget.event.actions.length,
                    (index) => EventActionButton(
                        eventAction: widget.event.actions[index])),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showEventBottomSheet(
      BuildContext context, EventModel event) async {
    FocusScope.of(context).requestFocus(FocusNode());

    await showModalBottomSheet(
      context: context,
      useSafeArea: false,
      builder: (_) => EventBottomSheet(event: event),
    );
  }
}