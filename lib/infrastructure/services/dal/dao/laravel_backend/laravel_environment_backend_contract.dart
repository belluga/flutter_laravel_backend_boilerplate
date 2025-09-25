import 'package:belluga_boilerplate/application/configurations/belluga_constants.dart';
import 'package:belluga_boilerplate/domain/environment/environment.dart';
import 'package:belluga_boilerplate/infrastructure/services/environment_backend_contract.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class LaravelEnvironmentBackendContract
    extends EnvironmentBackendContract {
  late Dio dio;
  late PackageInfo packageInfo;

  @override
  Environment get environment => _environment!;

  Environment? _environment;

  String get landlordUrl =>
      '${BellugaConstants.env.schema}://${BellugaConstants.env.landlordDomain}';

  String get baseUrl => '${environment.mainDomainValue.value.scheme}://$host';

  String get host {
    return environment.mainDomainValue.value.host;
  }

  String? get packageName => kIsWeb ? null : packageInfo.packageName;

  String get getEnvironmentEndpoint;

  @override
  Future<void> init() async {
    dio = Dio(BaseOptions(
      baseUrl: landlordUrl,
      contentType: 'application/json',
      responseType: ResponseType.json,
      headers: {
        'Accept': 'application/json',
      },
    ));

    packageInfo = await PackageInfo.fromPlatform();

    super.init();
  }

  // Dio get dioAuthenticated {
  //   _dio.options.headers.addAll({
  //     'Authorization': 'Bearer $token'});
  //   return _dio;
  // }

  @override
  Future<void> getEnvironment() async {
    print("getEnvironment");
    // try {
      final response = await dio.get(getEnvironmentEndpoint);
      _environment = Environment.fromJson(response.data);
    // } on DioException catch (e) {
    //   final errorMessage = e.response?.data?['message'] ?? e.message;
    //   throw Exception('Failed to load tenant data: $errorMessage');
    // } catch (e) {
    //   throw Exception('An unexpected error occurred: $e');
    // }
  }
}
