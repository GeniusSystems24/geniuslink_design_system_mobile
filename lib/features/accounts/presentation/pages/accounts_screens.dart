// ============================================================
// VIEW — Accounts feature (ports MobileAccounts)
// list · createAccount · accountDetail · createGroup · groupDetail
// ============================================================

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';
import '../../../../workspace/presentation/bloc/nav_cubit.dart';

const _accounts = [
  ('1001', 'Cash Box', 'الصندوق', '42,500.00', false),
  ('1100', 'Bank · NCB Main', 'البنك الأهلي', '186,420.00', false),
  ('1200', 'Inventory (WIP)', 'مخزون', '54,890.00', false),
  ('2001', 'Accounts Payable', 'الموردون', '-23,140.00', true),
  ('4001', 'Sales Revenue', 'المبيعات', '-89,200.00', true),
];

class AccountsScreen extends StatelessWidget {
  final NavCubit nav;
  const AccountsScreen({super.key, required this.nav});

  @override
  Widget build(BuildContext context) {
    return MScroll([
      Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
            color: M.input,
            border: Border.all(color: M.borderStrong),
            borderRadius: BorderRadius.circular(10)),
        child: const Row(children: [
          Icon(Icons.search_rounded, size: 16, color: M.fg3),
          SizedBox(width: 10),
          Text('Search accounts…',
              style: TextStyle(color: M.fg3, fontSize: 14, fontFamily: M.body)),
        ]),
      ),
      MCard(pad: 8, children: [
        for (int i = 0; i < _accounts.length; i++)
          _AccountRow(
              row: _accounts[i],
              last: i == _accounts.length - 1,
              onTap: () => nav.go('accountDetail')),
      ]),
    ]);
  }
}

class _AccountRow extends StatelessWidget {
  final (String, String, String, String, bool) row;
  final bool last;
  final VoidCallback onTap;
  const _AccountRow(
      {required this.row, required this.last, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
            border: last
                ? null
                : const Border(bottom: BorderSide(color: M.border))),
        child: Row(
          children: [
            SizedBox(
                width: 36,
                child: Text(row.$1,
                    style: const TextStyle(
                        fontFamily: M.mono, fontSize: 12, color: M.fg3))),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(row.$2,
                      style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: M.fg1,
                          fontFamily: M.body)),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(row.$3,
                        style: const TextStyle(
                            fontFamily: M.arabic, fontSize: 12, color: M.fg3)),
                  ),
                ],
              ),
            ),
            Text(row.$4,
                style: TextStyle(
                    fontFamily: M.mono,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: row.$5 ? M.red : M.fg1)),
            const SizedBox(width: 6),
            Icon(MIcons.of('chevR'), size: 15, color: M.fg4),
          ],
        ),
      ),
    );
  }
}
