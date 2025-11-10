import 'package:belluga_boilerplate/domain/menu/menu_entry_model.dart';
import 'package:flutter/material.dart';

class MenuEntryTile extends StatelessWidget {
  final MenuEntryModel entry;
  final VoidCallback? onPressed;
  final ValueChanged<bool>? onToggleChanged;

  const MenuEntryTile({
    super.key,
    required this.entry,
    this.onPressed,
    this.onToggleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final icon = _iconFor(entry.symbol);
    final trailing = entry.actionType == MenuEntryActionType.toggle
        ? Switch.adaptive(
            value: entry.isToggleOn,
            onChanged: onToggleChanged,
            activeTrackColor: colorScheme.primary,
          )
        : Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant);

    return InkWell(
      onTap: entry.actionType == MenuEntryActionType.navigation ? onPressed : null,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: colorScheme.onPrimaryContainer),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.label,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: colorScheme.onSurface),
                  ),
                  if (entry.caption != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      entry.caption!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }

  IconData _iconFor(MenuEntrySymbol icon) {
    switch (icon) {
      case MenuEntrySymbol.documents:
        return Icons.attach_file;
      case MenuEntrySymbol.pendingDocuments:
        return Icons.pending_actions;
      case MenuEntrySymbol.finance:
        return Icons.account_balance_wallet;
      case MenuEntrySymbol.events:
        return Icons.event;
      case MenuEntrySymbol.courses:
        return Icons.menu_book;
      case MenuEntrySymbol.tracks:
        return Icons.assistant_direction;
      case MenuEntrySymbol.notes:
        return Icons.description_outlined;
      case MenuEntrySymbol.learningMap:
        return Icons.map;
      case MenuEntrySymbol.certificates:
        return Icons.verified;
      case MenuEntrySymbol.focusMode:
        return Icons.visibility_off;
    }
  }
}
