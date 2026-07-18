// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';


class AccountRow extends StatelessWidget {
  final (String, String, String, String, bool) row;
  final bool last;
  final VoidCallback onTap;
  const AccountRow(
      {super.key, required this.row, required this.last, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
            border: last
                ? null
                : Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
        child: Row(
          children: [
            SizedBox(
                width: 36,
                child: Text(row.$1,
                    style: TextStyle(
                        fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg3))),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(row.$2,
                      style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: SuperMaterialThemeData.of(context).superTheme.fg1,
                          fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(row.$3,
                        style: TextStyle(
                            fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                  ),
                ],
              ),
            ),
            Text(row.$4,
                style: TextStyle(
                    fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: row.$5 ? SuperMaterialThemeData.of(context).colorScheme.error : SuperMaterialThemeData.of(context).superTheme.fg1)),
            const SizedBox(width: 6),
            Icon(MIcons.of('chevR'), size: 15, color: SuperMaterialThemeData.of(context).superTheme.fg4),
          ],
        ),
      ),
    );
  }
}
