import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';
import '../../../../workspace/presentation/bloc/nav_cubit.dart';
import 'inventory_shared_widgets.dart';

class IssueDetailScreen extends StatelessWidget {
  final NavCubit nav;
  const IssueDetailScreen({super.key, required this.nav});
  @override
  Widget build(BuildContext context) {
    return MScroll([
      MCard(
          marker: M.green,
          title: 'Issued Value',
          sub: 'INV-ISS-2024-0089 · Dec 18, 2025',
          right: const Pill('Posted'),
          children: const [
            Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text('USD',
                      style: TextStyle(
                          fontFamily: M.mono, fontSize: 14, color: M.fg3)),
                  SizedBox(width: 8),
                  Text('5,400.00',
                      style: TextStyle(
                          fontFamily: M.mono,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: M.fg1,
                          letterSpacing: -0.6)),
                ]),
          ]),
      const MCard(marker: M.blue, title: 'Issue Information', children: [
        KV('Serial No', 'INV-ISS-2024-0089', mono: true),
        KV('Store', 'Downtown Central'),
        KV('Customer', 'Project A-92'),
        KV('Currency', 'USD — US Dollar'),
      ]),
      const MCard(
          marker: M.green,
          title: 'Accounting Distribution',
          pad: 16,
          children: [
            DistRow(
                account: '1200 — Inventory (WIP)',
                side: 'Debit',
                amount: '+5,400.00',
                last: false),
            DistRow(
                account: '5001 — Cost of Goods Sold',
                side: 'Credit',
                amount: '-5,400.00',
                last: true),
          ]),

      MBtn('Back to Operations',
          variant: MBtnVariant.secondary,
          icon: 'back',
          full: true,
          onTap: () => nav.back('more')),
    ]);
  }
}
