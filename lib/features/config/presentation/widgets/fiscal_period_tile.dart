// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';


class FiscalPeriodTile extends StatelessWidget {
  final String month, state;
  const FiscalPeriodTile({super.key, required this.month, required this.state});
  @override
  Widget build(BuildContext context) {
    final isOpen = state == 'open';
    final color = isOpen ? SuperMaterialThemeData.of(context).colorScheme.secondary : SuperMaterialThemeData.of(context).superTheme.fg3;
    return Opacity(
      opacity: state == 'future' ? 0.5 : 1,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: isOpen ? superCoreTint(SuperMaterialThemeData.of(context).colorScheme.secondary, 0x14) : SuperMaterialThemeData.of(context).superTheme.bg, border: Border.all(color: isOpen ? superCoreTint(SuperMaterialThemeData.of(context).colorScheme.secondary, 0x4D) : SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(month, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
            if (state != 'future') Icon(MIcons.of(isOpen ? 'check' : 'lock'), size: 13, color: color),
          ]),
          const SizedBox(height: 8),
          Text(state.toUpperCase(), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 8.5, letterSpacing: 0.6, color: color, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
        ]),
      ),
    );
  }
}
