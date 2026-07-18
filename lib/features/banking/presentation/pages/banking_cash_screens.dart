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
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, elevation: 0, title: const Text('Create Deposit')),
      body: MScroll([
      ISection(icon: 'download', title: 'Deposit Amount', accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, children: [
        MMoney(label: 'Amount', value: '120,000.00', accent: SuperMaterialThemeData.of(context).colorScheme.secondary, required: true, sign: '+'),
        MMethod(value: 'cash'),
      ]),
      ISection(icon: 'card', title: 'Destination', accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, children: [
        IField(label: 'Deposit To', value: 'Bank · NCB Main (1100)', select: true, required: true),
        IField(label: 'Reference', placeholder: 'e.g. Counter slip no.'),
        IField(label: 'Value Date', value: 'Dec 19, 2025', icon: 'calendar'),
      ]),
      ISection(icon: 'ledger', title: 'Journal Preview', accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, defaultOpen: false, children: [
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
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, elevation: 0, title: const Text('Deposit Receipt')),
      body: MScroll([
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.secondary, 0x14), border: Border.all(color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.secondary, 0x40)), borderRadius: BorderRadius.circular(12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Eyebrow('Deposit Receipt · DEP-2024-0182', color: SuperMaterialThemeData.of(context).colorScheme.secondary, size: 10),
          SizedBox(height: 10),
          Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
            Text('+120,000.00 ', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 30, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).colorScheme.secondary, letterSpacing: -0.5)),
            Text('SAR', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
          ]),
        ]),
      ),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Details', children: [
        BKV('Method', 'Cash'), BKV('Deposited To', 'Bank · NCB Main (1100)'),
        BKV('Value Date', 'Dec 19, 2025', mono: true), BKV('Reference', 'CTR-9920', mono: true),
        BKV('Status', 'Cleared'),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Posted Journal', pad: 16, children: [
        JournalPreview(rows: [
          ('Bank · NCB Main (1100)', '120,000.00', null),
          ('Cash Box (1001)', null, '120,000.00'),
        ]),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Audit', children: [
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
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, elevation: 0, title: const Text('Create Withdrawal')),
      body: MScroll([
      ISection(icon: 'card', title: 'Withdrawal Amount', accentColor: SuperMaterialThemeData.of(context).colorScheme.error, children: [
        MMoney(label: 'Amount', value: '12,045.00', accent: SuperMaterialThemeData.of(context).colorScheme.error, required: true, sign: '−'),
        MMethod(value: 'wire'),
      ]),
      ISection(icon: 'building', title: 'Source & Purpose', accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, children: [
        IField(label: 'Withdraw From', value: 'Bank · NCB Main (1100)', select: true, required: true),
        IField(label: 'Payee', placeholder: 'e.g. Global Steel Imports', required: true),
        IField(label: 'Expense Account', value: 'Cost of Goods Sold (5001)', select: true),
        IField(label: 'Value Date', value: 'Dec 19, 2025', icon: 'calendar'),
      ]),
      InfoNote('Withdrawals above 10,000 SAR require a second approval before posting.', tone: SuperMaterialThemeData.of(context).colorScheme.tertiary),
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
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, elevation: 0, title: const Text('Withdrawal Voucher')),
      body: MScroll([
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.error, 0x14), border: Border.all(color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.error, 0x40)), borderRadius: BorderRadius.circular(12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Eyebrow('Withdrawal Voucher · WD-2024-0311', color: SuperMaterialThemeData.of(context).colorScheme.error, size: 10),
            Pill('Approved'),
          ]),
          SizedBox(height: 10),
          Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
            Text('−12,045.00 ', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 30, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).colorScheme.error, letterSpacing: -0.5)),
            Text('SAR', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
          ]),
        ]),
      ),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Details', children: [
        BKV('Method', 'Wire Transfer'), BKV('Payee', 'Global Steel Imports'),
        BKV('From', 'Bank · NCB Main (1100)'), BKV('Value Date', 'Dec 19, 2025', mono: true),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Posted Journal', pad: 16, children: [
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
