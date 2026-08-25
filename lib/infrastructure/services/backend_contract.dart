import 'package:belluga_boilerplate/infrastructure/services/auth_backend_contract.dart';
import 'package:belluga_boilerplate/infrastructure/services/notes_backend_contract.dart';
import 'package:belluga_boilerplate/infrastructure/services/courses_backend_contract.dart';
import 'package:belluga_boilerplate/infrastructure/services/schedule_backend_contract.dart';

abstract class BackendContract {

  AuthBackendContract get auth;
  NotesBackendContract get notes;
  CoursesBackendContract get courses;
  ScheduleBackendContract get schedule;
}
