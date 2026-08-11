// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';

class ReportRow extends StatelessWidget {
  final String left;
  final String? sub;
  final String right;
  final Color? rightTone;
  final bool bold, last;
  const ReportRow({
    super.key,
    required this.left,
    this.sub,
    required this.right,
    this.rightTone,
    this.bold = false,
    this.last = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  left,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
                    color: SuperMaterialThemeData.of(context).superTheme.fg1,
                    fontFamily: SuperMaterialThemeData.of(
                      context,
                    ).textTheme.bodyMedium?.fontFamily,
                  ),
                ),
                if (sub != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      sub!,
                      style: TextStyle(
                        fontFamily: SuperMaterialThemeData.of(
                          context,
                        ).textTheme.bodyMedium?.fontFamily,
                        fontSize: 11,
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
            right,
            style: TextStyle(
              fontFamily: SuperMaterialThemeData.of(
                context,
              ).textTheme.bodyMedium?.fontFamily,
              fontSize: 13.5,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
              color:
                  rightTone ??
                  SuperMaterialThemeData.of(context).superTheme.fg1,
            ),
          ),
        ],
      ),
    );
  }
}
