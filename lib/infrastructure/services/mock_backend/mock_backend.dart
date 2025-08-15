import 'package:unifast_portal/infrastructure/services/auth_backend_contract.dart';
import 'package:unifast_portal/infrastructure/services/courses_backend_contract.dart';
import 'package:unifast_portal/infrastructure/services/backend_contract.dart';
import 'package:unifast_portal/infrastructure/services/mock_backend/mock_auth_backend.dart';
import 'package:unifast_portal/infrastructure/services/mock_backend/mock_courses_backend.dart';
import 'package:unifast_portal/infrastructure/services/mock_backend/mock_notes_backend.dart';
import 'package:unifast_portal/infrastructure/services/mock_backend/mock_schedule_backend.dart';
import 'package:unifast_portal/infrastructure/services/notes_backend_contract.dart';
import 'package:unifast_portal/infrastructure/services/schedule_backend_contract.dart';

class MockBackend extends BackendContract {
  @override
  final AuthBackendContract auth = MockAuthBackend();

  @override
  final NotesBackendContract notes = MockNotesBackend();

  @override
  final CoursesBackendContract courses = MockCoursesBackend();

  @override
  final ScheduleBackendContract schedule = MockScheduleBackend();
}
