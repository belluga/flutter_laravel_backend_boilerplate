import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/learning_capability_module.dart';
import 'package:belluga_boilerplate/domain/learning_experience/course_item_model.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_enrollment/course_enrollment_screen.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CourseEnrollmentRoute
    extends ResolverRoute<CourseItemModel, LearningCapabilityModule> {
  const CourseEnrollmentRoute({
    super.key,
    @PathParam('courseItemId') required this.courseItemId,
  });

  final String courseItemId;

  @override
  Map<String, dynamic> get resolverParams => {
        'courseItemId': courseItemId,
      };

  @override
  Widget buildScreen(BuildContext context, CourseItemModel model) {
    return CourseEnrollmentScreen(course: model);
  }
}
