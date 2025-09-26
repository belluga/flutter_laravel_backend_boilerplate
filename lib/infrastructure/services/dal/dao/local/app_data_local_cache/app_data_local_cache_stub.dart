// infrastructure/sources/local_cache/app_data_local_cache_mobile.dart
import 'dart:convert';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/local/app_data_local_cache/app_data_local_cache_contract.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppDataLocalCache extends AppDataLocalCacheContract {
  
  final _storage = const FlutterSecureStorage();

  @override
  Future<String?> getCachedData() async => await _storage.read(key: key);

  @override
  Future<void> save(Map<String, dynamic> data) async {
    await _storage.write(key: key, value: jsonEncode(data));
  }

  @override
  Future<void> delete() async {
    await _storage.delete(key: key);
  }

}