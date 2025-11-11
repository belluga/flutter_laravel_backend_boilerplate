import 'package:flutter/material.dart';
import 'package:festou_app/domain/events/event_model.dart';

class EventThumbOverlay extends StatelessWidget {
  final EventModel eventModel;

  const EventThumbOverlay({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Image.network(eventModel.thumb.thumbUri.toString()),
          // decoration: BoxDecoration(
          //   color: Colors.black,
          //   image: DecorationImage(
          //     image: NetworkImage(
          //         eventModel.thumb.thumbUri.toString()),
          //     fit: BoxFit.contain,
          //   ),
          // ),
        ),
      ],
    );
  }
}
