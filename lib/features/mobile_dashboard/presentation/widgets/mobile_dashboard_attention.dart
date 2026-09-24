// MOBILE_DASHBOARD_COMPONENTIZATION_V3
import 'package:flutter/material.dart';

import '../../../../design_system/kit.dart';
import '../../domain/domain.dart';
import 'mobile_dashboard_theme.dart';

String mobileDashboardAttentionIcon(String id) => switch (id) {
  'approvals' => 'inbox',
  _ => 'alert',
};

class MobileDashboardAttentionList extends StatelessWidget {
  final List<MdAttention> items;
  final ValueChanged<MdAttention> onItemTap;
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const MobileDashboardAttentionList({
    required this.items,
    required this.onItemTap,
    this.title = 'Needs Attention',
    this.subtitle,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var marker = MdMarker.warning;
    return SuperSectionCard2(
      title: title,
      subtitle: subtitle,
      trailing:
          trailing ??
          Text(
            'All domains',
            style: TextStyle(
              fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
              fontSize: 11,
              color: context.mdTheme.fg3,
            ),
          ),
      accentColor: mobileDashboardMarkerColor(context, marker),
      child: Column(
        children: [
          for (var index = 0; index < items.length; index++)
            MobileDashboardAttentionRow(
              item: items[index],
              last: index == items.length - 1,
              onTap: () => onItemTap(items[index]),
            ),
        ],
      ),
    );
  }
}

class MobileDashboardAttentionRow extends StatelessWidget {
  final MdAttention item;
  final bool last;
  final VoidCallback onTap;
  final DirectionalSlotTileThemeData? theme;

  const MobileDashboardAttentionRow({
    required this.item,
    required this.last,
    required this.onTap,
    this.theme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = mobileDashboardToneColor(context, item.tone);
    final rowTheme =
        theme ??
        context.mdComponentTheme.rowTheme ??
        DirectionalSlotTileThemeData(
          padding: const EdgeInsets.symmetric(vertical: 12),
          dividerColor: context.mdTheme.border,
        );

    return DirectionalSlotTile(
      onTap: onTap,
      semanticLabel: '${item.label}, ${item.count}',
      showBottomDivider: !last,
      theme: rowTheme,
      start: IconSurface(
        theme:
            context.mdComponentTheme.iconSurfaceTheme ??
            IconSurfaceThemeData(
              size: 38,
              backgroundColor: superCoreTint(color, 0x29),
              borderRadius: BorderRadius.circular(10),
            ),
        child: Icon(
          MIcons.of(mobileDashboardAttentionIcon(item.id)),
          size: 18,
          color: color,
        ),
      ),
      center: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.label,
            style: TextStyle(
              fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: context.mdTheme.fg1,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            item.description,
            style: TextStyle(
              fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
              fontSize: 11.5,
              color: context.mdTheme.fg3,
            ),
          ),
        ],
      ),
      end: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          StatusBadge(
            theme: StatusBadgeThemeData(
              minWidth: 24,
              minHeight: 24,
              padding: const EdgeInsets.symmetric(horizontal: 7),
              backgroundColor: superCoreTint(color, 0x29),
              foregroundColor: color,
            ),
            child: Text(
              '${item.count}',
              style: TextStyle(
                fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Icon(MIcons.of('chevR'), size: 16, color: context.mdTheme.fg4),
        ],
      ),
    );
  }
}
