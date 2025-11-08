import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onEditPressed;
  final TextEditingController nameController;
  final TextEditingController titleController;
  final TextEditingController bioController;

  const ProfileHeader({
    super.key,
    required this.isEditing,
    required this.onEditPressed,
    required this.nameController,
    required this.titleController,
    required this.bioController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        SizedBox(
          height: 220,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 150,
                child: GestureDetector(
                  onTap: () => showImagePickerModal(context),
                  child: Container(
                    color: theme.dividerColor,
                    child: Image.network(
                      'https://plus.unsplash.com/premium_photo-1674748154734-792a7e930ba2?w=500',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: CircleAvatar(
                  backgroundColor: colorScheme.surface.withOpacity(0.9),
                  child: IconButton(
                    icon: Icon(Icons.camera_alt, color: colorScheme.onSurface),
                    onPressed: () => showImagePickerModal(context),
                  ),
                ),
              ),
              if (!isEditing)
                Positioned(
                  top: 160,
                  right: 20,
                  child: IconButton(
                    icon: Icon(Icons.edit, color: colorScheme.onBackground),
                    onPressed: onEditPressed,
                  ),
                ),
              Positioned(
                top: 80,
                child: GestureDetector(
                  onTap: () => showImagePickerModal(context),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: theme.scaffoldBackgroundColor,
                        child: const CircleAvatar(
                          radius: 65,
                          backgroundImage: NetworkImage(
                              'https://randomuser.me/api/portraits/men/32.jpg'),
                        ),
                      ),
                      if (isEditing)
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: colorScheme.secondary,
                            child: Icon(Icons.add,
                                color: colorScheme.onSecondary, size: 24),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: isEditing ? _buildEditView(context) : _buildReadView(context),
        ),
      ],
    );
  }

  Widget _buildReadView(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(nameController.text, style: textTheme.headlineSmall),
        const SizedBox(height: 4),
        Text(titleController.text,
            style: textTheme.titleMedium
                ?.copyWith(color: Theme.of(context).hintColor)),
        const SizedBox(height: 16),
        Text(
          bioController.text,
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildEditView(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      children: [
        TextField(
            controller: nameController,
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall),
        const SizedBox(height: 8),
        TextField(
            controller: titleController,
            textAlign: TextAlign.center,
            style: textTheme.titleMedium?.copyWith(color: theme.hintColor)),
        const SizedBox(height: 16),
        TextField(
          controller: bioController,
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium,
          maxLines: 4,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  void showImagePickerModal(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    showModalBottomSheet(
      context: context,
      backgroundColor:
          theme.cardColor, // Use theme's color for the modal background
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 16),
              Text('Imagem', style: textTheme.titleLarge),
              const SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.photo_library, color: theme.hintColor),
                title: Text('Escolher na galeria', style: textTheme.bodyLarge),
                onTap: context.router.pop,
                tileColor: theme
                    .scaffoldBackgroundColor, // Background for the selected item
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: Icon(Icons.camera_alt, color: theme.hintColor),
                title: Text('Tirar Foto', style: textTheme.bodyLarge),
                onTap: context.router.pop,
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: Icon(Icons.delete, color: theme.hintColor),
                title: Text('Remover foto atual', style: textTheme.bodyLarge),
                onTap: context.router.pop,
              ),
            ],
          ),
        );
      },
    );
  }
}
