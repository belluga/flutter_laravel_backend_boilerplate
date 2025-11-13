import 'package:belluga_boilerplate/domain/learning_experience/course_base_model.dart';
import 'package:belluga_boilerplate/domain/repositories/learning_experience_repository_contract.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/dashboard/view_models/courses_summary.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value.dart';

class MyCoursesDashboardController {
  final _learningRepository =
      GetIt.I.get<LearningExperienceRepositoryContract>();

  StreamValue<CoursesSummary?> get myCoursesSummaryStreamValue {
    return _learningRepository.myCoursesSummaryStreamValue;
  }

  StreamValue<List<CourseBaseModel>?> get fastTracksItemsStreamValue {
    return _learningRepository.fastTracksListStreamValue;
  }

  final navigationPreferenceStreamValue = StreamValue<bool>(
    defaultValue: false,
  );

  Future<void> init() async {
    _getMyCoursesSummary();
    _getFastTracksItems();
  }

  Future<void> _getMyCoursesSummary() async =>
      await _learningRepository.ensureMyCoursesSummary();

  Future<void> _getFastTracksItems() async =>
      await _learningRepository.ensureFastTracksCatalog();
}
