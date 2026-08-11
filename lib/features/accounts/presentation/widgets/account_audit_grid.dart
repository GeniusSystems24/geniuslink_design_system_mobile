// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';

class AccountAuditGrid extends StatelessWidget {
  final List<(String, String)> rows;
  const AccountAuditGrid({super.key, required this.rows});
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 4.0,
      children: [
        for (final r in rows)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Eyebrow(
                r.$1,
                color: SuperMaterialThemeData.of(context).superTheme.fg3,
                size: 9.5,
              ),
              const SizedBox(height: 5),
              Text(
                r.$2,
                style: TextStyle(
                  fontSize: 12.5,
                  color: SuperMaterialThemeData.of(context).superTheme.fg1,
                  fontFamily: SuperMaterialThemeData.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
