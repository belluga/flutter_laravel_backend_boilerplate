import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/domain/user/user_contract.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/profile/controller/profile_screen_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/profile/widgets/network_section.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/profile/widgets/profile_header.dart';
import 'package:belluga_boilerplate/presentation/widgets/back_button_belluga.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value_builder.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _controller = GetIt.I.get<ProfileScreenController>();

  late final TextEditingController _nameController;
  late final TextEditingController _titleController;
  late final TextEditingController _bioController;
  late final TextEditingController _whatsappController;
  late final TextEditingController _linkedinController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'João Augusto Silva');
    _titleController = TextEditingController(text: 'Customer Success');
    _bioController = TextEditingController(
        text: 'Atuo há mais de 10 anos no setor comercial...');
    _whatsappController = TextEditingController(text: '+55 15 99999-9999');
    _linkedinController =
        TextEditingController(text: 'www.linkedin.com/in/joao-augusto-silva');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    _bioController.dispose();
    _whatsappController.dispose();
    _linkedinController.dispose();
    super.dispose();
  }

  void _toggleEdit() => _controller.toggleEdit();

  void _saveProfile() {
    debugPrint('Saving data...');
    _toggleEdit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Perfil'),
        elevation: 0,
        leading: BackButtonBelluga(),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
            ),
            onPressed: _controller.toggleEdit,
          ),
          Builder(builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.settings,
              ),
              onPressed: () => _rightDrawer(context),
            );
          }),
        ],
      ),
      body: StreamValueBuilder<UserContract>(
          streamValue: _controller.userStreamValue,
          onNullWidget: SizedBox.shrink(),
          builder: (context, asyncSnapshot) {
            return StreamValueBuilder(
                streamValue: _controller.isEditingStreamValue,
                builder: (context, _isEditing) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ProfileHeader(
                          isEditing: _isEditing,
                          onEditPressed: _toggleEdit,
                          nameController: _nameController,
                          titleController: _titleController,
                          bioController: _bioController,
                        ),
                        NetworkSection(
                          isEditing: _isEditing,
                          whatsappController: _whatsappController,
                          linkedinController: _linkedinController,
                        ),
                      ],
                    ),
                  );
                });
          }),
      endDrawer: SafeArea(
        child: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () => _controller.setTheme(Brightness.dark),
                        icon: Icon(Icons.dark_mode)),
                    IconButton(
                        onPressed: () => _controller.setTheme(Brightness.light),
                        icon: Icon(Icons.light_mode)),
                  ],
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Sair'),
                  onTap: _logout,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: StreamValueBuilder(
          streamValue: _controller.isEditingStreamValue,
          onNullWidget: SizedBox.shrink(),
          builder: (context, isEditing) {
            if (isEditing == false) {
              return SizedBox.shrink();
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Salvar'),
              ),
            );
          }),
    );
  }

  void _rightDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  Future<void> _logout() async {
    await _controller.logout();
    _navigateToHome();
  }

  void _navigateToHome() {
    if (mounted) {
      context.router.replaceAll([DashboardRoute()]);
    }
  }
}
