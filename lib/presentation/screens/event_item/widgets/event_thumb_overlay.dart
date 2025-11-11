import 'package:flutter/material.dart';
import 'package:belluga_boilerplate/presentation/common/widgets/image_with_progress_indicator.dart';
import 'package:belluga_boilerplate/domain/schedule/event_model.dart';

class EventThumbOverlay extends StatelessWidget {
  final EventModel eventModel;

  const EventThumbOverlay({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ImageWithProgressIndicator(
            uri: eventModel.thumb?.thumbUri.value,
            width: double.infinity,
            height: 260,
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ],
    );
  }
}
