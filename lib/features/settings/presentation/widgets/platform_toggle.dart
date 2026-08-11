// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';

class PlatformToggle extends StatelessWidget {
  final bool on;
  final VoidCallback onTap;

  const PlatformToggle({super.key, required this.on, required this.onTap});

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 64,
    child: SuperBoolFormField(
      key: ValueKey(on),
      initialValue: on,
      enabledLabel: '',
      disabledLabel: '',
      onChanged: (_) => onTap(),
    ),
  );
}
