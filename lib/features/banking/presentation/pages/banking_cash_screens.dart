// ============================================================
// VIEW — Banking · Cash (ports MobileBanking deposit/withdrawal)
// createDeposit · depositDetail · createWithdrawal · withdrawalDetail
// ============================================================

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';
import '../../../../app/router/navigation_extensions.dart';

class CreateDepositScreen extends StatelessWidget {
  const CreateDepositScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Create Deposit')),
      body: const MScroll([
      ISection(icon: 'download', title: 'Deposit Amount', accentColor: SuperTokens.success, children: [
        MMoney(label: 'Amount', value: '120,000.00', accent: SuperTokens.success, required: true, sign: '+'),
        MMethod(value: 'cash'),
      ]),
      ISection(icon: 'card', title: 'Destination', accentColor: SuperTokens.accent, children: [
        IField(label: 'Deposit To', value: 'Bank · NCB Main (1100)', select: true, required: true),
        IField(label: 'Reference', placeholder: 'e.g. Counter slip no.'),
        IField(label: 'Value Date', value: 'Dec 19, 2025', icon: 'calendar'),
      ]),
      ISection(icon: 'ledger', title: 'Journal Preview', accentColor: SuperTokens.success, defaultOpen: false, children: [
        JournalPreview(rows: [
          ('Bank · NCB Main (1100)', '120,000.00', null),
          ('Cash Box (1001)', null, '120,000.00'),
        ]),
      ]),
      ITextarea(label: 'Memo', placeholder: 'Optional note for this deposit…'),
      ActionRow(primary: 'Create Deposit'),
    ]),
    );
  }
}

class DepositDetailScreen extends StatelessWidget {
  const DepositDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Deposit Receipt')),
      body: MScroll([
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: superCoreTint(SuperTokens.success, 0x14), border: Border.all(color: superCoreTint(SuperTokens.success, 0x40)), borderRadius: BorderRadius.circular(12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Eyebrow('Deposit Receipt · DEP-2024-0182', color: SuperTokens.success, size: 10),
          SizedBox(height: 10),
          Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
            Text('+120,000.00 ', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 30, fontWeight: FontWeight.w700, color: SuperTokens.success, letterSpacing: -0.5)),
            Text('SAR', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 13, color: SuperThemeData.dark.fg3)),
          ]),
        ]),
      ),
      const MCard(accentColor: SuperTokens.accent, title: 'Details', children: [
        BKV('Method', 'Cash'), BKV('Deposited To', 'Bank · NCB Main (1100)'),
        BKV('Value Date', 'Dec 19, 2025', mono: true), BKV('Reference', 'CTR-9920', mono: true),
        BKV('Status', 'Cleared'),
      ]),
      const MCard(accentColor: SuperTokens.success, title: 'Posted Journal', pad: 16, children: [
        JournalPreview(rows: [
          ('Bank · NCB Main (1100)', '120,000.00', null),
          ('Cash Box (1001)', null, '120,000.00'),
        ]),
      ]),
      const MCard(accentColor: SuperTokens.accent, title: 'Audit', children: [
        AuditGrid(rows: [
          ('Created By', 'Layla Ahmed', false),
          ('Created At', 'Dec 19, 09:42', true),
        ]),
      ]),
      MBtn('Back', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => context.goTo('more')),
    ]),
    );
  }
}

class CreateWithdrawalScreen extends StatelessWidget {
  const CreateWithdrawalScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Create Withdrawal')),
      body: const MScroll([
      ISection(icon: 'card', title: 'Withdrawal Amount', accentColor: SuperTokens.danger, children: [
        MMoney(label: 'Amount', value: '12,045.00', accent: SuperTokens.danger, required: true, sign: '−'),
        MMethod(value: 'wire'),
      ]),
      ISection(icon: 'building', title: 'Source & Purpose', accentColor: SuperTokens.accent, children: [
        IField(label: 'Withdraw From', value: 'Bank · NCB Main (1100)', select: true, required: true),
        IField(label: 'Payee', placeholder: 'e.g. Global Steel Imports', required: true),
        IField(label: 'Expense Account', value: 'Cost of Goods Sold (5001)', select: true),
        IField(label: 'Value Date', value: 'Dec 19, 2025', icon: 'calendar'),
      ]),
      InfoNote('Withdrawals above 10,000 SAR require a second approval before posting.', tone: SuperTokens.warning),
      ActionRow(primary: 'Submit for Approval'),
    ]),
    );
  }
}

class WithdrawalDetailScreen extends StatelessWidget {
  const WithdrawalDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Withdrawal Voucher')),
      body: MScroll([
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: superCoreTint(SuperTokens.danger, 0x14), border: Border.all(color: superCoreTint(SuperTokens.danger, 0x40)), borderRadius: BorderRadius.circular(12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Eyebrow('Withdrawal Voucher · WD-2024-0311', color: SuperTokens.danger, size: 10),
            Pill('Approved'),
          ]),
          SizedBox(height: 10),
          Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
            Text('−12,045.00 ', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 30, fontWeight: FontWeight.w700, color: SuperTokens.danger, letterSpacing: -0.5)),
            Text('SAR', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 13, color: SuperThemeData.dark.fg3)),
          ]),
        ]),
      ),
      const MCard(accentColor: SuperTokens.accent, title: 'Details', children: [
        BKV('Method', 'Wire Transfer'), BKV('Payee', 'Global Steel Imports'),
        BKV('From', 'Bank · NCB Main (1100)'), BKV('Value Date', 'Dec 19, 2025', mono: true),
      ]),
      const MCard(accentColor: SuperTokens.success, title: 'Posted Journal', pad: 16, children: [
        JournalPreview(rows: [
          ('Cost of Goods Sold (5001)', '12,045.00', null),
          ('Bank · NCB Main (1100)', null, '12,045.00'),
        ]),
      ]),
      MBtn('Back', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => context.goTo('more')),
    ]),
    );
  }
}
