import 'package:belluga_boilerplate/application/router/resolvers/route_model_resolver.dart';
import 'package:belluga_boilerplate/domain/learning_experience/course_item_model.dart';
import 'package:belluga_boilerplate/domain/repositories/learning_experience_repository_contract.dart';

class CourseItemRouteResolver
    implements RouteModelResolver<CourseItemModel> {
  CourseItemRouteResolver(this._learningRepository);

  final LearningExperienceRepositoryContract _learningRepository;

  @override
  Future<CourseItemModel> resolve(RouteResolverParams params) {
    final courseId = params['courseItemId'] as String?;
    if (courseId == null || courseId.isEmpty) {
      throw ArgumentError.value(
        courseId,
        'courseItemId',
        'Course ID must be provided',
      );
    }
    return _learningRepository.loadCourseDetails(courseId);
  }
}
