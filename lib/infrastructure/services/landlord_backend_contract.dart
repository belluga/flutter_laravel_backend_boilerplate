import 'package:belluga_boilerplate/domain/environment/landlord.dart';

abstract class LandlordBackendContract {

  Future<bool> isInitialized();
  Future<Landlord> getLandlord();

}
