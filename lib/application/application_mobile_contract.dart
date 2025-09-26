import 'package:flutter/services.dart';
import 'package:belluga_boilerplate/application/application_contract.dart';

abstract class ApplicationMobileContract extends ApplicationContract {
  const ApplicationMobileContract({super.key});

  @override
  Future<void> initialSettingsPlatform() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
