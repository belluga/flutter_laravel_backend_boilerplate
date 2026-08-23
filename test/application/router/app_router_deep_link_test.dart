import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/configurations/app_environment_fallback.dart';
import 'package:belluga_boilerplate/application/router/app_router.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/account_workspace_module.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/auth_module.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/home_module.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/initialization_module.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/landlord_module.dart';
import 'package:belluga_boilerplate/application/router/guards/auth_route_guard.dart';
import 'package:belluga_boilerplate/domain/app_data/app_data.dart';
import 'package:belluga_boilerplate/domain/app_data/platform_type.dart';
import 'package:belluga_boilerplate/domain/app_data/value_object/platform_type_value.dart';
import 'package:belluga_boilerplate/domain/repositories/auth_repository_contract.dart';
import 'package:belluga_boilerplate/domain/user/user_belluga.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/app_data_repository.dart';
import 'package:belluga_boilerplate/infrastructure/services/auth_backend_contract.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/laravel_backend/app_data_backend/app_data_backend.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/local/app_data_local_cache/app_data_local_cache.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/local/app_data_local_info_source/app_data_local_info_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:value_object_pattern/domain/value_objects/generic_string_value.dart';

void main() {
  setUp(() async {
    await GetIt.I.reset();
    _registerAppDataRepository(_tenantAppDataRepository());
    GetIt.I.registerSingleton<AuthRepositoryContract>(
      _UnauthenticatedAuthRepository(),
    );
  });

  tearDown(() => GetIt.I.reset());

  test('workspace paths resolve before startup navigation runs', () {
    final router = AppRouter()..setChildModules([AccountWorkspaceModule()]);

    final workspaceMatch = router.matcher.match(
      '/workspace',
      includePrefixMatches: false,
    );
    final accountMatch = router.matcher.match(
      '/workspace/account-demo',
      includePrefixMatches: false,
    );

    expect(workspaceMatch, hasLength(1));
    expect(workspaceMatch!.single.name, AccountWorkspaceHomeRoute.name);
    expect(accountMatch, hasLength(1));
    expect(accountMatch!.single.name, AccountWorkspaceHomeRoute.name);
  });

  test('initialization module does not preempt platform deep links', () {
    expect(InitializationModule().routes, isEmpty);
  });

  test('unauthenticated workspace navigation resolves to login', () async {
    final router = AppRouter()
      ..setChildModules([AuthModule(), AccountWorkspaceModule()]);

    unawaited(router.navigatePath('/workspace/account-demo'));
    await Future<void>.delayed(Duration.zero);

    expect(router.currentPath, '/login');
  });

  test('browser login document replacement settles auth guard as rejected',
      () async {
    final router = AppRouter()
      ..setChildModules([AuthModule(), AccountWorkspaceModule()]);
    final workspaceMatch = router.matcher.match(
      '/workspace',
      includePrefixMatches: false,
    );
    final resultCompleter = Completer<ResolverResult>();

    AuthRouteGuard(
      replaceBrowserPathFn: (path) {
        expect(path, '/login');
        return true;
      },
    ).onNavigation(
      NavigationResolver(router, resultCompleter, workspaceMatch!.single),
      router,
    );

    final result = await resultCompleter.future.timeout(
      const Duration(seconds: 1),
    );

    expect(result.continueNavigation, isFalse);
    expect(router.currentPath, isNot('/workspace'));
  });

  test('landlord /home resolves to the generic landing route', () async {
    _registerAppDataRepository(_landlordAppDataRepository());

    final router = AppRouter()..setChildModules([HomeModule(), LandlordModule()]);
    final visitedPaths = <String>[];

    router.addListener(() {
      final currentPath = router.currentPath;
      if (visitedPaths.isEmpty || visitedPaths.last != currentPath) {
        visitedPaths.add(currentPath);
      }
    });

    await router.navigatePath('/home');
    await Future<void>.delayed(Duration.zero);

    expect(router.currentPath, '/');
    expect(router.stack, hasLength(1));
    expect(router.stack.single.routeData.name, HomeLandlordRoute.name);
    expect(visitedPaths, isNot(contains('/admin')));
    expect(visitedPaths, isNot(contains('/login')));
  });

  test('landlord /landlord resolves to the generic landing route', () async {
    _registerAppDataRepository(_landlordAppDataRepository());

    final router = AppRouter()..setChildModules([HomeModule(), LandlordModule()]);
    final visitedPaths = <String>[];

    router.addListener(() {
      final currentPath = router.currentPath;
      if (visitedPaths.isEmpty || visitedPaths.last != currentPath) {
        visitedPaths.add(currentPath);
      }
    });

    await router.navigatePath('/landlord');
    await Future<void>.delayed(Duration.zero);

    expect(router.currentPath, '/');
    expect(router.stack, hasLength(1));
    expect(router.stack.single.routeData.name, HomeLandlordRoute.name);
    expect(visitedPaths, isNot(contains('/admin')));
    expect(visitedPaths, isNot(contains('/login')));
  });
}

void _registerAppDataRepository(AppDataRepository repository) {
  if (GetIt.I.isRegistered<AppDataRepository>()) {
    GetIt.I.unregister<AppDataRepository>();
  }

  GetIt.I.registerSingleton<AppDataRepository>(repository);
}

AppDataRepository _tenantAppDataRepository() {
  final repository = AppDataRepository(
    localCache: AppDataLocalCache(),
    backend: AppDataBackend(),
    localInfoSource: AppDataLocalInfoSource(),
  );
  repository.appData = AppData.fromInitialization(
    remoteData: <String, dynamic>{
      ...kLocalEnvironmentFallback,
      'type': 'tenant',
    },
    localInfo: <String, dynamic>{
      'platformType': PlatformTypeValue(defaultValue: PlatformType.web),
      'port': GenericStringValue(defaultValue: '443'),
      'hostname': GenericStringValue(defaultValue: 'tenant.example.test'),
      'href': GenericStringValue(defaultValue: 'https://tenant.example.test'),
      'device': GenericStringValue(defaultValue: 'web-test-device'),
    },
  );
  return repository;
}

AppDataRepository _landlordAppDataRepository() {
  final repository = AppDataRepository(
    localCache: AppDataLocalCache(),
    backend: AppDataBackend(),
    localInfoSource: AppDataLocalInfoSource(),
  );
  repository.appData = AppData.fromInitialization(
    remoteData: <String, dynamic>{
      ...kLocalEnvironmentFallback,
      'type': 'landlord',
    },
    localInfo: <String, dynamic>{
      'platformType': PlatformTypeValue(defaultValue: PlatformType.web),
      'port': GenericStringValue(defaultValue: '443'),
      'hostname': GenericStringValue(defaultValue: 'landlord.example.test'),
      'href': GenericStringValue(defaultValue: 'https://landlord.example.test'),
      'device': GenericStringValue(defaultValue: 'web-test-device'),
    },
  );
  return repository;
}

final class _UnauthenticatedAuthRepository
    extends AuthRepositoryContract<UserBelluga> {
  @override
  AuthBackendContract get authBackend => throw UnimplementedError();

  @override
  bool get isAuthorized => false;

  @override
  bool get isUserLoggedIn => false;

  @override
  String get userToken => '';

  @override
  Future<void> autoLogin() async {}

  @override
  Future<void> createNewPassword(
      String newPassword, String confirmPassword) async {}

  @override
  Future<void> init() async {}

  @override
  Future<void> loginWithEmailPassword(String email, String password) async {}

  @override
  Future<void> logout() async {}

  @override
  Future<void> sendPasswordResetEmail(String email) async {}

  @override
  Future<void> sendTokenRecoveryPassword(
      String email, String codigoEnviado) async {}

  @override
  Future<void> signUpWithEmailPassword(String email, String password) async {}

  @override
  Future<void> updateUser(Map<String, Object?> data) async {}
}
