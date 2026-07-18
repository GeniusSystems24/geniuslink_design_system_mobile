// ============================================================
// VIEW — Accounts feature (ports MobileAccounts)
// list · createAccount · accountDetail · createGroup · groupDetail
// ============================================================

import 'package:flutter/material.dart';
import 'package:gl_mobile_app/app/router/navigation_extensions.dart';
import 'package:gl_mobile_app/design_system/kit.dart';

class GroupDetailScreen extends StatelessWidget {
  const GroupDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Group Detail')),
      body: MScroll([
      const MCard(accentColor: SuperTokens.accent, title: 'Group Information', trailing: Pill('Active'), children: [
        KV('ID', '1042', mono: true), KV('Name English', 'Current Assets'),
        KV('Name Arabic', 'الأصول المتداولة', ar: true), KV('Account Tree', 'Assets Tree (1)'),
      ]),
      MCard(accentColor: SuperTokens.warning, title: 'Notes', children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(color: SuperThemeData.dark.inputBg, border: Border.all(color: SuperThemeData.dark.border), borderRadius: BorderRadius.circular(8)),
            child: Text('تشمل النقدية والحسابات المدينة والمخزون', style: TextStyle(fontFamily: SuperTokens.arabicFont, fontSize: 14, color: SuperThemeData.dark.fg2)),
          ),
        ),
      ]),
      const MCard(accentColor: SuperTokens.success, title: 'Audit', children: [
        KV('Created By', 'Admin User (ID: 5)'), KV('Created At', 'Dec 04, 2025 11:58 PM'),
      ]),
      MBtn('Back to List', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => context.goTo('accounts')),
    ]),
    );
  }
}
