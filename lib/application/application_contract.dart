import 'package:belluga_boilerplate/application/router/app_router.dart';
import 'package:belluga_boilerplate/application/router/modular_app/module_settings.dart';
import 'package:belluga_boilerplate/infrastructure/repositories/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:belluga_boilerplate/application/configurations/custom_scroll_behavior.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';
import 'package:intl/intl_standalone.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:stream_value/core/stream_value_builder.dart';

abstract class ApplicationContract extends ModularAppContract {

  ApplicationContract({super.key});

  @override
  final AppRouterContract appRouter = AppRouter();

  @override
  final ModuleSettingsContract moduleSettings = ModuleSettings();

  Future<void> initialSettingsPlatform();

  @override
  Future<void> init() async {
    await super.init();
    await initialSettings();
    await initialSettingsPlatform();
    // await moduleSettings.init();
    // appRouter.setChildModules(moduleSettings.childModules);
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

          return MaterialApp.router(
            theme: _themeData,
            scrollBehavior: CustomScrollBehavior(),
            routerConfig: widget.appRouter.config()
          );
        });
  }
}
