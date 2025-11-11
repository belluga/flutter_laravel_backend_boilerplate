import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:festou_app/domain/events/event_model.dart';
import 'package:festou_app/presentation/screens/event_item/controller/event_item_controller.dart';

class EventInfoOverlay extends StatefulWidget {
  final EventModel eventModel;

  const EventInfoOverlay({super.key, required this.eventModel});

  @override
  State<EventInfoOverlay> createState() => _EventInfoOverlayState();
}

class _EventInfoOverlayState extends State<EventInfoOverlay> {
  final _controller = GetIt.I.get<EventItemController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: const EdgeInsets.only(top: 16.0, bottom: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              BackButton(
                color: _controller.colorScheme.onSecondary,
              ),
              Expanded(
                child: Text(
                  widget.eventModel.title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton.filled(
                style: IconButton.styleFrom(
                  backgroundColor: _controller.colorScheme.onPrimaryContainer,
                  foregroundColor: _controller.colorScheme.onSecondary,
                ),
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                ),
              )
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.today),
                  Text(
                    "TER | 16 AGO | 2025 | 18:30",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      style: TextTheme.of(context).headlineMedium?.copyWith(
                            color: _controller.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                      widget.eventModel.title,
                      maxLines: 5,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chip(
                    color: WidgetStateProperty.all(_controller.colorScheme.onSecondaryContainer),
                    // backgroundColor:
                    //     _controller.colorScheme.onSecondaryContainer,
                    labelStyle: TextStyle(
                      color: _controller.colorScheme.secondaryContainer,
                    ),
                    label: Text(
                      "Categoria",
                      style: TextTheme.of(context).labelSmall,
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
