import 'package:flutter/material.dart';
import 'package:stream_value/core/stream_value.dart';
import 'package:stream_value/core/stream_value_builder.dart';

class IconButtonToggled extends StatefulWidget {
  final StreamValue<bool> selectedStateStreamValue;
  final Function() toggleFunction;
  final IconData iconData;
  final String? selectedTooltip;
  final String? unselectedTooltip;

  const IconButtonToggled(
      {super.key,
      required this.selectedStateStreamValue,
      required this.toggleFunction,
      required this.iconData,
      this.selectedTooltip,
      this.unselectedTooltip});

  @override
  State<IconButtonToggled> createState() => _IconButtonToggledState();
}

class _IconButtonToggledState extends State<IconButtonToggled> {
  @override
  Widget build(BuildContext context) {
    final _activeColor = Theme.of(context).colorScheme.secondary;

    return StreamValueBuilder<bool>(
        streamValue: widget.selectedStateStreamValue,
        builder: (context, isSelected) {
          return CircleAvatar(
            backgroundColor: isSelected ? _activeColor : Colors.transparent,
            child: IconButton(
              icon: Icon(
                widget.iconData,
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurface,
              ),
              visualDensity: VisualDensity.compact,
              disabledColor: Theme.of(context).colorScheme.onSurface,
              isSelected: isSelected,
              onPressed: widget.toggleFunction,
              tooltip: isSelected
                  ? widget.selectedTooltip ?? 'Ocultar'
                  : widget.unselectedTooltip ?? 'Exibir',
            ),
          );
        });
  }
}
