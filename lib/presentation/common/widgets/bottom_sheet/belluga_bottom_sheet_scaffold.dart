import 'package:flutter/material.dart';

class BellugaBottomSheetScaffold extends StatelessWidget {
  final Widget title;
  final Widget? leading;
  final List<Widget> actions;
  final Widget body;
  final Widget? bottom;

  const BellugaBottomSheetScaffold({
    super.key,
    required this.title,
    required this.body,
    this.leading,
    this.actions = const [],
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final headerColor = Theme.of(context).colorScheme.surface;

    return SafeArea(
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Material(
          color: headerColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    leading ??
                        const SizedBox(
                          width: 48,
                        ),
                    const SizedBox(width: 8),
                    Expanded(child: DefaultTextStyle.merge(child: title)),
                    ...actions,
                  ],
                ),
              ),
              const Divider(height: 1),
              Flexible(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: body,
                ),
              ),
              if (bottom != null) ...[
                const Divider(height: 1),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: bottom!,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
