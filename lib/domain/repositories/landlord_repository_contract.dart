import 'package:belluga_boilerplate/application/configurations/belluga_constants.dart';
import 'package:belluga_boilerplate/domain/app_data/app_data.dart';
import 'package:belluga_boilerplate/domain/landlord/landlord.dart';
import 'package:belluga_boilerplate/infrastructure/services/backend_contract.dart';

abstract class LandlordRepositoryContract {
  BackendContract get backend;
  AppData get appData;

  Landlord? _landlord;
  Landlord get landlord => _landlord!;

  String get domain => BellugaConstants.env.environment;

  bool get isLandlordRequest => domain == appData.hostname;

  Future<void> init() async {
    await _getLandlord();
  }

  Future<void> _getLandlord() async {
    _landlord = await backend.landlord.getLandlord().catchError((error) {
      throw Exception("Failed to retrieve Landlord: $error");
    });
  }
}
