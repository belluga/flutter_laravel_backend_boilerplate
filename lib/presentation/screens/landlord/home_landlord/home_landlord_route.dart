import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/initialization_module.dart';
import 'package:belluga_boilerplate/presentation/screens/landlord/home_landlord/screens/home_landlord_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

@RoutePage()
class HomeLandlordRoute extends StatelessWidget {
  const HomeLandlordRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return ModuleScope<InitializationModule>(
      child: HomeLandlordScreen(),
    );
  }
}