// MOBILE_DASHBOARD_COMPONENTIZATION_V3
// MOVEMENT_TILE_COMPONENT_V1
// MOVEMENT_TILE_EXTRACTED_V1
import 'package:flutter/material.dart';

import '../../domain/domain.dart';
import 'mobile_dashboard_shared.dart';
import 'mobile_dashboard_theme.dart';
import '../../../../design_system/kit.dart';

import 'movement_tile.dart';
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

/// Feature adapter that maps [MdOperation] into the generic [MovementTile].
///
/// Keeping this adapter separate is important when the domain contains many
/// transaction types: domain-to-visual mapping stays at the feature boundary,
/// while [MovementTile] remains model-agnostic.
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
    final sign = operation.isCredit ? '+' : '−';

    return MovementTile(
      description: operation.description,
      reference: operation.reference,
      amountLabel:
          '$sign$currency ${mobileDashboardNumber(amount, decimals: 2)}',
      timeLabel: operation.timeLabel,
      amountTone: operation.isCredit
          ? MovementAmountTone.credit
          : MovementAmountTone.debit,
      showBottomDivider: !last,
      theme: theme,
      // The current dashboard uses a pill for type presentation. This can later
      // be replaced by a registry-driven icon/badge without modifying
      // MovementTile itself.
      typeBadge: MobileDashboardPill(
        label: operation.type,
        color: mobileDashboardToneColor(context, operation.tone),
      ),
    );
  }
}
