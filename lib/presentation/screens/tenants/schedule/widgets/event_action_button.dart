import 'package:flutter/material.dart';
import 'package:belluga_boilerplate/domain/schedule/event_action_model/event_action_model.dart';

class EventActionButton extends StatefulWidget {
  final EventActionModel eventAction;

  const EventActionButton({super.key, required this.eventAction});

  @override
  State<EventActionButton> createState() => _EventActionButtonState();
}

class _EventActionButtonState extends State<EventActionButton> {
  @override
  Widget build(BuildContext context) {
    final _buttonColor = widget.eventAction.color?.value ??
        Theme.of(context).colorScheme.secondary;

    final _foregroundColor =
        ThemeData.estimateBrightnessForColor(_buttonColor) == Brightness.dark
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.surfaceDim;

    return ElevatedButton(
        style: ButtonStyle(
          visualDensity: VisualDensity.compact,
          foregroundColor:
              WidgetStateColor.resolveWith((_) => _foregroundColor),
          backgroundColor: WidgetStateProperty.resolveWith((states) =>
              widget.eventAction.color?.value ??
              Theme.of(context).colorScheme.secondary),
        ),
        onPressed: _open,
        child: Text(widget.eventAction.label.value));
  }

  void _open() => widget.eventAction.open(context);
}
