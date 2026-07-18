// ============================================================
// VIEW — Ledger feature (ports MobileLedger)
// journal (opening entry) · opDetail (financial operation)
// ============================================================

import 'package:flutter/material.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';

class OpeningJournalScreen extends StatelessWidget {
  const OpeningJournalScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const lines = [
      ('Cash Box (1001)', '+5,000.00', true, 'Opening balance'),
      ('Capital Account (3001)', '-5,000.00', false, 'Owner investment'),
    ];
    return Scaffold(
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Opening Journal')),
      body: MScroll([
      const MCard(accentColor: SuperTokens.accent, title: 'Entry Details', children: [
        MField(label: 'Serial No', value: 'JV-2024-0042', mono: true),
        MField(label: 'Currency', value: 'SAR — Saudi Riyal'),
        MField(label: 'Fiscal Year', value: '2024', mono: true),
      ]),
      MCard(accentColor: SuperTokens.success, title: 'Transfer Lines', subtitle: '2 lines · balanced', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < lines.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i == lines.length - 1 ? null : Border(bottom: BorderSide(color: SuperThemeData.dark.border))),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(lines[i].$1, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: SuperThemeData.dark.fg1, fontFamily: SuperTokens.bodyFont)),
                    Text(lines[i].$2, style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 14, fontWeight: FontWeight.w600, color: lines[i].$3 ? SuperTokens.success : SuperTokens.danger)),
                  ]),
                  const SizedBox(height: 3),
                  Text(lines[i].$4, style: TextStyle(fontSize: 12, color: SuperThemeData.dark.fg3, fontFamily: SuperTokens.bodyFont)),
                ]),
              ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(border: Border(top: BorderSide(color: SuperThemeData.dark.borderStrong, width: 2))),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Eyebrow('Balanced · Diff 0.00', color: SuperTokens.success, size: 11),
                Text('5,000.00', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 15, fontWeight: FontWeight.w700, color: SuperThemeData.dark.fg1)),
              ]),
            ),
          ]),
        ),
      ]),
      const MBtn('Create Entry', icon: 'check', full: true),
    ]),
    );
  }
}

class OpDetailScreen extends StatelessWidget {
  const OpDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const lines = [
      ('1200 — Inventory (WIP)', '+5,400.00', true, 'Debit'),
      ('5001 — Cost of Goods Sold', '+1,200.00', true, 'Debit'),
      ('1100 — Bank · NCB Main', '−6,600.00', false, 'Credit'),
    ];
    const timeline = [
      ('Operation created', 'Layla A. · Dec 18, 09:21'),
      ('Submitted for review', 'Layla A. · Dec 18, 09:24'),
      ('Approved & posted', 'Controller · Dec 18, 10:05'),
    ];
    return Scaffold(
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Financial Operation')),
      body: MScroll([
      const MCard(accentColor: SuperTokens.success, title: 'Operation Summary', trailing: Pill('Posted'), children: [
        Text('OP-2024-0883', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 12, color: SuperTokens.accent)),
        Row(children: [
          Expanded(child: Mini(label: 'Total Debits', value: '6,600.00', sub: 'SAR')),
          SizedBox(width: 12),
          Expanded(child: Mini(label: 'Difference', value: '0.00', sub: 'SAR', hi: true)),
        ]),
      ]),
      MCard(accentColor: SuperTokens.success, title: 'Ledger Lines', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < lines.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i == lines.length - 1 ? null : Border(bottom: BorderSide(color: SuperThemeData.dark.border))),
                child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(lines[i].$1, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SuperThemeData.dark.fg1, fontFamily: SuperTokens.bodyFont)),
                      const SizedBox(height: 4),
                      Pill(lines[i].$4, tone: lines[i].$4 == 'Debit' ? PillTone.info : PillTone.danger),
                    ]),
                  ),
                  Text(lines[i].$2, style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 13.5, fontWeight: FontWeight.w600, color: lines[i].$3 ? SuperTokens.success : SuperTokens.danger)),
                ]),
              ),
          ]),
        ),
      ]),
      MCard(accentColor: SuperTokens.accent, title: 'Activity', children: [
        Column(children: [
          for (int i = 0; i < timeline.length; i++)
            IntrinsicHeight(
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Column(children: [
                  Container(width: 12, height: 12, decoration: BoxDecoration(color: SuperTokens.success, shape: BoxShape.circle, border: Border.all(color: SuperTokens.success, width: 2))),
                  if (i < timeline.length - 1) Expanded(child: Container(width: 2, constraints: const BoxConstraints(minHeight: 22), color: SuperThemeData.dark.borderStrong)),
                ]),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(timeline[i].$1, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SuperThemeData.dark.fg1, fontFamily: SuperTokens.bodyFont)),
                      const SizedBox(height: 2),
                      Text(timeline[i].$2, style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 11, color: SuperThemeData.dark.fg3)),
                    ]),
                  ),
                ),
              ]),
            ),
        ]),
      ]),
      MBtn('Back to Operations', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => context.goTo('more')),
    ]),
    );
  }
}
