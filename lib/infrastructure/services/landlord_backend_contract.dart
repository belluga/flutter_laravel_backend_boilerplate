import 'package:belluga_boilerplate/domain/landlord/landlord.dart';

abstract class LandlordBackendContract {

  Future<bool> isInitialized();
  Future<Landlord> getLandlord();

}
