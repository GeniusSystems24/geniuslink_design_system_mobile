// Reusable vertical audit/activity list.

import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart';

class AuditItem {
  final String title;
  final DateTime doAt;
  final String doBy;
  final String? description;
  final Color? indicatorColor;
  final bool cancelled;

  const AuditItem({
    required this.title,
    required this.doAt,
    required this.doBy,
    this.description,
    this.indicatorColor,
    this.cancelled = false,
  });
}

class AuditColumn extends StatelessWidget {
  final List<AuditItem> items;
  final bool connectIndictors;

  const AuditColumn({
    super.key,
    required this.items,
    this.connectIndictors = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SuperMaterialThemeData.of(context);
    final superTheme = theme.superTheme;
    final fontFamily = theme.textTheme.bodyMedium?.fontFamily;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < items.length; i++)
          Opacity(
            opacity: items[i].cancelled ? 0.50 : 1.0,
            child: Padding(
              padding: EdgeInsets.only(bottom: i != items.length - 1 ? 14 : 0),
              child: _AuditColumnItem(
                item: items[i],
                fontFamily: fontFamily,
                titleColor: superTheme.fg1,
                descriptionColor: superTheme.fg2,
                metadataColor: superTheme.fg3,
                defaultIndicatorColor: superTheme.fg3,
                connectorColor: superTheme.fg3.withValues(alpha: 0.40),
                connectIndictors: connectIndictors,
                isFirst: i == 0,
                isLast: i == items.length - 1,
                bottomSpacing: i != items.length - 1 ? 14 : 0,
              ),
            ),
          ),
      ],
    );
  }
}

class _AuditColumnItem extends StatelessWidget {
  final AuditItem item;
  final String? fontFamily;
  final Color titleColor;
  final Color descriptionColor;
  final Color metadataColor;
  final Color defaultIndicatorColor;
  final Color connectorColor;
  final bool connectIndictors;
  final bool isFirst;
  final bool isLast;
  final double bottomSpacing;

  const _AuditColumnItem({
    required this.item,
    required this.fontFamily,
    required this.titleColor,
    required this.descriptionColor,
    required this.metadataColor,
    required this.defaultIndicatorColor,
    required this.connectorColor,
    required this.connectIndictors,
    required this.isFirst,
    required this.isLast,
    required this.bottomSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final cancellationDecoration = item.cancelled
        ? TextDecoration.lineThrough
        : TextDecoration.none;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 18,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                if (connectIndictors && !(isFirst && isLast))
                  Positioned(
                    left: 2.5,
                    top: isFirst ? 9 : 0,
                    bottom: isLast ? null : -bottomSpacing,
                    height: isLast ? 9 : null,
                    child: Container(
                      width: 1,
                      decoration: BoxDecoration(
                        color: connectorColor,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                Positioned(
                  left: 0,
                  top: 6,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: item.indicatorColor ?? defaultIndicatorColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: titleColor,
                    height: 1.25,
                    decoration: cancellationDecoration,
                  ),
                ),
                if (item.description != null &&
                    item.description!.trim().isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(
                    item.description!,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 12,
                      color: descriptionColor,
                      height: 1.3,
                    ),
                  ),
                ],
                const SizedBox(height: 3),
                Text(
                  '${_formatAuditDate(item.doAt)} · ${item.doBy}',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 11.5,
                    color: metadataColor,
                    height: 1.3,
                    decoration: cancellationDecoration,
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

String _formatAuditDate(DateTime value) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  String twoDigits(int value) => value.toString().padLeft(2, '0');

  return '${months[value.month - 1]} ${value.day}, ${value.year} '
      '${twoDigits(value.hour)}:${twoDigits(value.minute)}';
}
