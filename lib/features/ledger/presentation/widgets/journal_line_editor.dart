// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';


final journalAccounts = <(String, String)>[
  ('1100', 'Bank · NCB Main'),
  ('1101', 'Bank · Al Rajhi'),
  ('1200', 'Accounts Receivable'),
  ('1300', 'Inventory'),
  ('1500', 'Fixed Assets'),
  ('2100', 'Accounts Payable'),
  ('2200', 'VAT Payable'),
  ('3001', 'Owner Capital'),
  ('3100', 'Retained Earnings'),
  ('4001', 'Sales Revenue'),
  ('5001', 'Cost of Goods Sold'),
  ('6001', 'Salaries Expense'),
  ('6100', 'Rent Expense'),
  ('6200', 'Bank Charges'),
  ('6300', 'Depreciation Expense'),
];

class JournalLineEditor extends StatelessWidget {
  final String account, side, amount;
  const JournalLineEditor({super.key, required this.account, required this.side, required this.amount});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.bg, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          // Searchable account picker seeded with this line's current account.
          Expanded(
            child: MSuggest(
              value: account,
              placeholder: 'Search account…',
              icon: 'ledger',
              items: [
                for (final a in journalAccounts)
                  AutoSuggestion<String>(
                    value: '${a.$2} (${a.$1})',
                    label: a.$2,
                    description: '${a.$1} · ${switch (a.$1[0]) {
                      '1' => 'Assets',
                      '2' => 'Liabilities',
                      '3' => 'Equity',
                      '4' => 'Revenue',
                      _ => 'Expenses',
                    }}',
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Padding(padding: const EdgeInsets.only(top: 4), child: Icon(MIcons.of('trash'), size: 15, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: superCoreTint(side == 'Debit' ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).colorScheme.error, 0x1F), borderRadius: BorderRadius.circular(6)),
            child: Text(side.toUpperCase(), style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: side == 'Debit' ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).colorScheme.error)),
          ),
          const Spacer(),
          Text(amount, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 15, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
        ]),
      ]),
    );
  }
}
