import 'package:belluga_boilerplate/infrastructure/repositories/app_data_repository.dart';
import 'package:get_it/get_it.dart';

class TenantHomeScreenController {
  final appData = GetIt.I.get<AppDataRepository>().appData;

  TenantHomeScreenController();

  Future<void> init() async {
    
  }
}
