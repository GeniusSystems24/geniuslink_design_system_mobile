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
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Create Local Transfer'),
      body: MScroll([
      ISection(icon: 'swap', title: 'Transfer Amount', accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, children: [
        MMoney(label: 'Amount', value: '50,000.00', accent: SuperMaterialThemeData.of(context).colorScheme.primary, required: true),
      ]),
      ISection(icon: 'building', title: 'Accounts', accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, children: [
        IField(label: 'From Account', value: 'Bank · NCB Main (1100)', select: true, required: true),
        IField(label: 'To Account', value: 'Bank · Al Rajhi (1101)', select: true, required: true),
        IField(label: 'Value Date', value: 'Dec 19, 2025', icon: 'calendar'),
        IField(label: 'Reference', placeholder: 'Internal note / slip no.'),
      ]),
      ISection(icon: 'ledger', title: 'Journal Preview', accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, defaultOpen: false, children: [
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
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Local Transfer Detail'),
      body: MScroll([
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Inter-Account Settlement', trailing: Pill('Posted'), children: [
        Text('TR-2024-9042 · Dec 18, 2025', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).colorScheme.primary)),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Flow', pad: 16, children: [
        FromToFlow(
          from: FlowCardData(label: 'From', title: 'Bank · NCB Main', subtitle: '1100', meta: 'Balance after  ·  136,420.00'),
          to: FlowCardData(label: 'To', title: 'Bank · Al Rajhi', subtitle: '1101', meta: 'Balance after  ·  56,240.00', metaColor: SuperMaterialThemeData.of(context).colorScheme.secondary),
        ),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Amount', children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Eyebrow('Transferred', color: SuperMaterialThemeData.of(context).superTheme.fg3, size: 11),
          Text.rich(TextSpan(children: [
            TextSpan(text: '50,000.00 ', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 24, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
            TextSpan(text: 'SAR', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
          ])),
        ]),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Audit', children: [
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
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Create External Transfer'),
      body: MScroll([
      ISection(icon: 'globe', title: 'Transfer Amount', accentColor: SuperMaterialThemeData.of(context).colorScheme.tertiary, children: [
        MMoney(label: 'Amount', value: '11,000.00', currency: 'USD', accent: SuperMaterialThemeData.of(context).colorScheme.tertiary, required: true),
      ]),
      ISection(icon: 'percent', title: 'FX Conversion', accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, children: [
        FxTiles(tiles: [
          ('Rate', '3.7500', 'USD → SAR', null),
          ('Converted', '41,250.00', 'SAR', SuperMaterialThemeData.of(context).superTheme.fg1),
          ('Fee', '75.00', 'SAR', SuperMaterialThemeData.of(context).colorScheme.tertiary),
        ]),
      ]),
      ISection(icon: 'building', title: 'Beneficiary', accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, children: [
        IField(label: 'From Account', value: 'Bank · NCB Main (1100)', select: true, required: true),
        IField(label: 'Beneficiary', value: 'Global Steel Imports', select: true, required: true),
        IField(label: 'IBAN / SWIFT', value: 'DE89 3704 0044 0532 0130 00', mono: true),
        IField(label: 'Purpose Code', value: 'GSD — Goods', select: true),
      ]),
      InfoNote('External wires settle in 1–2 business days and require dual approval.', tone: SuperMaterialThemeData.of(context).colorScheme.primary),
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
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'External Wire Detail'),
      body: MScroll([
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.tertiary, title: 'External Wire', trailing: Pill('Pending', tone: PillTone.warning), children: [
        Text('EXT-2024-0311 · Dec 18, 2025', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).colorScheme.primary)),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.tertiary, title: 'Amount & FX', children: [
        Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Text('−11,000.00 ', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 26, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).colorScheme.error)),
          Text('USD', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
        ]),
        FxTiles(tiles: [
          ('Rate', '3.7500', 'USD → SAR', null),
          ('Debited', '41,250.00', 'SAR', SuperMaterialThemeData.of(context).superTheme.fg1),
          ('Fee', '75.00', 'SAR', SuperMaterialThemeData.of(context).colorScheme.tertiary),
        ]),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Beneficiary', children: [
        BKV('Name', 'Global Steel Imports'),
        BKV('IBAN', 'DE89 3704 0044 0532 0130 00', mono: true),
        BKV('SWIFT', 'COBADEFFXXX', mono: true),
        BKV('Purpose', 'GSD — Goods'),
      ]),
      BankNote('Awaiting controller approval. Funds are reserved until the wire is released or cancelled.', tone: SuperMaterialThemeData.of(context).colorScheme.tertiary),
      MBtn('Back', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => context.goTo('more')),
    ]),
    );
  }
}
