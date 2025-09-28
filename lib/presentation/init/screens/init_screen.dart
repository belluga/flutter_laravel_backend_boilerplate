import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:belluga_boilerplate/application/configurations/widget_keys.dart';
import 'package:belluga_boilerplate/domain/controllers/belluga_init_screen_controller_contract.dart';
import 'package:get_it/get_it.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  final _controller = GetIt.I.get<BellugaInitScreenControllerContract>();

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: WidgetKeys.splash.scaffold,
      body: const Center(child: Text("SPLASH")),
    );
  }

  Future<void> _init() async {
    
    await _controller.initialize();

    await Future.delayed(const Duration(milliseconds: 2000));
    _gotoInitialRoute();
  }

  void _gotoInitialRoute() => context.router.replace(_controller.initialRoute);
}
