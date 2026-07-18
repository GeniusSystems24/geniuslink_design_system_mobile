import 'package:flutter/material.dart';

import '../../../../design_system/kit.dart';
import '../../domain/domain.dart';
import 'mobile_dashboard_pressable.dart';
import 'mobile_dashboard_shared.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MobileDashboardSectionHeader(
          title: title,
          marker: MdMarker.warning,
          subtitle: subtitle,
          trailing: trailing ??
              Text(
                'All domains',
                style: TextStyle(
                  fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                  fontSize: 11,
                  color: context.mdTheme.fg3,
                ),
              ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: context.mdTheme.surface,
            border: Border.all(color: context.mdTheme.border),
            borderRadius: BorderRadius.circular(14),
          ),
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
        ),
      ],
    );
  }
}

class MobileDashboardAttentionRow extends StatelessWidget {
  final MdAttention item;
  final bool last;
  final VoidCallback onTap;

  const MobileDashboardAttentionRow({
    required this.item,
    required this.last,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = mobileDashboardToneColor(context, item.tone);
    return MobileDashboardPressable(
      onTap: onTap,
      semanticLabel: '${item.label}, ${item.count}',
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: last
              ? null
              : Border(bottom: BorderSide(color: context.mdTheme.border)),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: superCoreTint(color, 0x29),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                MIcons.of(mobileDashboardAttentionIcon(item.id)),
                size: 18,
                color: color,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
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
            ),
            const SizedBox(width: 8),
            Container(
              constraints: const BoxConstraints(minWidth: 24),
              height: 24,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 7),
              decoration: BoxDecoration(
                color: superCoreTint(color, 0x29),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                '${item.count}',
                style: TextStyle(
                  fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Icon(MIcons.of('chevR'), size: 16, color: context.mdTheme.fg4),
          ],
        ),
      ),
    );
  }
}
