import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class BackButtonBelluga extends StatelessWidget {
  const BackButtonBelluga({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: context.router.back,
      icon: const Icon(
        Icons.arrow_back,
        size: 24,
      ),
    );
  }
}
