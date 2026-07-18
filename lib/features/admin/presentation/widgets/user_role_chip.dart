// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';

import 'user_status_dot.dart';

class UserRoleChip extends StatelessWidget {
  const UserRoleChip({super.key});
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
        UserStatusDot(SuperMaterialThemeData.of(context).colorScheme.tertiary),
        const SizedBox(width: 5),
        Text('Accountant', style: TextStyle(fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg2, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
      ]);
}
