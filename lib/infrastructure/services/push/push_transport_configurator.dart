import 'package:belluga_boilerplate/domain/repositories/auth_repository_contract.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/app_data_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:push_handler/push_handler.dart';

class PushTransportConfigurator {
  const PushTransportConfigurator._();

  static PushTransportConfig build({
    required AppDataRepository appDataRepository,
    required AuthRepositoryContract authRepository,
  }) {
    final baseOrigin = appDataRepository.appData.mainDomainValue.value.origin;
    return PushTransportConfig(
      baseUrl: '$baseOrigin/api',
      apiPrefix: '/v1/',
      tokenProvider: () async {
        if (!authRepository.isUserLoggedIn) {
          return null;
        }
        return authRepository.userToken;
      },
      deviceIdProvider: () async => appDataRepository.appData.device.value,
      enableDebugLogs: kDebugMode,
    );
  }
}
