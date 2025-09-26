import 'dart:convert';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/local/app_data_local_cache/app_data_local_cache_contract.dart';
import 'package:web/web.dart' as web;

class AppDataLocalCache extends AppDataLocalCacheContract {

  @override
  Future<String?> getCachedData() async => web.window.localStorage.getItem(key);

  @override
  Future<void> save(Map<String, dynamic> data) async {
    web.window.localStorage.setItem(key, jsonEncode(data));
  }

  @override
  Future<void> delete() async {
    web.window.localStorage.removeItem(key);
  }
}