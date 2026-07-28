import 'package:flutter/material.dart';

import '../../../../design_system/kit.dart';
import '../../domain/domain.dart';
import 'mobile_dashboard_pressable.dart';
import 'mobile_dashboard_shared.dart';
import 'mobile_dashboard_theme.dart';

String mobileDashboardActionIcon(String id) => switch (id) {
  'deposit' || 'sale' => 'plus',
  'withdraw' || 'return' => 'back',
  'transfer' => 'send',
  'beneficiaries' || 'customers' => 'user',
  'reconcile' => 'check',
  'cards' || 'suppliers' => 'grid',
  'reports' => 'poll',
  'accounts' || 'fixed' || 'items' => 'lock',
  'journal' => 'edit',
  'receipt' || 'purchase' || 'inventory' => 'inbox',
  'coa' => 'dots',
  _ => 'doc',
};

class MobileDashboardQuickActions extends StatelessWidget {
  final List<MdAction> actions;
  final ValueChanged<MdAction> onActionTap;
  final VoidCallback onViewAll;
  final String title;
  final int previewLimit;

  const MobileDashboardQuickActions({
    required this.actions,
    required this.onActionTap,
    required this.onViewAll,
    this.title = 'Quick Actions',
    this.previewLimit = 7,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final visibleActions = actions.take(previewLimit).toList(growable: false);
    var title2 = title;
    var trailing = MobileDashboardViewAllButton(onTap: onViewAll);
    var marker = MdMarker.primary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SuperSectionTitle1(
          title: title2,
          subtitle: null,
          trailing: trailing,
          accentColor: mobileDashboardMarkerColor(context, marker),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.82,
          children: [
            for (final action in visibleActions)
              MobileDashboardActionTile(
                icon: mobileDashboardActionIcon(action.id),
                label: action.label,
                color: context.mdColors.primary,
                onTap: () => onActionTap(action),
              ),
            MobileDashboardActionTile(
              icon: 'dots',
              label: 'View all',
              color: context.mdTheme.fg3,
              onTap: onViewAll,
              outlined: true,
            ),
          ],
        ),
      ],
    );
  }
}

class MobileDashboardActionTile extends StatelessWidget {
  final String icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final bool outlined;

  const MobileDashboardActionTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.outlined = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MobileDashboardPressable(
      onTap: onTap,
      semanticLabel: label,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: outlined ? Colors.transparent : superCoreTint(color, 0x21),
              border: outlined
                  ? Border.all(color: context.mdTheme.borderStrong, width: 1.5)
                  : null,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(MIcons.of(icon), size: 20, color: color),
          ),
          const SizedBox(height: 7),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: context.mdTheme.fg2,
            ),
          ),
        ],
      ),
    );
  }
}

class MobileDashboardActionsSheet extends StatelessWidget {
  final List<MdAction> actions;
  final ValueChanged<MdAction> onActionTap;
  final List<(String, String)> groups;

  const MobileDashboardActionsSheet({
    required this.actions,
    required this.onActionTap,
    this.groups = const [('create', 'Create new'), ('manage', 'Manage')],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        18,
        8,
        18,
        MediaQuery.paddingOf(context).bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: context.mdTheme.borderStrong,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              'All Actions',
              style: TextStyle(
                fontFamily: context.mdTextTheme.headlineMedium?.fontFamily,
                fontWeight: FontWeight.w800,
                fontSize: 18,
                color: context.mdTheme.fg1,
              ),
            ),
          ),
          for (final group in groups)
            if (actions.any((action) => action.group == group.$1)) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 4),
                child: Text(
                  group.$2.toUpperCase(),
                  style: TextStyle(
                    fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    letterSpacing: 0.9,
                    color: context.mdTheme.fg3,
                  ),
                ),
              ),
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.82,
                children: [
                  for (final action in actions.where(
                    (item) => item.group == group.$1,
                  ))
                    MobileDashboardActionTile(
                      icon: mobileDashboardActionIcon(action.id),
                      label: action.label,
                      color: context.mdColors.primary,
                      onTap: () => onActionTap(action),
                    ),
                ],
              ),
              const SizedBox(height: 18),
            ],
        ],
      ),
    );
  }
}
