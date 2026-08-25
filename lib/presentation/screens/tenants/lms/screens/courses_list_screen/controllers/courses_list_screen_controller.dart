import 'dart:async';

import 'package:belluga_boilerplate/domain/learning_experience/course_base_model.dart';
import 'package:belluga_boilerplate/domain/repositories/learning_experience_repository_contract.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value.dart';

class CoursesListScreenController implements Disposable {
  final _learningRepository =
      GetIt.I.get<LearningExperienceRepositoryContract>();

  StreamValue<List<CourseBaseModel>?> get courseStreamValue =>
      _learningRepository.myCoursesListStreamValue;

  @override
  FutureOr onDispose() {
    //
  }
}
