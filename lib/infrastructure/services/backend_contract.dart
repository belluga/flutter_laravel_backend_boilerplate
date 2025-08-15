import 'package:unifast_portal/infrastructure/services/auth_backend_contract.dart';
import 'package:unifast_portal/infrastructure/services/notes_backend_contract.dart';
import 'package:unifast_portal/infrastructure/services/courses_backend_contract.dart';
import 'package:unifast_portal/infrastructure/services/schedule_backend_contract.dart';

abstract class BackendContract {

  AuthBackendContract get auth;
  NotesBackendContract get notes;
  CoursesBackendContract get courses;
  ScheduleBackendContract get schedule;
}
