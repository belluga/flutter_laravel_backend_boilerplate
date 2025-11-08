import 'package:flutter/material.dart';

class DashboardWidgetAnimated extends StatelessWidget {
  final Widget child;
  final bool isVisible;

  const DashboardWidgetAnimated(
      {super.key, required this.child, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SizeTransition(
          sizeFactor: animation,
          axis: Axis.vertical,
          child: child,
        );
      },
      child: isVisible
          ? child
          : const SizedBox.shrink(key: ValueKey('emptyNextEvents')),
    );
  }
}
