import 'package:flutter/material.dart';

class MenuProfileHeader extends StatelessWidget {
  final String fullName;
  final String subtitle;
  final String avatarInitials;
  final VoidCallback onProfileTap;
  final VoidCallback onLogoutTap;

  const MenuProfileHeader({
    super.key,
    required this.fullName,
    required this.subtitle,
    required this.avatarInitials,
    required this.onProfileTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: colorScheme.primary,
            child: Text(
              avatarInitials,
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: colorScheme.onPrimaryContainer),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: onProfileTap,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: colorScheme.primary,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          MaterialButton(
            onPressed: onProfileTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Sair"),
                SizedBox(width: 8),
                Icon(
                  Icons.logout,
                  color: colorScheme.primary,
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
