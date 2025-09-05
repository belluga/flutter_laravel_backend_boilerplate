import 'package:belluga_boilerplate/domain/app_data/app_data.dart';
import 'package:belluga_boilerplate/domain/repositories/landlord_repository_contract.dart';
import 'package:belluga_boilerplate/infrastructure/services/backend_contract.dart';
import 'package:get_it/get_it.dart';

class LandlordRepository extends LandlordRepositoryContract {
  
  @override
  BackendContract get backend => GetIt.I.get<BackendContract>();

  @override
  AppData get appData => GetIt.I.get<AppData>();
}
