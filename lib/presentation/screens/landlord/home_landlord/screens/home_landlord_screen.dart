import 'package:belluga_boilerplate/application/configurations/belluga_constants.dart';
import 'package:flutter/material.dart';

class HomeLandlordScreen extends StatefulWidget {
  const HomeLandlordScreen({super.key});

  @override
  State<HomeLandlordScreen> createState() => _HomeLandlordScreenState();
}

class _HomeLandlordScreenState extends State<HomeLandlordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Landlord home placeholder"),
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
