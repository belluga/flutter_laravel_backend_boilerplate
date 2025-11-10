import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/domain/menu/menu_entry_model.dart';
import 'package:belluga_boilerplate/domain/user/user_belluga.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/common/widgets/tenant_bottom_navigation.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/menu/controllers/menu_screen_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/menu/screens/menu_screen/widgets/menu_entry_tile.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/menu/screens/menu_screen/widgets/menu_profile_header.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value_builder.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final _controller = GetIt.I.get<MenuScreenController>();

  @override
  void initState() {
    super.initState();
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      bottomNavigationBar: TenantBottomNavigation(
        currentIndex: 2,
        onTap: _handleNavigationTap,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              StreamValueBuilder<UserBelluga?>(
                streamValue: _controller.userStreamValue,
                onNullWidget: const SizedBox.shrink(),
                builder: (context, user) {
                  final fullName =
                      user?.profile.nameValue?.value ?? 'Convidado';
                  return MenuProfileHeader(
                    fullName: fullName,
                    subtitle: 'Meu Perfil',
                    avatarInitials: _initialsFromFullName(fullName),
                    onProfileTap: () =>
                        context.router.push(const ProfileRoute()),
                    onLogoutTap: _handleLogoutTap,
                  );
                },
              ),
              Divider(
                height: 1,
                indent: 16,
                endIndent: 16,
              ),
              Expanded(
                child: StreamValueBuilder<List<MenuEntryModel>>(
                  streamValue: _controller.menuEntriesStreamValue,
                  onNullWidget: const SizedBox.shrink(),
                  builder: (context, entries) => ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      return MenuEntryTile(
                        entry: entry,
                        onPressed: () => _handleEntryTap(entry),
                        onToggleChanged:
                            entry.actionType == MenuEntryActionType.toggle
                                ? (value) => _controller.updateFocusMode(value)
                                : null,
                      );
                    },
                    separatorBuilder: (_, __) => Divider(
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleNavigationTap(int index) {
    if (index == 0) {
      context.router.replace(const DashboardRoute());
      return;
    }

    if (index == 1) {
      _showPlaceholderMessage('Comunidades em breve');
    }
  }

  void _handleEntryTap(MenuEntryModel entry) {
    switch (entry.symbol) {
      case MenuEntrySymbol.events:
        context.router.push(const EventSearchRoute());
        return;
      case MenuEntrySymbol.courses:
        context.router.push(const CoursesListRoute());
        return;
      case MenuEntrySymbol.tracks:
        context.router.push(const FastTrackListRoute());
        return;
      default:
        _showPlaceholderMessage('${entry.label} em breve');
    }
  }

  Future<void> _handleLogoutTap() async {
    await _controller.logout();
    if (!mounted) return;
    context.router.replaceAll([const AuthLoginRoute()]);
  }

  String _initialsFromFullName(String fullName) {
    final parts = fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) {
      return '??';
    }

    final firstInitial = parts.first.characters.first;
    final lastInitial = parts.length > 1 ? parts.last.characters.first : '';
    return (firstInitial + lastInitial).toUpperCase();
  }

  void _showPlaceholderMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
