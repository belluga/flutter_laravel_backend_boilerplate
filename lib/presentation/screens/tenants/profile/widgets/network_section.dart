// lib/widgets/network_section.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NetworkSection extends StatelessWidget {
  final bool isEditing;
  final TextEditingController whatsappController;
  final TextEditingController linkedinController;

  const NetworkSection({
    super.key,
    required this.isEditing,
    required this.whatsappController,
    required this.linkedinController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.cardColor,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.share, color: theme.textTheme.bodyLarge?.color),
              const SizedBox(width: 8),
              Text('Network', style: theme.textTheme.titleLarge),
            ],
          ),
          const SizedBox(height: 24),
          isEditing ? _buildEditField(context, "Whatsapp", whatsappController) : _buildReadField(context, "Whatsapp", whatsappController.text),
          const SizedBox(height: 16),
          isEditing ? _buildEditField(context, "Linkedin", linkedinController) : _buildReadField(context, "Linkedin", linkedinController.text),
        ],
      ),
    );
  }

  Widget _buildReadField(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor)),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                value,
                style: theme.textTheme.bodyLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: Icon(Icons.copy, color: theme.hintColor, size: 20),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$label copiado para a área de transferência!')),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEditField(BuildContext context, String label, TextEditingController controller) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: theme.textTheme.bodyLarge,
        ),
      ],
    );
  }
}