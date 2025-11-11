import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/domain/learning_experience/course_item_model.dart';
import 'package:belluga_boilerplate/domain/repositories/enrollment_repository.dart';
import 'package:belluga_boilerplate/domain/repositories/learning_experience_repository_contract.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

@RoutePage(name: 'CourseEnrollmentRoute')
class CourseEnrollmentScreen extends StatefulWidget {
  final String courseItemId;

  const CourseEnrollmentScreen({
    super.key,
    @PathParam('courseItemId') required this.courseItemId,
  });

  @override
  State<CourseEnrollmentScreen> createState() => _CourseEnrollmentScreenState();
}

class _CourseEnrollmentScreenState extends State<CourseEnrollmentScreen> {
  final _learningRepository =
      GetIt.I.get<LearningExperienceRepositoryContract>();
  final _enrollmentRepository = GetIt.I.get<EnrollmentRepository>();

  CourseItemModel? _courseItem;
  bool _isEnrolling = false;

  @override
  void initState() {
    super.initState();
    _loadCourse();
  }

  Future<void> _loadCourse() async {
    final course = await _learningRepository.loadCourseDetails(
      widget.courseItemId,
    );
    if (!mounted) return;
    setState(() {
      _courseItem = course;
    });
  }

  @override
  Widget build(BuildContext context) {
    final course = _courseItem;
    return Scaffold(
      body: course == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                _BackgroundBlur(
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
                          child: ElevatedButton(
                            onPressed: _isEnrolling
                                ? null
                                : () => _handleEnroll(course),
                            child: _isEnrolling
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text('Matricular'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _handleEnroll(CourseItemModel course) async {
    if (_isEnrolling) return;
    setState(() => _isEnrolling = true);
    await _enrollmentRepository.enroll(course.id.value);
    if (!mounted) return;
    // Replace the enrollment screen with the intended course route so the
    // guard can re-run and allow access now that enrollment succeeded.
    context.router.replace(
      CourseRoute(courseItemId: course.id.value),
    );
  }
}

class _BackgroundBlur extends StatelessWidget {
  final String? imageUrl;

  const _BackgroundBlur({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return Container(color: Colors.black12);
    }

    return Positioned.fill(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Image.network(
          imageUrl!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
