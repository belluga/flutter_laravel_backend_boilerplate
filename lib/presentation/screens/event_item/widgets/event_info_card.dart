import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:festou_app/domain/events/event_model.dart';
import 'package:festou_app/presentation/screens/event_item/controller/event_item_controller.dart';

class EventInfoCard extends StatefulWidget {
  final String title;
  final EventModel eventModel;

  const EventInfoCard(
      {super.key, required this.eventModel, required this.title});

  @override
  State<EventInfoCard> createState() => _EventInfoCardState();
}

class _EventInfoCardState extends State<EventInfoCard> {
  final _controller = GetIt.I.get<EventItemController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _controller.colorScheme.surfaceContainer,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.message,
                  color: _controller.colorScheme.onSurface,
                ),
                SizedBox(width: 8),
                Expanded(
                    child: Text(
                  widget.title,
                  style: TextStyle(
                    color: _controller.colorScheme.onSurface,
                  ),
                )),
              ],
            ),
            Divider(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.eventModel.description,
                    style: TextStyle(
                      color: _controller.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: _controller.colorScheme.onPrimaryContainer,
                  ),
                  onPressed: () {}, child: Text("Saiba Mais"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
