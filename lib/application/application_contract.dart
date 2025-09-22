import 'package:belluga_boilerplate/domain/repositories/landlord_repository_contract.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/landlord_repository.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:belluga_boilerplate/application/configurations/custom_scroll_behavior.dart';
import 'package:belluga_boilerplate/application/router/app_router.dart';
import 'package:belluga_boilerplate/domain/app_data/app_data.dart';
import 'package:belluga_boilerplate/domain/repositories/auth_repository_contract.dart';
import 'package:belluga_boilerplate/domain/repositories/external_courses_repository_contract.dart';
import 'package:belluga_boilerplate/domain/repositories/courses_repository_contract.dart';
import 'package:belluga_boilerplate/domain/repositories/notes_repository_contract.dart';
import 'package:belluga_boilerplate/domain/repositories/schedule_repository_contract.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/courses_repository.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/external_courses_repository.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/notes_repository.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/schedule_repository.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/tenant_repository.dart';
import 'package:belluga_boilerplate/infrastructure/services/backend_contract.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl_standalone.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:belluga_boilerplate/domain/repositories/tenant_repository_contract.dart';
import 'package:stream_value/core/stream_value_builder.dart';

abstract class ApplicationContract extends StatefulWidget {
  const ApplicationContract({super.key});

  BackendContract initBackendRepository();

  AuthRepositoryContract initAuthRepository();

  Future<void> initialSettingsPlatform();

  Future<void> init() async {
    await initialSettings();
    await _initInjections();
    await initialSettingsPlatform();
  }

  @protected
  Future<void> initialSettings() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeDateFormatting();
    await findSystemLocale();
    await _initAppData();
    await _initBackend();
    await _initTenant();
  }

  Future<void> _initAppData() async {
    final appData = AppData()..initialize();
    await appData.initialize();
    GetIt.I.registerSingleton<AppData>(appData);
  }

  Future<void> _initBackend() async {
    GetIt.I.registerSingleton<BackendContract>(initBackendRepository());
  }

  Future<void> _initTenant() async {
    final _tenant = TenantRepository();
    await _tenant.init();
    GetIt.I.registerSingleton<TenantRepositoryContract>(_tenant);
  }

  Future<void> _initInjections() async {
    
    final _landlordRepository = LandlordRepository();
    await _landlordRepository.init();

    GetIt.I.registerLazySingleton<LandlordRepositoryContract>(
      () => _landlordRepository,
    );

    GetIt.I.registerLazySingleton(() => ThemeRepository());

    GetIt.I.registerLazySingleton<AuthRepositoryContract>(
      () => initAuthRepository(),
    );

    GetIt.I.registerLazySingleton<ExternalCoursesRepositoryContract>(
      () => ExternalCoursesRepository(),
    );

    GetIt.I.registerLazySingleton<CoursesRepositoryContract>(
      () => CoursesRepository(),
    );

    GetIt.I.registerLazySingleton<NotesRepositoryContract>(
      () => NotesRepository(),
    );

    GetIt.I.registerLazySingleton<ScheduleRepositoryContract>(
        () => ScheduleRepository());
  }

  @override
  State<ApplicationContract> createState() => _ApplicationContractState();
}

class _ApplicationContractState extends State<ApplicationContract> {
  final _appRouter = AppRouter();

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
      // inputDecorationTheme: InputDecorationTheme(
      //   border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(4.0),
      //   ),
      //   focusedBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(4.0),
      //   ),
      //   errorBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(4.0),
      //   ),
      // ),
      colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF00E6B8)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamValueBuilder<ThemeData?>(
        streamValue: GetIt.I.get<ThemeRepository>().themeStreamValue,
        builder: (context, themeData) {
          final ThemeData _themeData = themeData ?? getThemeData();

          return MaterialApp.router(
            theme: _themeData,
            scrollBehavior: CustomScrollBehavior(),
            routerConfig: _appRouter.config(),
          );
        });
  }
}
