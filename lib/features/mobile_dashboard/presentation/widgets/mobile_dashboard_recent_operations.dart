import 'package:flutter/material.dart';

import '../../domain/domain.dart';
import 'mobile_dashboard_shared.dart';
import 'mobile_dashboard_skeleton.dart';
import 'mobile_dashboard_theme.dart';

typedef MobileDashboardOperationAmountResolver = double Function(
  MdOperation operation,
);

class MobileDashboardRecentOperations extends StatelessWidget {
  final List<MdOperation> operations;
  final String currency;
  final bool loading;
  final MobileDashboardOperationAmountResolver amountFor;
  final VoidCallback onViewAll;
  final int skeletonCount;

  const MobileDashboardRecentOperations({
    required this.operations,
    required this.currency,
    required this.loading,
    required this.amountFor,
    required this.onViewAll,
    this.skeletonCount = 5,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MobileDashboardSectionHeader(
          title: 'Recent Operations',
          marker: MdMarker.positive,
          subtitle: 'Latest 5 in this domain',
          trailing: MobileDashboardViewAllButton(onTap: onViewAll),
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
              if (loading)
                for (var index = 0; index < skeletonCount; index++)
                  MobileDashboardOperationSkeleton(
                    last: index == skeletonCount - 1,
                  )
              else
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

class MobileDashboardOperationSkeleton extends StatelessWidget {
  final bool last;

  const MobileDashboardOperationSkeleton({
    required this.last,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        border: last
            ? null
            : Border(bottom: BorderSide(color: context.mdTheme.border)),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Expanded(
                child: MobileDashboardSkeleton(width: 160, height: 13),
              ),
              SizedBox(width: 12),
              MobileDashboardSkeleton(width: 64, height: 13),
            ],
          ),
          SizedBox(height: 9),
          Row(
            children: [
              MobileDashboardSkeleton(width: 110, height: 9),
              Spacer(),
              MobileDashboardSkeleton(width: 40, height: 9),
            ],
          ),
        ],
      ),
    );
  }
}
