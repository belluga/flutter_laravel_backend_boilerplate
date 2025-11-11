import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:belluga_boilerplate/domain/schedule/event_model.dart';
import 'package:belluga_boilerplate/presentation/screens/event_item/controller/event_item_controller.dart';

class EventInfoOverlay extends StatefulWidget {
  final EventModel eventModel;

  const EventInfoOverlay({super.key, required this.eventModel});

  @override
  State<EventInfoOverlay> createState() => _EventInfoOverlayState();
}

class _EventInfoOverlayState extends State<EventInfoOverlay> {
  final _controller = GetIt.I.get<EventItemController>();

  String get _formattedDate {
    final date = widget.eventModel.dateTimeStart.value;
    if (date == null) return '';
    final day = DateFormat.E().format(date).toUpperCase();
    final fullDate = DateFormat('dd MMM yyyy', 'pt_BR').format(date);
    final hour = DateFormat.Hm().format(date);
    return '$day | $fullDate | $hour';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = _controller.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(top: 16, bottom: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              BackButton(color: colorScheme.onSecondary),
              Expanded(
                child: Text(
                  widget.eventModel.title.value,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextTheme.of(context).titleMedium?.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                ),
              ),
              IconButton.filled(
                style: IconButton.styleFrom(
                  backgroundColor: colorScheme.onPrimaryContainer,
                  foregroundColor: colorScheme.onSecondary,
                ),
                onPressed: () {},
                icon: const Icon(Icons.share),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.today),
                  const SizedBox(width: 8),
                  Text(_formattedDate),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                widget.eventModel.title.value,
                maxLines: 5,
                textAlign: TextAlign.center,
                style: TextTheme.of(context).headlineMedium?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Chip(
                backgroundColor: colorScheme.onSecondaryContainer,
                labelStyle: TextStyle(color: colorScheme.secondaryContainer),
                label: Text(
                  widget.eventModel.type.name.value,
                  style: TextTheme.of(context).labelSmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
