import 'package:flutter/material.dart';

import '../../../../design_system/kit.dart';
import '../../domain/domain.dart';

class AccountRow extends StatelessWidget {
  final Account account;
  final bool last;
  final VoidCallback onTap;

  const AccountRow({
    required this.account,
    required this.last,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final amount = SuperFormat.number(account.balance.abs(), decimals: 2);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          border: last
              ? null
              : Border(
                  bottom: BorderSide(
                    color: SuperMaterialThemeData.of(context).superTheme.border,
                  ),
                ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 36,
              child: Text(
                account.code,
                style: TextStyle(
                  fontFamily: SuperMaterialThemeData.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                  fontSize: 12,
                  color: SuperMaterialThemeData.of(context).superTheme.fg3,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.name,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: SuperMaterialThemeData.of(context).superTheme.fg1,
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                    ),
                  ),
                  if (account.localizedName case final localizedName?)
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        localizedName,
                        style: TextStyle(
                          fontFamily: SuperMaterialThemeData.of(
                            context,
                          ).textTheme.bodyMedium?.fontFamily,
                          fontSize: 12,
                          color: SuperMaterialThemeData.of(
                            context,
                          ).superTheme.fg3,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Text(
              '${account.balance < 0 ? '-' : ''}$amount',
              style: TextStyle(
                fontFamily: SuperMaterialThemeData.of(
                  context,
                ).textTheme.bodyMedium?.fontFamily,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: account.balance < 0
                    ? SuperMaterialThemeData.of(context).colorScheme.error
                    : SuperMaterialThemeData.of(context).superTheme.fg1,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              MIcons.of('chevR'),
              size: 15,
              color: SuperMaterialThemeData.of(context).superTheme.fg4,
            ),
          ],
        ),
      ),
    );
  }
}
