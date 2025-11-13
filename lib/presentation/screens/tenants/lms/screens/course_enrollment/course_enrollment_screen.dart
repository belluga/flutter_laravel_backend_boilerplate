import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/domain/learning_experience/course_item_model.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_enrollment/controllers/course_enrollment_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_enrollment/widgets/course_enrollment_content.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CourseEnrollmentScreen extends StatefulWidget {
  const CourseEnrollmentScreen({super.key, required this.course});

  final CourseItemModel course;

  @override
  State<CourseEnrollmentScreen> createState() => _CourseEnrollmentScreenState();
}

class _CourseEnrollmentScreenState extends State<CourseEnrollmentScreen> {
  late final CourseEnrollmentController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GetIt.I.get<CourseEnrollmentController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CourseEnrollmentContent(
        course: widget.course,
        isEnrollingStream: _controller.isEnrollingStreamValue,
        onEnroll: () => _handleEnroll(widget.course),
      ),
    );
  }

  Future<void> _handleEnroll(CourseItemModel course) async {
    final enrolled = await _controller.enroll(course.id.value);
    if (!mounted || !enrolled) return;
    context.router.replace(CourseRoute(courseItemId: course.id.value));
  }
}
