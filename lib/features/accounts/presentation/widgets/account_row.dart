import 'package:flutter/material.dart';

import '../../../../design_system/kit.dart';
import '../../domain/domain.dart';

/// Visual overrides for [AccountRow].
///
/// [AccountRow] is intentionally a feature adapter: it may understand an
/// [Account], while its inner layout is delegated to model-independent
/// [DirectionalSlotTile].
@immutable
class AccountRowThemeData {
  const AccountRowThemeData({
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    this.gap = 12,
    this.codeWidth = 36,
    this.codeStyle,
    this.nameStyle,
    this.localizedNameStyle,
    this.positiveAmountStyle,
    this.negativeAmountStyle,
    this.chevronColor,
    this.chevronSize = 15,
    this.endGap = 6,
    this.dividerColor,
  });

  final EdgeInsetsGeometry padding;
  final double gap;
  final double codeWidth;
  final TextStyle? codeStyle;
  final TextStyle? nameStyle;
  final TextStyle? localizedNameStyle;
  final TextStyle? positiveAmountStyle;
  final TextStyle? negativeAmountStyle;
  final Color? chevronColor;
  final double chevronSize;
  final double endGap;
  final Color? dividerColor;
}

class AccountRow extends StatelessWidget {
  final Account account;
  final bool last;
  final VoidCallback onTap;
  final AccountRowThemeData theme;

  const AccountRow({
    required this.account,
    required this.last,
    required this.onTap,
    this.theme = const AccountRowThemeData(),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final materialTheme = SuperMaterialThemeData.of(context);
    final colors = materialTheme.colorScheme;
    final superTheme = materialTheme.superTheme;
    final fontFamily = materialTheme.textTheme.bodyMedium?.fontFamily;
    final amount = SuperFormat.number(account.balance.abs(), decimals: 2);

    final codeStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      color: superTheme.fg3,
    ).merge(theme.codeStyle);
    final nameStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: 13.5,
      fontWeight: FontWeight.w600,
      color: superTheme.fg1,
    ).merge(theme.nameStyle);
    final localizedNameStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      color: superTheme.fg3,
    ).merge(theme.localizedNameStyle);
    final positiveAmountStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: superTheme.fg1,
    ).merge(theme.positiveAmountStyle);
    final negativeAmountStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: colors.error,
    ).merge(theme.negativeAmountStyle);

    return DirectionalSlotTile(
      onTap: onTap,
      semanticLabel: '${account.code} ${account.name}',
      theme: DirectionalSlotTileThemeData(
        padding: theme.padding,
        gap: theme.gap,
        border: last
            ? null
            : Border(
                bottom: BorderSide(
                  color: theme.dividerColor ?? superTheme.border,
                ),
              ),
      ),
      start: SizedBox(
        width: theme.codeWidth,
        child: Text(account.code, style: codeStyle),
      ),
      center: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(account.name, style: nameStyle),
          if (account.localizedName case final localizedName?)
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(localizedName, style: localizedNameStyle),
            ),
        ],
      ),
      end: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${account.balance < 0 ? '-' : ''}$amount',
            style: account.balance < 0
                ? negativeAmountStyle
                : positiveAmountStyle,
          ),
          SizedBox(width: theme.endGap),
          Icon(
            MIcons.of('chevR'),
            size: theme.chevronSize,
            color: theme.chevronColor ?? superTheme.fg4,
          ),
        ],
      ),
    );
  }
}
