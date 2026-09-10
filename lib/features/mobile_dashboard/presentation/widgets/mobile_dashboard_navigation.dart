// MOBILE_DASHBOARD_COMPONENTIZATION_V3
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:gl_mobile_app/features/mobile_dashboard/domain/object_values/navigation_destination.dart';

import '../../../../design_system/kit.dart';
import 'mobile_dashboard_pressable.dart';
import 'mobile_dashboard_theme.dart';

class MobileDashboardFloatingSearchButton extends StatelessWidget {
  final VoidCallback onTap;

  const MobileDashboardFloatingSearchButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return MobileDashboardPressable(
      onTap: onTap,
      semanticLabel: 'Search all operations',
      child: Container(
        width: 54,
        height: 54,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.mdColors.primary,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: superCoreTint(context.mdColors.primary, 0xB3),
              blurRadius: 22,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Icon(
          Icons.search_rounded,
          size: 24,
          color: context.mdColors.onPrimary,
        ),
      ),
    );
  }
}

class MobileDashboardBottomNavigation extends StatelessWidget {
  final String selectedId;
  final ValueChanged<String> onSelected;
  final List<MobileDashboardNavigationDestination> items;

  const MobileDashboardBottomNavigation({
    required this.selectedId,
    required this.onSelected,
    this.items = const [
      (id: 'home', label: 'Home', icon: 'home'),
      (id: 'accounts', label: 'Accounts', icon: 'inbox'),
      (id: 'journal', label: 'Journal', icon: 'doc'),
      (id: 'more', label: 'More', icon: 'dots'),
    ],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          decoration: BoxDecoration(
            color:
                (context
                            .mdMaterialTheme
                            .bottomNavigationBarTheme
                            .backgroundColor ??
                        context.mdColors.surface)
                    .withAlpha(0xEB),
            border: Border(top: BorderSide(color: context.mdTheme.border)),
          ),
          padding: EdgeInsets.only(
            top: 8,
            bottom: MediaQuery.paddingOf(context).bottom + 10,
          ),
          child: Row(
            children: [
              for (final item in items)
                Expanded(
                  child: _BottomNavigationItem(
                    item: item,
                    selected: item.id == selectedId,
                    onTap: () => onSelected(item.id),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNavigationItem extends StatelessWidget {
  final MobileDashboardNavigationDestination item;
  final bool selected;
  final VoidCallback onTap;

  const _BottomNavigationItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? context.mdColors.primary : context.mdTheme.fg3;
    return LabeledActionTile(
      onTap: onTap,
      semanticLabel: item.label,
      theme: (context.mdComponentTheme.actionTileTheme ??
              const LabeledActionTileThemeData())
          .copyWith(
            gap: 4,
            minHeight: 48,
            alignment: Alignment.center,
          ),
      top: Icon(MIcons.of(item.icon), size: 21, color: color),
      bottom: Text(
        item.label,
        style: TextStyle(
          fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
          fontSize: 10,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}
