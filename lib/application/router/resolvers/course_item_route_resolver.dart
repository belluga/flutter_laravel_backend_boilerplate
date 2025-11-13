import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';
import 'package:belluga_boilerplate/domain/learning_experience/course_item_model.dart';
import 'package:belluga_boilerplate/domain/repositories/learning_experience_repository_contract.dart';
import 'package:get_it/get_it.dart';

class CourseItemRouteResolver
    implements RouteModelResolver<CourseItemModel> {
  CourseItemRouteResolver({
    LearningExperienceRepositoryContract? learningRepository,
  }) : _learningRepository = learningRepository;

  final LearningExperienceRepositoryContract? _learningRepository;

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
    final repo = _learningRepository ??
        GetIt.I.get<LearningExperienceRepositoryContract>();
    return repo.loadCourseDetails(courseId);
  }
}
