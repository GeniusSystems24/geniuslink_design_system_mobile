// ============================================================
// VIEW — Accounts feature (ports MobileAccounts)
// list · createAccount · accountDetail · createGroup · groupDetail
// ============================================================

import 'package:flutter/material.dart';
import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/workspace/presentation/bloc/nav_cubit.dart';

class GroupDetailScreen extends StatelessWidget {
  final NavCubit nav;
  const GroupDetailScreen({super.key, required this.nav});
  @override
  Widget build(BuildContext context) {
    return MScroll([
      const MCard(marker: M.blue, title: 'Group Information', right: Pill('Active'), children: [
        KV('ID', '1042', mono: true), KV('Name English', 'Current Assets'),
        KV('Name Arabic', 'الأصول المتداولة', ar: true), KV('Account Tree', 'Assets Tree (1)'),
      ]),
      MCard(marker: M.orange, title: 'Notes', children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(color: M.input, border: Border.all(color: M.border), borderRadius: BorderRadius.circular(8)),
            child: const Text('تشمل النقدية والحسابات المدينة والمخزون', style: TextStyle(fontFamily: M.arabic, fontSize: 14, color: M.fg2)),
          ),
        ),
      ]),
      const MCard(marker: M.green, title: 'Audit', children: [
        KV('Created By', 'Admin User (ID: 5)'), KV('Created At', 'Dec 04, 2025 11:58 PM'),
      ]),
      MBtn('Back to List', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => nav.back('accounts')),
    ]);
  }
}
