// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';


class PlatformMonoText extends StatelessWidget {
  final String name;
  final Color tone;
  const PlatformMonoText({super.key, required this.name, required this.tone});
  @override
  Widget build(BuildContext context) => Container(
        width: 36, height: 36, alignment: Alignment.center,
        decoration: BoxDecoration(color: superCoreTint(tone, 0x1F), borderRadius: BorderRadius.circular(8)),
        child: Text(name[0], style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.headlineMedium?.fontFamily, fontWeight: FontWeight.w800, fontSize: 15, color: tone)),
      );
}
