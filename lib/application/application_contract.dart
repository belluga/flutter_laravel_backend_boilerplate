import 'dart:async';

import 'package:belluga_boilerplate/application/router/app_router.dart';
import 'package:belluga_boilerplate/application/configurations/browser_location.dart';
import 'package:belluga_boilerplate/application/router/modular_app/module_settings.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/theme_repository.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/app_data_repository.dart';
import 'package:belluga_boilerplate/domain/repositories/auth_repository_contract.dart';
import 'package:belluga_boilerplate/domain/repositories/telemetry_repository_contract.dart';
import 'package:belluga_boilerplate/infrastructure/services/push/firebase_runtime_bootstrap.dart';
import 'package:belluga_boilerplate/infrastructure/services/push/push_navigation_resolver.dart';
import 'package:belluga_boilerplate/infrastructure/services/push/push_telemetry_forwarder.dart';
import 'package:belluga_boilerplate/infrastructure/services/push/push_transport_configurator.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:belluga_boilerplate/application/configurations/custom_scroll_behavior.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';
import 'package:intl/intl_standalone.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:stream_value/core/stream_value_builder.dart';
import 'package:push_handler/push_handler.dart';

abstract class ApplicationContract extends ModularAppContract {
  ApplicationContract({super.key});

  @override
  final AppRouterContract appRouter = AppRouter();

  @override
  final ModuleSettingsContract moduleSettings = ModuleSettings();

  Future<void> initialSettingsPlatform();

  @override
  Future<void> init() async {
    await initialSettings();
    await initialSettingsPlatform();
    await super.init();
    await _initializePushRuntime();
  }

  Future<void> _initializePushRuntime() async {
    final appDataRepository = GetIt.I.get<AppDataRepository>();
    final authRepository = GetIt.I.get<AuthRepositoryContract>();
    final telemetryRepository = GetIt.I.get<TelemetryRepositoryContract>();
    final firebaseReady = await FirebaseRuntimeBootstrap.initialize(
      appDataRepository.appData,
    );
    final telemetryForwarder = PushTelemetryForwarder(
      telemetryRepository: telemetryRepository,
    );
    final repository = PushHandlerRepositoryDefault(
      transportConfig: PushTransportConfigurator.build(
        appDataRepository: appDataRepository,
        authRepository: authRepository,
      ),
      contextProvider: () => appRouter.globalRouterKey.currentContext,
      navigationResolver: BoilerplatePushNavigationResolver(
        router: appRouter,
      ).resolve,
      onBackgroundMessage: PushHandler.onBackgroundMessage,
      authChangeStream: authRepository.userStreamValue.stream,
      platformResolver: () =>
          appDataRepository.appData.platformType.value?.name ?? 'web',
      enableFirebaseMessaging: firebaseReady,
      onPushEvent: (event) {
        unawaited(telemetryForwarder.forward(event));
      },
    );
    if (GetIt.I.isRegistered<PushHandlerRepositoryContract>()) {
      GetIt.I.unregister<PushHandlerRepositoryContract>();
    }
    GetIt.I.registerSingleton<PushHandlerRepositoryContract>(repository);
    await repository.init();
  }

  @protected
  Future<void> initialSettings() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeDateFormatting();
    await findSystemLocale();
  }

  @override
  State<ApplicationContract> createState() => _ApplicationContractState();
}

class _ApplicationContractState extends State<ApplicationContract> {
  final navigatorKey = GlobalKey<NavigatorState>();

  ThemeData getThemeData() {
    return ThemeData(
      progressIndicatorTheme: ProgressIndicatorThemeData(
        strokeWidth: 4,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        ),
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF00E6B8)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamValueBuilder<ThemeData?>(
        streamValue: GetIt.I.get<ThemeRepository>().themeStreamValue,
        builder: (context, themeData) {
          final ThemeData _themeData = themeData ?? getThemeData();
          final routerConfig = widget.appRouter.config(
            includePrefixMatches: false,
            deepLinkBuilder: _resolvePlatformDeepLink,
          );

          return MaterialApp.router(
            theme: _themeData,
            scrollBehavior: CustomScrollBehavior(),
            routeInformationParser: routerConfig.routeInformationParser,
            routeInformationProvider: widget.appRouter.routeInfoProvider(),
            routerDelegate: routerConfig.routerDelegate,
            backButtonDispatcher: routerConfig.backButtonDispatcher,
          );
        });
  }

  DeepLink _resolvePlatformDeepLink(PlatformDeepLink deepLink) {
    final browserPath = initialBrowserPath();
    if (browserPath == null || browserPath == '/') {
      return deepLink;
    }

    return DeepLink.path(browserPath, includePrefixMatches: false);
  }
}
