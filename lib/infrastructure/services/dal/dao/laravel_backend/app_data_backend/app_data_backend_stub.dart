import 'package:belluga_boilerplate/infrastructure/services/dal/dao/laravel_backend/app_data_backend/app_data_backend_contract.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:belluga_boilerplate/application/configurations/belluga_constants.dart';
import 'package:package_info_plus/package_info_plus.dart';

String _resolveBootstrapBaseUrl() {
  final override = BellugaConstants.env.bootstrapBaseUrl;
  if (override.isNotEmpty) {
    return override;
  }

  if (kIsWeb) {
    return Uri.base.origin;
  }

  if (BellugaConstants.env.environment == "local") {
    return "http://nginx";
  }

  return '${BellugaConstants.env.schema}://${BellugaConstants.env.landlordDomain}';
}

class AppDataBackend implements AppDataBackendContract {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _resolveBootstrapBaseUrl(),
    ),
  );

  @override
  Future<Map<String, dynamic>> fetch() async {

    final _packageInfo = await PackageInfo.fromPlatform();

    try {
      final response = await _dio.get(
        '/api/v1/environment',
        queryParameters: {'app_domain': _packageInfo.packageName},
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw Exception('Failed to load environment data: ${e.message}');
    } catch (e) {
      throw Exception('Could not retrieve branding data.');
    }
  }
}
