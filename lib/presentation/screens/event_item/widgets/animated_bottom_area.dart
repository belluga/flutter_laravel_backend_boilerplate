import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:belluga_boilerplate/presentation/screens/event_item/controller/event_item_controller.dart';

class AnimatedBottomArea extends StatefulWidget {
  final bool isVisible;

  const AnimatedBottomArea({super.key, this.isVisible = false});

  @override
  State<AnimatedBottomArea> createState() => _AnimatedBottomAreaState();
}

class _AnimatedBottomAreaState extends State<AnimatedBottomArea> {
  final _controller = GetIt.I.get<EventItemController>();

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      offset: widget.isVisible ? Offset.zero : const Offset(0.0, 1.0),
      child: SizedBox(
        height: 80,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    _controller.colorScheme.onPrimaryContainer.withAlpha(255),
                    _controller.colorScheme.onPrimaryContainer.withAlpha(0),
                  ],
                  stops: const [0.0, 0.7],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 60, right: 24, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: _controller.colorScheme.onPrimaryContainer,
                        foregroundColor:
                            _controller.colorScheme.onSecondary,
                      ),
                      onPressed: () {},
                      icon: Icon(Icons.share)),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 280,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _controller.colorScheme.primary,
                          foregroundColor:
                              _controller.colorScheme.onPrimary,
                        ),
                        onPressed: () {},
                        child: const Text("Comprar Agora!"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
