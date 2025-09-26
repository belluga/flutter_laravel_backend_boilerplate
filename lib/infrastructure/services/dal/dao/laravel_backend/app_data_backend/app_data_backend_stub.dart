import 'package:belluga_boilerplate/infrastructure/services/dal/dao/laravel_backend/app_data_backend/app_data_backend_contract.dart';
import 'package:dio/dio.dart';
import 'package:belluga_boilerplate/application/configurations/belluga_constants.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppDataBackend implements AppDataBackendContract {
  
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: '${BellugaConstants.env.schema}://${BellugaConstants.env.landlordDomain}',
    ),
  );

  @override
  Future<Map<String, dynamic>> fetch() async {

    final _packageInfo = await PackageInfo.fromPlatform();

    print(_packageInfo.appName);
    print(_packageInfo.packageName);

    try {
      final response = await _dio.get('/environment?app_domain=${_packageInfo.packageName}');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw Exception('Failed to load environment data: ${e.message}');
    } catch (e) {
      throw Exception('Could not retrieve branding data.');
    }
  }
}