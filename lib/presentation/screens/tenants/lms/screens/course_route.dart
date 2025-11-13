import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/learning_capability_module.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';
import 'package:belluga_boilerplate/domain/learning_experience/course_item_model.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_screen/course_screen.dart';
import 'package:flutter/cupertino.dart';

@RoutePage()
class CourseRoute
    extends ResolverRoute<CourseItemModel, LearningCapabilityModule> {
  final String courseItemId;

  const CourseRoute({
    super.key,
    @PathParam('courseItemId') required this.courseItemId,
  });

  @override
  RouteResolverParams get resolverParams => {
        'courseItemId': courseItemId,
      };

  @override
  Widget buildScreen(BuildContext context, CourseItemModel model) {
    return CourseScreen(course: model);
  }
}
