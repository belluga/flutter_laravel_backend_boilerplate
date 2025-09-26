import 'package:belluga_boilerplate/application/application_web_contract.dart';
import 'package:belluga_boilerplate/domain/repositories/auth_repository_contract.dart';
import 'package:belluga_boilerplate/domain/user/user_belluga.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/auth_repository.dart';

class Application extends ApplicationWebContract {
  const Application({super.key});

  @override
  AuthRepositoryContract<UserBelluga> initAuthRepository() {
    final _respository = AuthRepository();
    _respository.init();
    return _respository;
  }
}
