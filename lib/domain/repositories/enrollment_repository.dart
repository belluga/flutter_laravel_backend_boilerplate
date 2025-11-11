import 'package:stream_value/core/stream_value.dart';

class EnrollmentRepository {
  final _enrolledCourseIdsStream =
      StreamValue<Set<String>>(defaultValue: <String>{});

  StreamValue<Set<String>> get enrolledCourseIdsStream =>
      _enrolledCourseIdsStream;

  bool isEnrolled(String courseId) {
    final current = _currentEnrolled;
    return current.contains(courseId);
  }

  Future<void> enroll(String courseId) async {
    final current = _currentEnrolled;
    final updated = <String>{...current, courseId};
    _enrolledCourseIdsStream.addValue(updated);
  }

  Set<String> get _currentEnrolled => _enrolledCourseIdsStream.value;
}
