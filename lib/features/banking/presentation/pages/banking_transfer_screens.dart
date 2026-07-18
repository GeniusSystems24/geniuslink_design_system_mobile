// ============================================================
// VIEW — Banking · Transfers (ports MobileBanking transfers)
// createLocalTransfer · localTransferDetail
// createExternalTransfer · externalTransferDetail
// ============================================================

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';
import '../../../../app/router/navigation_extensions.dart';

class CreateLocalTransferScreen extends StatelessWidget {
  const CreateLocalTransferScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Create Local Transfer')),
      body: const MScroll([
      ISection(icon: 'swap', title: 'Transfer Amount', accentColor: SuperTokens.accent, children: [
        MMoney(label: 'Amount', value: '50,000.00', accent: SuperTokens.accent, required: true),
      ]),
      ISection(icon: 'building', title: 'Accounts', accentColor: SuperTokens.success, children: [
        IField(label: 'From Account', value: 'Bank · NCB Main (1100)', select: true, required: true),
        IField(label: 'To Account', value: 'Bank · Al Rajhi (1101)', select: true, required: true),
        IField(label: 'Value Date', value: 'Dec 19, 2025', icon: 'calendar'),
        IField(label: 'Reference', placeholder: 'Internal note / slip no.'),
      ]),
      ISection(icon: 'ledger', title: 'Journal Preview', accentColor: SuperTokens.success, defaultOpen: false, children: [
        JournalPreview(rows: [
          ('Bank · Al Rajhi (1101)', '50,000.00', null),
          ('Bank · NCB Main (1100)', null, '50,000.00'),
        ]),
      ]),
      ActionRow(primary: 'Create Transfer'),
    ]),
    );
  }
}

class LocalTransferDetailScreen extends StatelessWidget {
  const LocalTransferDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Local Transfer Detail')),
      body: MScroll([
      const MCard(accentColor: SuperTokens.accent, title: 'Inter-Account Settlement', trailing: Pill('Posted'), children: [
        Text('TR-2024-9042 · Dec 18, 2025', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 12, color: SuperTokens.accent)),
      ]),
      const MCard(accentColor: SuperTokens.accent, title: 'Flow', pad: 16, children: [
        FromToFlow(
          from: FlowCardData(label: 'From', title: 'Bank · NCB Main', subtitle: '1100', meta: 'Balance after  ·  136,420.00'),
          to: FlowCardData(label: 'To', title: 'Bank · Al Rajhi', subtitle: '1101', meta: 'Balance after  ·  56,240.00', metaColor: SuperTokens.success),
        ),
      ]),
      MCard(accentColor: SuperTokens.success, title: 'Amount', children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Eyebrow('Transferred', color: SuperThemeData.dark.fg3, size: 11),
          Text.rich(TextSpan(children: [
            TextSpan(text: '50,000.00 ', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 24, fontWeight: FontWeight.w700, color: SuperThemeData.dark.fg1)),
            TextSpan(text: 'SAR', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 12, color: SuperThemeData.dark.fg3)),
          ])),
        ]),
      ]),
      const MCard(accentColor: SuperTokens.accent, title: 'Audit', children: [
        AuditGrid(rows: [('Created By', 'Layla Ahmed', false), ('Created At', 'Dec 18, 14:02', true)]),
      ]),
      MBtn('Back', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => context.goTo('more')),
    ]),
    );
  }
}

class CreateExternalTransferScreen extends StatelessWidget {
  const CreateExternalTransferScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Create External Transfer')),
      body: MScroll([
      ISection(icon: 'globe', title: 'Transfer Amount', accentColor: SuperTokens.warning, children: [
        MMoney(label: 'Amount', value: '11,000.00', currency: 'USD', accent: SuperTokens.warning, required: true),
      ]),
      ISection(icon: 'percent', title: 'FX Conversion', accentColor: SuperTokens.accent, children: [
        FxTiles(tiles: [
          ('Rate', '3.7500', 'USD → SAR', null),
          ('Converted', '41,250.00', 'SAR', SuperThemeData.dark.fg1),
          ('Fee', '75.00', 'SAR', SuperTokens.warning),
        ]),
      ]),
      ISection(icon: 'building', title: 'Beneficiary', accentColor: SuperTokens.success, children: [
        IField(label: 'From Account', value: 'Bank · NCB Main (1100)', select: true, required: true),
        IField(label: 'Beneficiary', value: 'Global Steel Imports', select: true, required: true),
        IField(label: 'IBAN / SWIFT', value: 'DE89 3704 0044 0532 0130 00', mono: true),
        IField(label: 'Purpose Code', value: 'GSD — Goods', select: true),
      ]),
      InfoNote('External wires settle in 1–2 business days and require dual approval.', tone: SuperTokens.accent),
      ActionRow(primary: 'Submit Wire'),
    ]),
    );
  }
}

class ExternalTransferDetailScreen extends StatelessWidget {
  const ExternalTransferDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('External Wire Detail')),
      body: MScroll([
      const MCard(accentColor: SuperTokens.warning, title: 'External Wire', trailing: Pill('Pending', tone: PillTone.warning), children: [
        Text('EXT-2024-0311 · Dec 18, 2025', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 12, color: SuperTokens.accent)),
      ]),
      MCard(accentColor: SuperTokens.warning, title: 'Amount & FX', children: [
        Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Text('−11,000.00 ', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 26, fontWeight: FontWeight.w700, color: SuperTokens.danger)),
          Text('USD', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 12, color: SuperThemeData.dark.fg3)),
        ]),
        FxTiles(tiles: [
          ('Rate', '3.7500', 'USD → SAR', null),
          ('Debited', '41,250.00', 'SAR', SuperThemeData.dark.fg1),
          ('Fee', '75.00', 'SAR', SuperTokens.warning),
        ]),
      ]),
      const MCard(accentColor: SuperTokens.success, title: 'Beneficiary', children: [
        BKV('Name', 'Global Steel Imports'),
        BKV('IBAN', 'DE89 3704 0044 0532 0130 00', mono: true),
        BKV('SWIFT', 'COBADEFFXXX', mono: true),
        BKV('Purpose', 'GSD — Goods'),
      ]),
      const BankNote('Awaiting controller approval. Funds are reserved until the wire is released or cancelled.', tone: SuperTokens.warning),
      MBtn('Back', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => context.goTo('more')),
    ]),
    );
  }
}
