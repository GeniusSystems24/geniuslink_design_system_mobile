import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../../design_system/kit.dart';
import '../../domain/domain.dart';
import 'mobile_dashboard_pressable.dart';
import 'mobile_dashboard_theme.dart';

class MobileDashboardAppBar extends StatelessWidget {
  final MdWorkspace workspace;
  final bool workspaceMenuOpen;
  final VoidCallback onWorkspaceTap;
  final VoidCallback onNotificationsTap;
  final VoidCallback onMenuTap;
  final String? notificationBadge;

  const MobileDashboardAppBar({
    required this.workspace,
    required this.workspaceMenuOpen,
    required this.onWorkspaceTap,
    required this.onNotificationsTap,
    required this.onMenuTap,
    this.notificationBadge = '8',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: EdgeInsets.fromLTRB(
            18,
            MediaQuery.paddingOf(context).top + 14,
            18,
            12,
          ),
          decoration: BoxDecoration(
            color: (context.mdMaterialTheme.appBarTheme.backgroundColor ??
                    context.mdColors.surface)
                .withAlpha(0xE6),
            border: Border(
              bottom: BorderSide(color: context.mdTheme.border),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: MobileDashboardPressable(
                  onTap: onWorkspaceTap,
                  semanticLabel: 'Switch workspace',
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: superCoreTint(context.mdColors.primary, 0x29),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          MIcons.of('grid'),
                          size: 19,
                          color: context.mdColors.primary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              workspace.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: context
                                    .mdTextTheme.headlineMedium?.fontFamily,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: context.mdTheme.fg1,
                              ),
                            ),
                            Text(
                              workspace.subtitle,
                              style: TextStyle(
                                fontFamily:
                                    context.mdTextTheme.bodyMedium?.fontFamily,
                                fontSize: 10.5,
                                color: context.mdTheme.fg3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AnimatedRotation(
                        turns: workspaceMenuOpen ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          MIcons.of('chevD'),
                          size: 15,
                          color: context.mdTheme.fg3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              MobileDashboardIconButton(
                icon: 'bell',
                onTap: onNotificationsTap,
                badge: notificationBadge,
                semanticLabel: 'Notifications',
              ),
              const SizedBox(width: 8),
              MobileDashboardIconButton(
                icon: 'menu',
                onTap: onMenuTap,
                semanticLabel: 'Open navigation menu',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileDashboardOfflineBanner extends StatelessWidget {
  final String message;

  const MobileDashboardOfflineBanner({
    this.message = "You're offline — showing last-known data",
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: superCoreTint(context.mdColors.tertiary, 0x29),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
      child: Row(
        children: [
          Icon(MIcons.of('ban'), size: 15, color: context.mdColors.tertiary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: context.mdColors.tertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MobileDashboardIconButton extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;
  final String? badge;
  final String? semanticLabel;

  const MobileDashboardIconButton({
    required this.icon,
    required this.onTap,
    this.badge,
    this.semanticLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MobileDashboardPressable(
      onTap: onTap,
      semanticLabel: semanticLabel,
      child: Container(
        width: 38,
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.mdTheme.inputBg,
          border: Border.all(color: context.mdTheme.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Icon(MIcons.of(icon), size: 18, color: context.mdTheme.fg1),
            if (badge != null)
              Positioned(
                top: -8,
                right: -8,
                child: Container(
                  constraints: const BoxConstraints(minWidth: 15),
                  height: 15,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: context.mdColors.error,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: context.mdTheme.bg, width: 1.5),
                  ),
                  child: Text(
                    badge!,
                    style: TextStyle(
                      fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: context.mdColors.onError,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class MobileDashboardWorkspaceMenu extends StatelessWidget {
  final List<MdWorkspace> workspaces;
  final MdWorkspace selectedWorkspace;
  final ValueChanged<MdWorkspace> onSelected;
  final VoidCallback onDismiss;

  const MobileDashboardWorkspaceMenu({
    required this.workspaces,
    required this.selectedWorkspace,
    required this.onSelected,
    required this.onDismiss,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          GestureDetector(
            onTap: onDismiss,
            child: Container(color: Colors.transparent),
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 60,
            left: 18,
            right: 18,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: context.mdTheme.surface,
                  border: Border.all(color: context.mdTheme.borderStrong),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: context.mdColors.shadow.withValues(alpha: 0.5),
                      blurRadius: 28,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 8, 10, 6),
                      child: Text(
                        'SWITCH WORKSPACE',
                        style: TextStyle(
                          fontFamily:
                              context.mdTextTheme.bodyMedium?.fontFamily,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          letterSpacing: 0.8,
                          color: context.mdTheme.fg3,
                        ),
                      ),
                    ),
                    for (final workspace in workspaces)
                      _WorkspaceMenuItem(
                        workspace: workspace,
                        selected: workspace.id == selectedWorkspace.id,
                        onTap: () => onSelected(workspace),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkspaceMenuItem extends StatelessWidget {
  final MdWorkspace workspace;
  final bool selected;
  final VoidCallback onTap;

  const _WorkspaceMenuItem({
    required this.workspace,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(minHeight: 48),
        decoration: BoxDecoration(
          color: selected ? context.mdTheme.hover : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? context.mdColors.primary
                    : context.mdTheme.inputBg,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Text(
                workspace.name.isEmpty ? '?' : workspace.name[0],
                style: TextStyle(
                  fontFamily: context.mdTextTheme.headlineMedium?.fontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: selected
                      ? context.mdColors.onPrimary
                      : context.mdTheme.fg3,
                ),
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workspace.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: context.mdTheme.fg1,
                    ),
                  ),
                  Text(
                    workspace.subtitle,
                    style: TextStyle(
                      fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                      fontSize: 10.5,
                      color: context.mdTheme.fg3,
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              Icon(MIcons.of('check'), size: 16, color: context.mdColors.primary),
          ],
        ),
      ),
    );
  }
}

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
                color: context.mdMaterialTheme.drawerTheme.backgroundColor ??
                    context.mdTheme.surface,
                child: Column(
                  children: [
                    _DrawerWorkspaceHeader(workspace: workspace),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(10),
                        children: [
                          for (final item in navigationItems)
                            _DrawerItem(
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
                                fontFamily: context
                                    .mdTextTheme.bodyMedium?.fontFamily,
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
                            onChanged: (index) =>
                                onOnlineChanged(index == 0),
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
                                      .mdTextTheme.bodyMedium?.fontFamily,
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

class _DrawerWorkspaceHeader extends StatelessWidget {
  final MdWorkspace workspace;

  const _DrawerWorkspaceHeader({required this.workspace});

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

class _DrawerItem extends StatelessWidget {
  final String label;
  final String icon;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MobileDashboardPressable(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 48),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(MIcons.of(icon), size: 19, color: context.mdTheme.fg2),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  color: context.mdTheme.fg1,
                ),
              ),
            ),
            Icon(MIcons.of('chevR'), size: 16, color: context.mdTheme.fg4),
          ],
        ),
      ),
    );
  }
}

class MobileDashboardSegmentedPreference extends StatelessWidget {
  final String label;
  final int value;
  final List<String> options;
  final ValueChanged<int> onChanged;

  const MobileDashboardSegmentedPreference({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: context.mdTheme.fg2,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: context.mdTheme.inputBg,
              border: Border.all(color: context.mdTheme.border),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                for (var index = 0; index < options.length; index++)
                  Expanded(
                    child: GestureDetector(
                      onTap: () => onChanged(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        constraints: const BoxConstraints(minHeight: 32),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: index == value
                              ? context.mdColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          options[index],
                          style: TextStyle(
                            fontFamily:
                                context.mdTextTheme.bodyMedium?.fontFamily,
                            fontSize: 12.5,
                            fontWeight: index == value
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: index == value
                                ? context.mdColors.onPrimary
                                : context.mdTheme.fg3,
                          ),
                        ),
                      ),
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
