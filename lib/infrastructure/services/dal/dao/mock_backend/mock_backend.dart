import 'package:belluga_boilerplate/infrastructure/services/auth_backend_contract.dart';
import 'package:belluga_boilerplate/infrastructure/services/courses_backend_contract.dart';
import 'package:belluga_boilerplate/infrastructure/services/backend_contract.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/mock_backend/mock_auth_backend.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/mock_backend/mock_tenant_backend.dart';
import 'package:belluga_boilerplate/infrastructure/services/tenant_backend_contract.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/mock_backend/mock_courses_backend.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/mock_backend/mock_notes_backend.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/mock_backend/mock_schedule_backend.dart';
import 'package:belluga_boilerplate/infrastructure/services/notes_backend_contract.dart';
import 'package:belluga_boilerplate/infrastructure/services/schedule_backend_contract.dart';

class MockBackend extends BackendContract {
  @override
  final AuthBackendContract auth = MockAuthBackend();

  @override
  final NotesBackendContract notes = MockNotesBackend();

  @override
  final CoursesBackendContract courses = MockCoursesBackend();

  @override
  final ScheduleBackendContract schedule = MockScheduleBackend();

  @override
  final TenantBackendContract tenant = MockTenantBackend();
}
