import 'package:belluga_boilerplate/domain/environment/environment.dart';

abstract class EnvironmentBackendContract {

  Environment get environment;

  Future<void> init() async {
    await getEnvironment();
    return Future.value();
  }

  Future<void> getEnvironment();

}
