import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:belluga_boilerplate/presentation/screens/event_item/controller/event_item_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/event_item/widgets/event_thumb_overlay.dart';

class HeaderBackground extends StatefulWidget {
  const HeaderBackground({super.key});

  @override
  State<HeaderBackground> createState() => _HeaderBackgroundState();
}

class _HeaderBackgroundState extends State<HeaderBackground> {

  final _controller = GetIt.I.get<EventItemController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _controller.colorScheme.primary,
      ),
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _controller.colorScheme.onPrimaryContainer.withAlpha(255),
            _controller.colorScheme.onPrimaryContainer.withAlpha(0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: const [0.0, 0.8],
        ),
      ),
      child: EventThumbOverlay(
        eventModel: _controller.eventModel,
      ),
    );
  }
}
