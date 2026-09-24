// MOBILE_DASHBOARD_COMPONENTIZATION_V3
import 'package:flutter/material.dart';
import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/features/mobile_dashboard/domain/domain.dart';
import 'package:gl_mobile_app/features/mobile_dashboard/presentation/widgets/mobile_dashboard_header.dart';
import 'package:gl_mobile_app/features/mobile_dashboard/presentation/widgets/mobile_dashboard_pressable.dart';
import 'package:gl_mobile_app/features/mobile_dashboard/presentation/widgets/mobile_dashboard_theme.dart';

class MobileDashboardDrawer extends StatelessWidget {
  final bool open;
  final MdWorkspace workspace;
  final bool online;
  final ValueChanged<bool> onOnlineChanged;
  final ValueChanged<String> onNavigationSelected;
  final VoidCallback onSignOut;
  final VoidCallback onDismiss;
  final List<(String, String)> navigationItems;

  const MobileDashboardDrawer({
    required this.open,
    required this.workspace,
    required this.online,
    required this.onOnlineChanged,
    required this.onNavigationSelected,
    required this.onSignOut,
    required this.onDismiss,
    this.navigationItems = const [
      ('Home', 'home'),
      ('Accounts', 'inbox'),
      ('Journal', 'doc'),
      ('Contacts', 'user'),
      ('Reports', 'poll'),
      ('Settings', 'dots'),
    ],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !open,
      child: AnimatedOpacity(
        opacity: open ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: Stack(
          children: [
            GestureDetector(
              onTap: onDismiss,
              child: Container(
                color: context.mdColors.scrim.withValues(alpha: 0.5),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              top: 0,
              bottom: 0,
              left: open ? 0 : -300,
              width: 300,
              child: Material(
                color:
                    context.mdMaterialTheme.drawerTheme.backgroundColor ??
                    context.mdTheme.surface,
                child: Column(
                  children: [
                    DrawerWorkspaceHeader(workspace: workspace),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(10),
                        children: [
                          for (final item in navigationItems)
                            DrawerItem(
                              label: item.$1,
                              icon: item.$2,
                              onTap: () => onNavigationSelected(item.$1),
                            ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            height: 1,
                            color: context.mdTheme.border,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 2, 12, 6),
                            child: Text(
                              'PREFERENCES',
                              style: TextStyle(
                                fontFamily:
                                    context.mdTextTheme.bodyMedium?.fontFamily,
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                                letterSpacing: 0.9,
                                color: context.mdTheme.fg3,
                              ),
                            ),
                          ),
                          MobileDashboardSegmentedPreference(
                            label: 'Connection',
                            value: online ? 0 : 1,
                            options: const ['Online', 'Offline'],
                            onChanged: (index) => onOnlineChanged(index == 0),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: context.mdTheme.border),
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(
                        10,
                        12,
                        10,
                        MediaQuery.paddingOf(context).bottom + 14,
                      ),
                      child: MobileDashboardPressable(
                        onTap: onSignOut,
                        child: Container(
                          constraints: const BoxConstraints(minHeight: 48),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Icon(
                                MIcons.of('ban'),
                                size: 19,
                                color: context.mdColors.error,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Sign out',
                                style: TextStyle(
                                  fontFamily: context
                                      .mdTextTheme
                                      .bodyMedium
                                      ?.fontFamily,
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w600,
                                  color: context.mdColors.error,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerWorkspaceHeader extends StatelessWidget {
  final MdWorkspace workspace;

  const DrawerWorkspaceHeader({super.key, required this.workspace});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        18,
        MediaQuery.paddingOf(context).top + 18,
        18,
        16,
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: context.mdTheme.border)),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: superCoreTint(context.mdColors.primary, 0x29),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              MIcons.of('grid'),
              size: 20,
              color: context.mdColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workspace.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: context.mdTextTheme.headlineMedium?.fontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: context.mdTheme.fg1,
                  ),
                ),
                Text(
                  workspace.subtitle,
                  style: TextStyle(
                    fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                    fontSize: 11,
                    color: context.mdTheme.fg3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String label;
  final String icon;
  final VoidCallback onTap;
  final DirectionalSlotTileThemeData? theme;

  const DrawerItem({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return DirectionalSlotTile(
      onTap: onTap,
      semanticLabel: label,
      theme:
          theme ??
          context.mdComponentTheme.rowTheme ??
          const DirectionalSlotTileThemeData(
            minHeight: 48,
            padding: EdgeInsets.all(12),
          ),
      start: Icon(MIcons.of(icon), size: 19, color: context.mdTheme.fg2),
      center: Text(
        label,
        style: TextStyle(
          fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
          fontSize: 14.5,
          fontWeight: FontWeight.w600,
          color: context.mdTheme.fg1,
        ),
      ),
      end: Icon(MIcons.of('chevR'), size: 16, color: context.mdTheme.fg4),
    );
  }
}
