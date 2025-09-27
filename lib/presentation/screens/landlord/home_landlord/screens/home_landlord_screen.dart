import 'package:belluga_boilerplate/presentation/screens/landlord/home_landlord/controllers/landlord_home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:belluga_boilerplate/application/configurations/belluga_constants.dart';
import 'package:get_it/get_it.dart';

class HomeLandlordScreen extends StatefulWidget {
  const HomeLandlordScreen({super.key});

  @override
  State<HomeLandlordScreen> createState() => _HomeLandlordScreenState();
}

class _HomeLandlordScreenState extends State<HomeLandlordScreen> {

  final _controller = GetIt.I.get<LandlordHomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("This is Landlord HOME (Belluga NOW)"),
            Text(BellugaConstants.settings.platform),
            // ElevatedButton(
            //   key: WidgetKeys.auth.navigateToProtectedButton,
            //   onPressed: () => context.router.push(const DashboardRoute()),
            //   child: const Text("goto Protected"),
            // ),
          ],
        ),
      ),
    );
  }
}
