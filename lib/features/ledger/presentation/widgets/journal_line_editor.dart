
import 'package:flutter/material.dart';

import '../../../../design_system/kit.dart';
import '../../domain/domain.dart';

class JournalLineEditor extends StatelessWidget {
  final JournalLine line;
  final List<LedgerAccount> accounts;

  const JournalLineEditor({required this.line, required this.accounts, super.key});

  @override
  Widget build(BuildContext context) {
    final sideLabel = line.side == JournalSide.debit ? 'Debit' : 'Credit';
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.bg, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(child: MSuggest(value: '${line.account.name} (${line.account.code})', placeholder: 'Search account…', icon: 'ledger', items: [
            for (final account in accounts) AutoSuggestion<String>(value: '${account.name} (${account.code})', label: account.name, description: '${account.code} · ${account.category}'),
          ])),
          const SizedBox(width: 10),
          Padding(padding: const EdgeInsets.only(top: 4), child: Icon(MIcons.of('trash'), size: 15, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: superCoreTint(line.side == JournalSide.debit ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).colorScheme.error, 0x1F), borderRadius: BorderRadius.circular(6)), child: Text(sideLabel.toUpperCase(), style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: line.side == JournalSide.debit ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).colorScheme.error))),
          const Spacer(),
          Text(SuperFormat.number(line.amount, decimals: 2), style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 15, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
        ]),
      ]),
    );
  }
}
