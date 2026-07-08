import 'package:flutter/material.dart';
import 'package:stream_value/core/stream_value.dart';
import 'package:stream_value/core/stream_value_builder.dart';

class CourseEnrollmentBottomBar extends StatelessWidget {
  const CourseEnrollmentBottomBar({
    super.key,
    required this.isVisible,
    required this.isEnrollingStream,
    required this.onEnroll,
  });

  final bool isVisible;
  final StreamValue<bool> isEnrollingStream;
  final VoidCallback onEnroll;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return IgnorePointer(
      ignoring: !isVisible,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        offset: isVisible ? Offset.zero : const Offset(0, 1),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                colorScheme.surface.withValues(alpha: 0.98),
                colorScheme.surface.withValues(alpha: 0.0),
              ],
              stops: const [0.0, 0.7],
            ),
          ),
          padding: const EdgeInsets.only(left: 60, right: 24, bottom: 16),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                IconButton.filled(
                  style: IconButton.styleFrom(
                    backgroundColor: colorScheme.secondaryContainer,
                    foregroundColor: colorScheme.onSecondaryContainer,
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 280),
                    child: StreamValueBuilder<bool>(
                      streamValue: isEnrollingStream,
                      onNullWidget: const SizedBox.shrink(),
                      builder: (context, isEnrolling) {
                        return ElevatedButton(
                          onPressed: isEnrolling ? null : onEnroll,
                          child: isEnrolling
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Matricular agora'),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
