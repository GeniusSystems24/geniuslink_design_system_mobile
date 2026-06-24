// ============================================================
// VIEW — Banking · Cash (ports MobileBanking deposit/withdrawal)
// createDeposit · depositDetail · createWithdrawal · withdrawalDetail
// ============================================================

import 'package:flutter/material.dart';
import '../../../../design_system/adapters/inventory/m_inv_kit.dart';
import '../../../../design_system/kit.dart';
import '../../../../design_system/adapters/banking/m_bank_kit.dart';
import '../../../../workspace/presentation/controllers/nav_controller.dart';

class CreateDepositScreen extends StatelessWidget {
  const CreateDepositScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MScroll([
      const ISection(icon: 'download', title: 'Deposit Amount', marker: M.green, children: [
        MMoney(label: 'Amount', value: '120,000.00', accent: M.green, required: true, sign: '+'),
        MMethod(value: 'cash'),
      ]),
      const ISection(icon: 'card', title: 'Destination', marker: M.blue, children: [
        IField(label: 'Deposit To', value: 'Bank · NCB Main (1100)', select: true, required: true),
        IField(label: 'Reference', placeholder: 'e.g. Counter slip no.'),
        IField(label: 'Value Date', value: 'Dec 19, 2025', icon: 'calendar'),
      ]),
      const ISection(icon: 'ledger', title: 'Journal Preview', marker: M.green, defaultOpen: false, children: [
        JournalPreview(rows: [
          ('Bank · NCB Main (1100)', '120,000.00', null),
          ('Cash Box (1001)', null, '120,000.00'),
        ]),
      ]),
      const ITextarea(label: 'Memo', placeholder: 'Optional note for this deposit…'),
      const ActionRow(primary: 'Create Deposit'),
    ]);
  }
}

class DepositDetailScreen extends StatelessWidget {
  final NavController nav;
  const DepositDetailScreen({super.key, required this.nav});
  @override
  Widget build(BuildContext context) {
    return MScroll([
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: tint(M.green, 0x14), border: Border.all(color: tint(M.green, 0x40)), borderRadius: BorderRadius.circular(12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Eyebrow('Deposit Receipt · DEP-2024-0182', color: M.green, size: 10),
          SizedBox(height: 10),
          Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
            Text('+120,000.00 ', style: TextStyle(fontFamily: M.mono, fontSize: 30, fontWeight: FontWeight.w700, color: M.green, letterSpacing: -0.5)),
            Text('SAR', style: TextStyle(fontFamily: M.mono, fontSize: 13, color: M.fg3)),
          ]),
        ]),
      ),
      const MCard(marker: M.blue, title: 'Details', children: [
        BKV('Method', 'Cash'), BKV('Deposited To', 'Bank · NCB Main (1100)'),
        BKV('Value Date', 'Dec 19, 2025', mono: true), BKV('Reference', 'CTR-9920', mono: true),
        BKV('Status', 'Cleared'),
      ]),
      const MCard(marker: M.green, title: 'Posted Journal', pad: 16, children: [
        JournalPreview(rows: [
          ('Bank · NCB Main (1100)', '120,000.00', null),
          ('Cash Box (1001)', null, '120,000.00'),
        ]),
      ]),
      const MCard(marker: M.blue, title: 'Audit', children: [
        AuditGrid(rows: [
          ('Created By', 'Layla Ahmed', false),
          ('Created At', 'Dec 19, 09:42', true),
        ]),
      ]),
      MBtn('Back', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => nav.back('more')),
    ]);
  }
}

class CreateWithdrawalScreen extends StatelessWidget {
  const CreateWithdrawalScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MScroll([
      const ISection(icon: 'card', title: 'Withdrawal Amount', marker: M.red, children: [
        MMoney(label: 'Amount', value: '12,045.00', accent: M.red, required: true, sign: '−'),
        MMethod(value: 'wire'),
      ]),
      const ISection(icon: 'building', title: 'Source & Purpose', marker: M.blue, children: [
        IField(label: 'Withdraw From', value: 'Bank · NCB Main (1100)', select: true, required: true),
        IField(label: 'Payee', placeholder: 'e.g. Global Steel Imports', required: true),
        IField(label: 'Expense Account', value: 'Cost of Goods Sold (5001)', select: true),
        IField(label: 'Value Date', value: 'Dec 19, 2025', icon: 'calendar'),
      ]),
      const InfoNote('Withdrawals above 10,000 SAR require a second approval before posting.', tone: M.orange),
      const ActionRow(primary: 'Submit for Approval'),
    ]);
  }
}

class WithdrawalDetailScreen extends StatelessWidget {
  final NavController nav;
  const WithdrawalDetailScreen({super.key, required this.nav});
  @override
  Widget build(BuildContext context) {
    return MScroll([
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: tint(M.red, 0x14), border: Border.all(color: tint(M.red, 0x40)), borderRadius: BorderRadius.circular(12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
            Eyebrow('Withdrawal Voucher · WD-2024-0311', color: M.red, size: 10),
            Pill('Approved'),
          ]),
          const SizedBox(height: 10),
          const Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
            Text('−12,045.00 ', style: TextStyle(fontFamily: M.mono, fontSize: 30, fontWeight: FontWeight.w700, color: M.red, letterSpacing: -0.5)),
            Text('SAR', style: TextStyle(fontFamily: M.mono, fontSize: 13, color: M.fg3)),
          ]),
        ]),
      ),
      const MCard(marker: M.blue, title: 'Details', children: [
        BKV('Method', 'Wire Transfer'), BKV('Payee', 'Global Steel Imports'),
        BKV('From', 'Bank · NCB Main (1100)'), BKV('Value Date', 'Dec 19, 2025', mono: true),
      ]),
      const MCard(marker: M.green, title: 'Posted Journal', pad: 16, children: [
        JournalPreview(rows: [
          ('Cost of Goods Sold (5001)', '12,045.00', null),
          ('Bank · NCB Main (1100)', null, '12,045.00'),
        ]),
      ]),
      MBtn('Back', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => nav.back('more')),
    ]);
  }
}
