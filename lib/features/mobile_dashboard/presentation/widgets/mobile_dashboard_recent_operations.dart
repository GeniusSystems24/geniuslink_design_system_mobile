import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart';

import '../../domain/domain.dart';
import 'mobile_dashboard_shared.dart';
import 'mobile_dashboard_theme.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SuperSectionTitle1(
          title: title2,
          subtitle: subtitle2,
          trailing: trailing,
          accentColor: mobileDashboardMarkerColor(context, marker),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: context.mdTheme.surface,
            border: Border.all(color: context.mdTheme.border),
            borderRadius: BorderRadius.circular(14),
          ),
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
        ),
      ],
    );
  }
}

class MobileDashboardOperationRow extends StatelessWidget {
  final MdOperation operation;
  final String currency;
  final double amount;
  final bool last;

  const MobileDashboardOperationRow({
    required this.operation,
    required this.currency,
    required this.amount,
    required this.last,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final amountColor = operation.isCredit
        ? context.mdColors.secondary
        : context.mdColors.error;
    final sign = operation.isCredit ? '+' : '−';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: last
            ? null
            : Border(bottom: BorderSide(color: context.mdTheme.border)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
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
              ),
              const SizedBox(width: 10),
              Text(
                '$sign$currency ${mobileDashboardNumber(amount, decimals: 2)}',
                style: TextStyle(
                  fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: amountColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
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
              const Spacer(),
              Text(
                operation.timeLabel,
                style: TextStyle(
                  fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                  fontSize: 11,
                  color: context.mdTheme.fg3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
