import 'package:belluga_boilerplate/application/configurations/app_environment_fallback.dart';
import 'package:belluga_boilerplate/domain/app_data/app_data.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/laravel_backend/app_data_backend/app_data_backend.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/local/app_data_local_cache/app_data_local_cache.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/local/app_data_local_info_source/app_data_local_info_source.dart';
import 'package:flutter/foundation.dart';

class AppDataRepository {
  late AppData appData;

  final AppDataLocalCache _localCache;
  final AppDataBackend _backend;
  final AppDataLocalInfoSource _localInfoSource;

  AppDataRepository({
    required AppDataLocalCache localCache,
    required AppDataBackend backend,
    required AppDataLocalInfoSource localInfoSource,
  })  : _localCache = localCache,
        _backend = backend,
        _localInfoSource = localInfoSource;

  Future<void> init() async {
    Map<String, dynamic>? _remoteData = await _localCache.get();

    // if (_remoteData == null) {
      _remoteData = await _fetchRemoteOrFallback();
      await _localCache.save(_remoteData);
    // }

    final localInfo = await _localInfoSource.getInfo();

    appData = AppData.fromInitialization(
      remoteData: _remoteData,
      localInfo: localInfo,
    );
  }

  Future<Map<String, dynamic>> _fetchRemoteOrFallback() async {
    try {
      return await _backend.fetch();
    } catch (error, stackTrace) {
      debugPrint(
          'AppDataRepository: remote fetch failed, using fallback. $error');
      debugPrintStack(stackTrace: stackTrace);
      return kLocalEnvironmentFallback;
    }
  }
}
