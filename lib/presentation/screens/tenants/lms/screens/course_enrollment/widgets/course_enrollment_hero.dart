import 'package:belluga_boilerplate/domain/learning_experience/course_item_model.dart';
import 'package:belluga_boilerplate/presentation/common/widgets/image_with_progress_indicator.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_enrollment/widgets/course_enrollment_background_blur.dart';
import 'package:flutter/material.dart';
import 'package:stream_value/core/stream_value.dart';
import 'package:stream_value/core/stream_value_builder.dart';

class CourseEnrollmentHero extends StatelessWidget {
  const CourseEnrollmentHero({
    super.key,
    required this.course,
    required this.onEnroll,
    required this.isEnrollingStream,
    required this.mainButtonKey,
  });

  final CourseItemModel course;
  final VoidCallback onEnroll;
  final StreamValue<bool> isEnrollingStream;
  final GlobalKey mainButtonKey;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      fit: StackFit.expand,
      children: [
        CourseEnrollmentBackgroundBlur(
          imageUrl: course.thumb.thumbUri.value.toString(),
        ),
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                colorScheme.surface.withValues(alpha: 0.95),
                colorScheme.surface.withValues(alpha: 0.0),
              ],
              stops: const [0.0, 0.8],
            ),
          ),
        ),
        SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Text(
                        'Curso',
                        style: textTheme.labelLarge
                            ?.copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        course.title.value,
                        style: textTheme.headlineMedium?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        course.description.value,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (_hasCategories)
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: course.categories!
                              .map(
                                (category) => Chip(
                                  visualDensity: VisualDensity.compact,
                                  label: Text(
                                    category.name.value,
                                    style: textTheme.labelMedium?.copyWith(
                                      color: category.color.value
                                                  .computeLuminance() >
                                              0.5
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                  backgroundColor: category.color.value
                                      .withValues(alpha: 0.3),
                                  shape: StadiumBorder(
                                    side: BorderSide(
                                      color: category.color.value,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      const Spacer(),
                      Center(
                        child: ImageWithProgressIndicator(
                          uri: course.thumb.thumbUri.value,
                          width: double.infinity,
                          height: 240,
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              _PrimaryButtonArea(
                colorScheme: colorScheme,
                isEnrollingStream: isEnrollingStream,
                onEnroll: onEnroll,
                buttonKey: mainButtonKey,
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool get _hasCategories =>
      course.categories != null && course.categories!.isNotEmpty;
}

class _PrimaryButtonArea extends StatelessWidget {
  const _PrimaryButtonArea({
    required this.colorScheme,
    required this.isEnrollingStream,
    required this.onEnroll,
    required this.buttonKey,
  });

  final ColorScheme colorScheme;
  final StreamValue<bool> isEnrollingStream;
  final VoidCallback onEnroll;
  final GlobalKey buttonKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: buttonKey,
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.9),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300),
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
    );
  }
}
