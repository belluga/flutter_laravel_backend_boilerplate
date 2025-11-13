import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/modular_app/modules/notes_module.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/notes/screens/notes_screen/notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

@RoutePage()
class NotesRoute extends StatelessWidget {
  const NotesRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return ModuleScope<NotesModule>(
      child: const NotesScreen(),
    );
  }
}
