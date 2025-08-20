import 'package:flutter/material.dart';

class SliverDashboardWidgetAnimated extends StatelessWidget {
  final Widget sliver;
  final bool isVisible;

  const SliverDashboardWidgetAnimated({
    super.key,
    required this.sliver,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        // This part remains the same. It correctly creates a sliver animation.
        return SliverFadeTransition(
          opacity: animation,
          sliver: child,
        );
      },

      // THIS IS THE FIX: We provide a custom layout builder.
      // Instead of wrapping children in a Stack, we just show the current one.
      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
        return currentChild ?? const SliverToBoxAdapter(); // Return an empty sliver if null
      },

      // The child logic remains the same.
      child: isVisible
          ? sliver
          // It's good practice to add a key to help AnimatedSwitcher
          : const SliverToBoxAdapter(key: ValueKey('emptySliver')),
    );
  }
}