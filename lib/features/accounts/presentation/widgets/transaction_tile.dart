// ACCOUNT_TRANSACTION_TILE_V1
import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart';

import '../../../../design_system/components/layout/two_row_tile.dart';

/// Visual tone for the amount only.
///
/// This deliberately does not represent the business transaction type, so the
/// enum remains small even when the application supports hundreds of types.
enum TransactionAmountTone { positive, negative, neutral }

/// Reusable presentation component for one account transaction.
///
/// The widget intentionally does not accept a `TransactionType` enum. With
/// roughly 200 transaction types, type-specific rendering belongs in a
/// registry/resolver outside this component. Pass resolved visuals through
/// [leading] and [typeBadge].
///
/// Example:
///
/// ```dart
/// TransactionTile(
///   reference: 'TR-9042',
///   description: 'Transfer to NCB Bank',
///   dateLabel: 'Dec 17, 11:48',
///   amount: '-1,800.00',
///   balanceLabel: 'Bal. 4,450.00',
///   amountTone: TransactionAmountTone.negative,
///   leading: const Icon(Icons.swap_horiz),
///   typeBadge: const Text('Transfer'),
/// )
/// ```
class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.reference,
    required this.description,
    required this.dateLabel,
    required this.amount,
    required this.balanceLabel,
    this.amountTone = TransactionAmountTone.neutral,
    this.leading,
    this.typeBadge,
    this.onTap,
    this.semanticLabel,
    this.leadingGap = 10,
    this.tileTheme = const TwoRowTileThemeData(),
    this.referenceStyle,
    this.positiveAmountStyle,
    this.negativeAmountStyle,
    this.neutralAmountStyle,
    this.detailsStyle,
    this.balanceStyle,
  });

  /// Human-readable or document reference.
  final String reference;

  /// Short transaction description.
  final String description;

  /// Already-formatted date/time label.
  final String dateLabel;

  /// Already-formatted amount label.
  final String amount;

  /// Already-formatted running-balance label.
  final String balanceLabel;

  /// Presentation tone for [amount].
  final TransactionAmountTone amountTone;

  /// Optional type-specific visual supplied by the caller's resolver.
  final Widget? leading;

  /// Optional type-specific badge supplied by the caller's resolver.
  final Widget? typeBadge;

  /// Called when the tile is activated.
  final VoidCallback? onTap;

  /// Optional accessibility label.
  final String? semanticLabel;

  /// Gap used only when adapting the legacy TwoRowTile API.
  final double leadingGap;

  /// Layout and surface configuration delegated to [TwoRowTile].
  final TwoRowTileThemeData tileTheme;

  /// Optional reference text-style override.
  final TextStyle? referenceStyle;

  /// Optional positive-amount text-style override.
  final TextStyle? positiveAmountStyle;

  /// Optional negative-amount text-style override.
  final TextStyle? negativeAmountStyle;

  /// Optional neutral-amount text-style override.
  final TextStyle? neutralAmountStyle;

  /// Optional description/date text-style override.
  final TextStyle? detailsStyle;

  /// Optional running-balance text-style override.
  final TextStyle? balanceStyle;

  @override
  Widget build(BuildContext context) {
    final materialTheme = SuperMaterialThemeData.of(context);
    final colors = materialTheme.colorScheme;
    final superTheme = materialTheme.superTheme;
    final fontFamily = materialTheme.textTheme.bodyMedium?.fontFamily;

    // Defaults come from the design system. Feature/screen themes can override
    // them without making TransactionTile know any concrete transaction type.
    final effectiveReferenceStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      color: colors.primary,
    ).merge(referenceStyle);

    final effectivePositiveAmountStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: colors.secondary,
    ).merge(positiveAmountStyle);

    final effectiveNegativeAmountStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: colors.error,
    ).merge(negativeAmountStyle);

    final effectiveNeutralAmountStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: superTheme.fg1,
    ).merge(neutralAmountStyle);

    final effectiveDetailsStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      color: superTheme.fg3,
    ).merge(detailsStyle);

    final effectiveBalanceStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: 11.5,
      color: superTheme.fg2,
    ).merge(balanceStyle);

    final effectiveAmountStyle = switch (amountTone) {
      TransactionAmountTone.positive => effectivePositiveAmountStyle,
      TransactionAmountTone.negative => effectiveNegativeAmountStyle,
      TransactionAmountTone.neutral => effectiveNeutralAmountStyle,
    };

    final detailsLabel = [
      if (description.trim().isNotEmpty) description.trim(),
      if (dateLabel.trim().isNotEmpty) dateLabel.trim(),
    ].join(' · ');

    return TwoRowTile(
      theme: tileTheme,
      leading: leading,
      title: _TransactionReference(
        reference: reference,
        badge: typeBadge,
        style: effectiveReferenceStyle,
      ),
      trailing: Text(
        amount,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: effectiveAmountStyle,
      ),
      subtitle: Text(
        detailsLabel,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: effectiveDetailsStyle,
      ),
      subtitleTrailing: Text(
        balanceLabel,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: effectiveBalanceStyle,
      ),
      onTap: onTap,
      semanticLabel:
          semanticLabel ?? '$reference, $description, $amount, $balanceLabel',
    );
  }
}

/// Keeps the transaction reference and optional type badge together.
class _TransactionReference extends StatelessWidget {
  const _TransactionReference({
    required this.reference,
    required this.badge,
    required this.style,
  });

  final String reference;
  final Widget? badge;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final referenceText = Text(
      reference,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: style,
    );

    if (badge == null) return referenceText;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: referenceText),
        const SizedBox(width: 8),
        Flexible(child: badge!),
      ],
    );
  }
}
