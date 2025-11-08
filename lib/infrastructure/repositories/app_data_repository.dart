import 'package:belluga_boilerplate/domain/app_data/app_data.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/laravel_backend/app_data_backend/app_data_backend.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/local/app_data_local_cache/app_data_local_cache.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/local/app_data_local_info_source/app_data_local_info_source.dart';

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

    Map<String, dynamic>? remoteData = await _localCache.get();

    if (remoteData == null) {
      remoteData = await _backend.fetch();
      await _localCache.save(remoteData);
    }

    final localInfo = await _localInfoSource.getInfo();

    appData = AppData.fromInitialization(
      remoteData: remoteData,
      localInfo: localInfo,
    );
  }
}