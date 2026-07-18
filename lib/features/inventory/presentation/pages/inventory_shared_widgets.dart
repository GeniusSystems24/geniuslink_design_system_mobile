import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';

class DistRow extends StatelessWidget {
  final String account, side, amount;
  final bool last;
  const DistRow({
    super.key,
    required this.account,
    required this.side,
    required this.amount,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          border:
              last ? null : Border(bottom: BorderSide(color: SuperThemeData.dark.border))),
      child: Row(children: [
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(account,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: SuperThemeData.dark.fg1,
                    fontFamily: SuperTokens.bodyFont)),
            const SizedBox(height: 4),
            Pill(side, tone: side == 'Debit' ? PillTone.info : PillTone.danger),
          ]),
        ),
        Text(amount,
            style: TextStyle(
                fontFamily: SuperTokens.monoFont,
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: amount.startsWith('+') ? SuperTokens.success : SuperTokens.danger)),
      ]),
    );
  }
}

class ItemLine extends StatelessWidget {
  final (String, String, String) item;
  final bool last;
  const ItemLine({super.key, required this.item, this.last = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          border:
              last ? null : Border(bottom: BorderSide(color: SuperThemeData.dark.border))),
      child: Row(children: [
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(item.$1,
                style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: SuperThemeData.dark.fg1,
                    fontFamily: SuperTokens.bodyFont)),
            const SizedBox(height: 2),
            Text(item.$2,
                style: TextStyle(
                    fontFamily: SuperTokens.monoFont, fontSize: 11, color: SuperThemeData.dark.fg3)),
          ]),
        ),
        Text(item.$3,
            style: TextStyle(
                fontFamily: SuperTokens.monoFont,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: SuperThemeData.dark.fg1)),
      ]),
    );
  }
}
