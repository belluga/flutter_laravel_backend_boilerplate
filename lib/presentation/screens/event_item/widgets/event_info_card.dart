import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:belluga_boilerplate/domain/schedule/event_model.dart';
import 'package:belluga_boilerplate/presentation/screens/event_item/controller/event_item_controller.dart';

class EventInfoCard extends StatefulWidget {
  final String title;
  final EventModel eventModel;

  const EventInfoCard({
    super.key,
    required this.eventModel,
    required this.title,
  });

  @override
  State<EventInfoCard> createState() => _EventInfoCardState();
}

class _EventInfoCardState extends State<EventInfoCard> {
  final _controller = GetIt.I.get<EventItemController>();

  String get _contentAsText =>
      widget.eventModel.content.value?.replaceAll(RegExp(r'<[^>]*>'), '') ??
      '';

  @override
  Widget build(BuildContext context) {
    final colorScheme = _controller.colorScheme;

    return Card(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.message,
                  color: colorScheme.onSurface,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(color: colorScheme.onSurface),
                  ),
                ),
              ],
            ),
            const Divider(),
            Text(
              _contentAsText,
              style: TextStyle(color: colorScheme.onSurface),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: colorScheme.onPrimaryContainer,
                ),
                onPressed: () {},
                child: const Text("Saiba Mais"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
