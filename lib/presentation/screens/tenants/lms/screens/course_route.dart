import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/learning_capability_module.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_screen/course_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

@RoutePage()
class CourseRoute extends StatelessWidget {
  final String courseItemId;

  const CourseRoute({
    super.key,
    @PathParam('courseItemId') required this.courseItemId,
  });

  @override
  Widget build(BuildContext context) {
    return ModuleScope<LearningCapabilityModule>(
      child: CourseScreen(
        courseItemId: courseItemId,
      ),
    );
  }
}
