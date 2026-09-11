// MOVEMENT_TILE_FILE_V1
import 'package:flutter/material.dart';

import '../../../../design_system/components/layout/two_row_tile.dart';
import 'mobile_dashboard_theme.dart';

/// Visual direction of a movement amount.
///
/// This describes only how the amount should be presented. It is intentionally
/// independent from the business transaction type, so the application can
/// support hundreds of transaction types without growing this enum.
enum MovementAmountTone {
  credit,
  debit,
  neutral,
}

/// Reusable presentation widget for a financial movement.
///
/// `MovementTile` owns only the visual contract shared by movements:
/// description, reference, type badge, amount, and time. It intentionally does
/// not depend on [MdOperation] or on a transaction-type enum.
///
/// With a large transaction catalog (for example ~200 types), resolve the
/// type-specific icon/badge outside this widget and provide them through
/// [leading] and [typeBadge]. This keeps the component stable while transaction
/// types can grow independently.
///
/// Example:
///
/// ```dart
/// MovementTile(
///   description: 'Transfer to bank',
///   reference: 'TR-90812',
///   amountLabel: '−YER 25,000.00',
///   timeLabel: '10:45 AM',
///   amountTone: MovementAmountTone.debit,
///   leading: const Icon(Icons.swap_horiz),
///   typeBadge: const Text('Transfer'),
/// )
/// ```
class MovementTile extends StatelessWidget {
  const MovementTile({
    required this.description,
    required this.reference,
    required this.amountLabel,
    required this.timeLabel,
    this.amountTone = MovementAmountTone.neutral,
    this.leading,
    this.typeBadge,
    this.onTap,
    this.semanticLabel,
    this.showBottomDivider = false,
    this.theme,
    this.descriptionStyle,
    this.referenceStyle,
    this.amountStyle,
    this.timeStyle,
    super.key,
  });

  /// Primary movement description.
  final String description;

  /// Movement/document reference.
  final String reference;

  /// Already-formatted amount including sign and currency.
  final String amountLabel;

  /// Already-formatted date/time label.
  final String timeLabel;

  /// Presentation tone for [amountLabel].
  final MovementAmountTone amountTone;

  /// Optional type-specific visual at the logical start of the tile.
  ///
  /// A registry/resolver can supply this for any number of transaction types.
  final Widget? leading;

  /// Optional type-specific badge displayed next to [reference].
  ///
  /// This is a visual slot rather than a transaction-type enum, which avoids a
  /// large switch inside the reusable component.
  final Widget? typeBadge;

  /// Called when the movement is activated.
  final VoidCallback? onTap;

  /// Optional accessibility label for the complete movement.
  final String? semanticLabel;

  /// Whether a bottom divider should be drawn.
  final bool showBottomDivider;

  /// Optional layout/surface override delegated to [TwoRowTile].
  final TwoRowTileThemeData? theme;

  /// Optional primary-description text-style override.
  final TextStyle? descriptionStyle;

  /// Optional reference text-style override.
  final TextStyle? referenceStyle;

  /// Optional amount text-style override.
  final TextStyle? amountStyle;

  /// Optional time text-style override.
  final TextStyle? timeStyle;

  @override
  Widget build(BuildContext context) {
    final dashboardTheme = context.mdTheme;
    final colors = context.mdColors;
    final fontFamily = context.mdTextTheme.bodyMedium?.fontFamily;

    // Amount direction is a small presentation concern. It must not be confused
    // with the business transaction type, of which the application may have
    // hundreds.
    final defaultAmountColor = switch (amountTone) {
      MovementAmountTone.credit => colors.secondary,
      MovementAmountTone.debit => colors.error,
      MovementAmountTone.neutral => dashboardTheme.fg1,
    };

    final effectiveDescriptionStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: dashboardTheme.fg1,
    ).merge(descriptionStyle);

    final effectiveReferenceStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: 11,
      color: colors.primary,
    ).merge(referenceStyle);

    final effectiveAmountStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: defaultAmountColor,
    ).merge(amountStyle);

    final effectiveTimeStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: 11,
      color: dashboardTheme.fg3,
    ).merge(timeStyle);

    // Type-specific presentation is passed in as a Widget slot. MovementTile
    // therefore remains unchanged when new transaction types are introduced.
    final referenceContent = typeBadge == null
        ? Text(
            reference,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: effectiveReferenceStyle,
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  reference,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: effectiveReferenceStyle,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(child: typeBadge!),
            ],
          );

    return TwoRowTile(
      semanticLabel:
          semanticLabel ?? '$description, $amountLabel, $reference, $timeLabel',
      showBottomDivider: showBottomDivider,
      theme: theme ??
          context.mdComponentTheme.twoRowTheme ??
          TwoRowTileThemeData(
            padding: const EdgeInsets.symmetric(vertical: 12),
            rowGap: 7,
            columnGap: 10,
            dividerColor: dashboardTheme.border,
          ),
      leading: leading,
      title: Text(
        description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: effectiveDescriptionStyle,
      ),
      trailing: Text(
        amountLabel,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: effectiveAmountStyle,
      ),
      subtitle: referenceContent,
      subtitleTrailing: Text(
        timeLabel,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: effectiveTimeStyle,
      ),
      onTap: onTap,
    );
  }
}
