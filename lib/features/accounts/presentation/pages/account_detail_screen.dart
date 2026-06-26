// ============================================================
// VIEW — Accounts feature (ports MobileAccounts)
// list · createAccount · accountDetail · createGroup · groupDetail
// ============================================================

import 'package:flutter/material.dart';
import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/workspace/presentation/bloc/nav_cubit.dart';

class AccountDetailScreen extends StatelessWidget {
  final NavCubit nav;
  const AccountDetailScreen({super.key, required this.nav});
  @override
  Widget build(BuildContext context) {
    const tx = [('JV-2024-0042', '+5,000.00', true), ('TR-9042', '-1,800.00', false), ('JV-2024-0071', '+650.00', true)];
    return MScroll([
      MCard(marker: M.green, title: 'Current Balance', right: const Pill('Active'), children: const [
        Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Text('SAR', style: TextStyle(fontFamily: M.mono, fontSize: 14, color: M.fg3)),
          SizedBox(width: 8),
          Text('42,500.00', style: TextStyle(fontFamily: M.mono, fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.6, color: M.green)),
        ]),
      ]),
      const MCard(marker: M.blue, title: 'Information', children: [
        KV('Code', '1001', mono: true), KV('Type', 'Asset · Cash'),
        KV('Tree', 'Assets Tree (1)'), KV('Currency', 'SAR'),
      ]),
      MCard(marker: M.green, title: 'Recent Transactions', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < tx.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i == tx.length - 1 ? null : const Border(bottom: BorderSide(color: M.border))),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(tx[i].$1, style: const TextStyle(fontFamily: M.mono, fontSize: 12.5, color: M.blue)),
                  Text(tx[i].$2, style: TextStyle(fontFamily: M.mono, fontSize: 13, fontWeight: FontWeight.w600, color: tx[i].$3 ? M.green : M.red)),
                ]),
              ),
          ]),
        ),
      ]),
      MBtn('Back to List', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => nav.back('accounts')),
    ]);
  }
}
