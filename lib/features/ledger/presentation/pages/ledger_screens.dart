// ============================================================
// VIEW — Ledger feature (ports MobileLedger)
// journal (opening entry) · opDetail (financial operation)
// ============================================================

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';
import '../../../../workspace/presentation/bloc/nav_cubit.dart';

class OpeningJournalScreen extends StatelessWidget {
  const OpeningJournalScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const lines = [
      ('Cash Box (1001)', '+5,000.00', true, 'Opening balance'),
      ('Capital Account (3001)', '-5,000.00', false, 'Owner investment'),
    ];
    return MScroll([
      const MCard(marker: M.blue, title: 'Entry Details', children: [
        MField(label: 'Serial No', value: 'JV-2024-0042', mono: true),
        MField(label: 'Currency', value: 'SAR — Saudi Riyal'),
        MField(label: 'Fiscal Year', value: '2024', mono: true),
      ]),
      MCard(marker: M.green, title: 'Transfer Lines', sub: '2 lines · balanced', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < lines.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i == lines.length - 1 ? null : const Border(bottom: BorderSide(color: M.border))),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(lines[i].$1, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
                    Text(lines[i].$2, style: TextStyle(fontFamily: M.mono, fontSize: 14, fontWeight: FontWeight.w600, color: lines[i].$3 ? M.green : M.red)),
                  ]),
                  const SizedBox(height: 3),
                  Text(lines[i].$4, style: const TextStyle(fontSize: 12, color: M.fg3, fontFamily: M.body)),
                ]),
              ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.only(top: 12),
              decoration: const BoxDecoration(border: Border(top: BorderSide(color: M.borderStrong, width: 2))),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
                Eyebrow('Balanced · Diff 0.00', color: M.green, size: 11),
                Text('5,000.00', style: TextStyle(fontFamily: M.mono, fontSize: 15, fontWeight: FontWeight.w700, color: M.fg1)),
              ]),
            ),
          ]),
        ),
      ]),
      const MBtn('Create Entry', icon: 'check', full: true),
    ]);
  }
}

class OpDetailScreen extends StatelessWidget {
  final NavCubit nav;
  const OpDetailScreen({super.key, required this.nav});
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
    return MScroll([
      MCard(marker: M.green, title: 'Operation Summary', right: const Pill('Posted'), children: const [
        Text('OP-2024-0883', style: TextStyle(fontFamily: M.mono, fontSize: 12, color: M.blue)),
        Row(children: [
          Expanded(child: Mini(label: 'Total Debits', value: '6,600.00', sub: 'SAR')),
          SizedBox(width: 12),
          Expanded(child: Mini(label: 'Difference', value: '0.00', sub: 'SAR', hi: true)),
        ]),
      ]),
      MCard(marker: M.green, title: 'Ledger Lines', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < lines.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i == lines.length - 1 ? null : const Border(bottom: BorderSide(color: M.border))),
                child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(lines[i].$1, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
                      const SizedBox(height: 4),
                      Pill(lines[i].$4, tone: lines[i].$4 == 'Debit' ? PillTone.info : PillTone.danger),
                    ]),
                  ),
                  Text(lines[i].$2, style: TextStyle(fontFamily: M.mono, fontSize: 13.5, fontWeight: FontWeight.w600, color: lines[i].$3 ? M.green : M.red)),
                ]),
              ),
          ]),
        ),
      ]),
      MCard(marker: M.blue, title: 'Activity', children: [
        Column(children: [
          for (int i = 0; i < timeline.length; i++)
            IntrinsicHeight(
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Column(children: [
                  Container(width: 12, height: 12, decoration: BoxDecoration(color: M.green, shape: BoxShape.circle, border: Border.all(color: M.green, width: 2))),
                  if (i < timeline.length - 1) Expanded(child: Container(width: 2, constraints: const BoxConstraints(minHeight: 22), color: M.borderStrong)),
                ]),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(timeline[i].$1, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
                      const SizedBox(height: 2),
                      Text(timeline[i].$2, style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)),
                    ]),
                  ),
                ),
              ]),
            ),
        ]),
      ]),
      MBtn('Back to Operations', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => nav.back('more')),
    ]);
  }
}
