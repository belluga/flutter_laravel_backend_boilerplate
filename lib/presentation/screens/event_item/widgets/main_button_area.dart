import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:belluga_boilerplate/presentation/screens/event_item/controller/event_item_controller.dart';

class MainButtonArea extends StatelessWidget {
  final void Function() onButTap;

  const MainButtonArea({super.key, required this.onButTap});

  @override
  Widget build(BuildContext context) {
    final _controller = GetIt.I.get<EventItemController>();

    return Container(
      decoration: BoxDecoration(
        color: _controller.colorScheme.onPrimaryContainer.withAlpha(220),
      ),
      child: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 60, vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 280,
                  ),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _controller.colorScheme.primary,
                        foregroundColor: _controller.colorScheme.onPrimary,
                      ),
                      onPressed: onButTap,
                      child: Text("Comprar Agora!")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
