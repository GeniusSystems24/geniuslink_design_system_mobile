// MOBILE_DASHBOARD_COMPONENTIZATION_V3
import 'package:flutter/material.dart';

import '../../domain/domain.dart';
import 'mobile_dashboard_shared.dart';
import 'mobile_dashboard_theme.dart';
import '../../../../design_system/kit.dart';

typedef MobileDashboardOperationAmountResolver =
    double Function(MdOperation operation);

class MobileDashboardRecentOperations extends StatelessWidget {
  final List<MdOperation> operations;
  final String currency;
  final MobileDashboardOperationAmountResolver amountFor;
  final VoidCallback onViewAll;
  final String title;
  final String subtitle;

  const MobileDashboardRecentOperations({
    required this.operations,
    required this.currency,
    required this.amountFor,
    required this.onViewAll,
    this.title = 'Recent Operations',
    this.subtitle = 'Latest 5 in this domain',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var title2 = title;
    var subtitle2 = subtitle;
    var trailing = MobileDashboardViewAllButton(onTap: onViewAll);
    var marker = MdMarker.positive;
    return SuperSectionCard2(
      title: title2,
      subtitle: subtitle2,
      trailing: trailing,
      accentColor: mobileDashboardMarkerColor(context, marker),
      child: Column(
        children: [
          for (var index = 0; index < operations.length; index++)
            MobileDashboardOperationRow(
              operation: operations[index],
              currency: currency,
              amount: amountFor(operations[index]),
              last: index == operations.length - 1,
            ),
        ],
      ),
    );
  }
}

class MobileDashboardOperationRow extends StatelessWidget {
  final MdOperation operation;
  final String currency;
  final double amount;
  final bool last;
  final TwoRowTileThemeData? theme;

  const MobileDashboardOperationRow({
    required this.operation,
    required this.currency,
    required this.amount,
    required this.last,
    this.theme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final amountColor = operation.isCredit
        ? context.mdColors.secondary
        : context.mdColors.error;
    final sign = operation.isCredit ? '+' : '−';

    return TwoRowTile(
      semanticLabel:
          '${operation.description}, $sign$currency ${mobileDashboardNumber(amount, decimals: 2)}',
      showBottomDivider: !last,
      theme: theme ??
          context.mdComponentTheme.twoRowTheme ??
          TwoRowTileThemeData(
            padding: const EdgeInsets.symmetric(vertical: 12),
            rowGap: 7,
            columnGap: 10,
            dividerColor: context.mdTheme.border,
          ),
      topStart: Text(
        operation.description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: context.mdTheme.fg1,
        ),
      ),
      topEnd: Text(
        '$sign$currency ${mobileDashboardNumber(amount, decimals: 2)}',
        style: TextStyle(
          fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: amountColor,
        ),
      ),
      bottomStart: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            operation.reference,
            style: TextStyle(
              fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
              fontSize: 11,
              color: context.mdColors.primary,
            ),
          ),
          const SizedBox(width: 8),
          MobileDashboardPill(
            label: operation.type,
            color: mobileDashboardToneColor(context, operation.tone),
          ),
        ],
      ),
      bottomEnd: Text(
        operation.timeLabel,
        style: TextStyle(
          fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
          fontSize: 11,
          color: context.mdTheme.fg3,
        ),
      ),
    );
  }
}
