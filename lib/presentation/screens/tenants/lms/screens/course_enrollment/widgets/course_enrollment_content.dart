import 'package:belluga_boilerplate/domain/learning_experience/course_item_model.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_enrollment/widgets/course_enrollment_background_blur.dart';
import 'package:flutter/material.dart';
import 'package:stream_value/core/stream_value.dart';
import 'package:stream_value/core/stream_value_builder.dart';

class CourseEnrollmentContent extends StatelessWidget {
  const CourseEnrollmentContent({
    super.key,
    required this.course,
    required this.onEnroll,
    required this.isEnrollingStream,
  });

  final CourseItemModel course;
  final VoidCallback onEnroll;
  final StreamValue<bool> isEnrollingStream;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CourseEnrollmentBackgroundBlur(
          imageUrl: course.thumb.thumbUri.value.toString(),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black.withValues(alpha: 0.4),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title.value,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: course.categories
                          ?.map(
                            (category) => Chip(
                              backgroundColor: Colors.white24,
                              label: Text(
                                category.name.value,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                          .toList() ??
                      [],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: StreamValueBuilder<bool>(
                    streamValue: isEnrollingStream,
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
                            : const Text('Matricular'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
