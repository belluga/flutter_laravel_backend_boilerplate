import 'package:belluga_boilerplate/domain/app_data/app_data.dart';
import 'package:belluga_boilerplate/domain/landlord/landlord.dart';
import 'package:belluga_boilerplate/infrastructure/services/backend_contract.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class LandlordRepositoryContract {
  BackendContract get backend;
  AppData get appData;

  Landlord? _landlord;
  Landlord get landlord => _landlord!;

  String get domain => dotenv.env["LANDLORD_DOMAIN"]!;

  bool get isLandlordRequest => domain == appData.hostname;

  Future<void> init() async {
    await _getLandlord();
  }

  Future<Landlord> _getLandlord() async {
    _landlord = await backend.landlord.getLandlord().catchError((error) {
      throw Exception("Failed to retrieve Landlord: $error");
    });
    return landlord;
  }
}
