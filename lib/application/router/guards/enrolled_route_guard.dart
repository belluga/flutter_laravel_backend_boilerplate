import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/domain/repositories/enrollment_repository.dart';
import 'package:get_it/get_it.dart';

class EnrolledRouteGuard extends AutoRouteGuard {
  final _enrollmentRepository = GetIt.I.get<EnrollmentRepository>();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final courseId = resolver.route.params.optString('courseItemId');
    if (courseId != null && _enrollmentRepository.isEnrolled(courseId)) {
      resolver.next(true);
      return;
    }
    if (courseId != null) {
      router.push(CourseEnrollmentRoute(courseItemId: courseId));
      resolver.next(false);
      return;
    }
    resolver.next(false);
  }
}
