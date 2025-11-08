import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/lms_module.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/courses_list_screen/courses_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

@RoutePage()
class CoursesListRoute extends StatelessWidget {
  const CoursesListRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return ModuleScope<LmsModule>(
      child: CoursesListScreen(),
    );
  }
}
