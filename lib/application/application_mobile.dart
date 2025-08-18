
import 'package:belluga_boilerplate/application/application_mobile_contract.dart';
import 'package:belluga_boilerplate/domain/repositories/auth_repository_contract.dart';
import 'package:belluga_boilerplate/domain/user/user_belluga.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/auth_repository.dart';
import 'package:belluga_boilerplate/infrastructure/services/backend_contract.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/mock_backend/mock_backend.dart';

class Application extends ApplicationMobileContract {
  Application({super.key});

  @override
  AuthRepositoryContract<UserBelluga> initAuthRepository() {
    final _respository = AuthRepository();
    _respository.init();
    return _respository;
  }

  @override
  BackendContract initBackendRepository() => MockBackend();
}
