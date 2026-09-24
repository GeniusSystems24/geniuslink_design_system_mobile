import 'package:flutter/material.dart';

import 'package:gl_mobile_app/app/router/navigation_extensions.dart';
import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/features/accounts/presentation/widgets/audit_column.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/shared/presentation/widgets/feature_page_scaffold.dart';

/// Presentation view extracted from `CreateLocalTransferScreen`.
///
/// Keeping rendering in a dedicated widget lets the page remain a lifecycle,
/// controller, and navigation boundary while this view stays independently
/// composable and testable.
///
/// Example:
///
/// ```dart
/// const CreateLocalTransferView()
/// ```
class CreateLocalTransferView extends StatelessWidget {
  const CreateLocalTransferView({super.key});
  @override
  Widget build(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon = MIcons.of('swap');
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var icon2 = MIcons.of('ledger');
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var icon3 = MIcons.of('building');
    return FeaturePageScaffold(
      title: Text(GeniusLinkLocalization.of(context).createLocalTransfer),
      automaticallyImplyLeading: true,
      children: [
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).transferAmount,

          initiallyExpanded: true,
          accentColor: accentColor,
          icon: icon,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              MMoney(
                label: GeniusLinkLocalization.of(context).amount,
                value: '50,000.00',
                accent: SuperMaterialThemeData.of(context).colorScheme.primary,
                required: true,
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).accounts,

          initiallyExpanded: true,
          accentColor: accentColor3,
          icon: icon3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              IField(
                label: 'From Account',
                value: 'Bank · NCB Main (1100)',
                select: true,
                required: true,
              ),
              IField(
                label: GeniusLinkLocalization.of(context).toAccount,
                value: 'Bank · Al Rajhi (1101)',
                select: true,
                required: true,
              ),
              IField(
                label: GeniusLinkLocalization.of(context).valueDate,
                value: 'Dec 19, 2025',
                icon: 'calendar',
              ),
              IField(
                label: GeniusLinkLocalization.of(context).reference,
                placeholder: GeniusLinkLocalization.of(
                  context,
                ).internalNoteSlipNo,
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).journalPreview,

          initiallyExpanded: false,
          accentColor: accentColor2,
          icon: icon2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              JournalPreview(
                rows: [
                  ('Bank · Al Rajhi (1101)', '50,000.00', null),
                  ('Bank · NCB Main (1100)', null, '50,000.00'),
                ],
              ),
            ],
          ),
        ),
        const ActionRow(primary: 'Create Transfer'),
      ],
    );
  }
}

/// Presentation view extracted from `LocalTransferDetailScreen`.
///
/// Keeping rendering in a dedicated widget lets the page remain a lifecycle,
/// controller, and navigation boundary while this view stays independently
/// composable and testable.
///
/// Example:
///
/// ```dart
/// const LocalTransferDetailView()
/// ```
class LocalTransferDetailView extends StatelessWidget {
  const LocalTransferDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    var trailing = Pill(GeniusLinkLocalization.of(context).posted);
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.primary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var accentColor4 = SuperMaterialThemeData.of(context).colorScheme.primary;
    return FeaturePageScaffold(
      title: const Text('Local Transfer Detail'),
      automaticallyImplyLeading: true,
      children: [
        SuperSectionCard2(
          trailing: trailing,
          title: GeniusLinkLocalization.of(context).interAccountSettlement,

          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'TR-2024-9042 · Dec 18, 2025',
                style: TextStyle(
                  fontFamily: SuperMaterialThemeData.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                  fontSize: 12,
                  color: SuperMaterialThemeData.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: 'Flow',

          initiallyExpanded: true,
          accentColor: accentColor4,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              FromToFlow(
                from: const FlowCardData(
                  label: 'From',
                  title: 'Bank · NCB Main',
                  subtitle: '1100',
                  meta: 'Balance after  ·  136,420.00',
                ),
                to: FlowCardData(
                  label: GeniusLinkLocalization.of(context).to,
                  title: 'Bank · Al Rajhi',
                  subtitle: '1101',
                  meta: 'Balance after  ·  56,240.00',
                  metaColor: SuperMaterialThemeData.of(
                    context,
                  ).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).amount,

          initiallyExpanded: true,
          accentColor: accentColor2,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Eyebrow(
                    GeniusLinkLocalization.of(context).transferred,
                    color: SuperMaterialThemeData.of(context).superTheme.fg3,
                    size: 11,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '50,000.00 ',
                          style: TextStyle(
                            fontFamily: SuperMaterialThemeData.of(
                              context,
                            ).textTheme.bodyMedium?.fontFamily,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: SuperMaterialThemeData.of(
                              context,
                            ).superTheme.fg1,
                          ),
                        ),
                        TextSpan(
                          text: 'SAR',
                          style: TextStyle(
                            fontFamily: SuperMaterialThemeData.of(
                              context,
                            ).textTheme.bodyMedium?.fontFamily,
                            fontSize: 12,
                            color: SuperMaterialThemeData.of(
                              context,
                            ).superTheme.fg3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).audit,

          initiallyExpanded: true,
          accentColor: accentColor3,

          padding: EdgeInsets.all(16),
          child: AuditColumn(
            items: [
              AuditItem(
                title: 'Created',
                doAt: DateTime(2025, 12, 18, 14, 2),
                doBy: 'Layla Ahmed',
              ),
            ],
          ),
        ),
        MBtn(
          'Back',
          variant: MBtnVariant.secondary,
          icon: 'back',
          full: true,
          onTap: () => context.goTo('more'),
        ),
      ],
    );
  }
}

/// Presentation view extracted from `CreateExternalTransferScreen`.
///
/// Keeping rendering in a dedicated widget lets the page remain a lifecycle,
/// controller, and navigation boundary while this view stays independently
/// composable and testable.
///
/// Example:
///
/// ```dart
/// const CreateExternalTransferView()
/// ```
class CreateExternalTransferView extends StatelessWidget {
  const CreateExternalTransferView({super.key});
  @override
  Widget build(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var icon = MIcons.of('globe');
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon2 = MIcons.of('percent');
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var icon3 = MIcons.of('building');
    return FeaturePageScaffold(
      title: Text(GeniusLinkLocalization.of(context).createExternalTransfer),
      automaticallyImplyLeading: true,
      children: [
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).transferAmount,

          initiallyExpanded: true,
          accentColor: accentColor,
          icon: icon,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              MMoney(
                label: GeniusLinkLocalization.of(context).amount,
                value: '11,000.00',
                currency: 'USD',
                accent: SuperMaterialThemeData.of(context).colorScheme.tertiary,
                required: true,
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).fxConversion,

          initiallyExpanded: true,
          accentColor: accentColor2,
          icon: icon2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              FxTiles(
                tiles: [
                  ('Rate', '3.7500', 'USD → SAR', null),
                  (
                    'Converted',
                    '41,250.00',
                    'SAR',
                    SuperMaterialThemeData.of(context).superTheme.fg1,
                  ),
                  (
                    'Fee',
                    '75.00',
                    'SAR',
                    SuperMaterialThemeData.of(context).colorScheme.tertiary,
                  ),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).beneficiary,

          initiallyExpanded: true,
          accentColor: accentColor3,
          icon: icon3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              IField(
                label: 'From Account',
                value: 'Bank · NCB Main (1100)',
                select: true,
                required: true,
              ),
              IField(
                label: GeniusLinkLocalization.of(context).beneficiary,
                value: 'Global Steel Imports',
                select: true,
                required: true,
              ),
              IField(
                label: GeniusLinkLocalization.of(context).ibanSwift,
                value: 'DE89 3704 0044 0532 0130 00',
                mono: true,
              ),
              IField(
                label: GeniusLinkLocalization.of(context).purposeCode,
                value: 'GSD — Goods',
                select: true,
              ),
            ],
          ),
        ),
        InfoNote(
          GeniusLinkLocalization.of(
            context,
          ).externalWiresSettleIn12BusinessDaysAndRequireDualApproval,
          tone: SuperMaterialThemeData.of(context).colorScheme.primary,
        ),
        const ActionRow(primary: 'Submit Wire'),
      ],
    );
  }
}

/// Presentation view extracted from `ExternalTransferDetailScreen`.
///
/// Keeping rendering in a dedicated widget lets the page remain a lifecycle,
/// controller, and navigation boundary while this view stays independently
/// composable and testable.
///
/// Example:
///
/// ```dart
/// const ExternalTransferDetailView()
/// ```
class ExternalTransferDetailView extends StatelessWidget {
  const ExternalTransferDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var trailing = const Pill('Pending', tone: PillTone.warning);
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    return FeaturePageScaffold(
      title: Text(GeniusLinkLocalization.of(context).externalWireDetail),
      automaticallyImplyLeading: true,
      children: [
        SuperSectionCard2(
          trailing: trailing,
          title: GeniusLinkLocalization.of(context).externalWire,

          initiallyExpanded: true,
          accentColor: accentColor2,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'EXT-2024-0311 · Dec 18, 2025',
                style: TextStyle(
                  fontFamily: SuperMaterialThemeData.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                  fontSize: 12,
                  color: SuperMaterialThemeData.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: 'Amount & FX',

          initiallyExpanded: true,
          accentColor: accentColor3,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '−11,000.00 ',
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: SuperMaterialThemeData.of(
                        context,
                      ).colorScheme.error,
                    ),
                  ),
                  Text(
                    'USD',
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 12,
                      color: SuperMaterialThemeData.of(context).superTheme.fg3,
                    ),
                  ),
                ],
              ),
              FxTiles(
                tiles: [
                  ('Rate', '3.7500', 'USD → SAR', null),
                  (
                    'Debited',
                    '41,250.00',
                    'SAR',
                    SuperMaterialThemeData.of(context).superTheme.fg1,
                  ),
                  (
                    'Fee',
                    '75.00',
                    'SAR',
                    SuperMaterialThemeData.of(context).colorScheme.tertiary,
                  ),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).beneficiary,

          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              BKV('Name', 'Global Steel Imports'),
              BKV('IBAN', 'DE89 3704 0044 0532 0130 00', mono: true),
              BKV('SWIFT', 'COBADEFFXXX', mono: true),
              BKV('Purpose', 'GSD — Goods'),
            ],
          ),
        ),
        BankNote(
          'Awaiting controller approval. Funds are reserved until the wire is released or cancelled.',
          tone: SuperMaterialThemeData.of(context).colorScheme.tertiary,
        ),
        MBtn(
          'Back',
          variant: MBtnVariant.secondary,
          icon: 'back',
          full: true,
          onTap: () => context.goTo('more'),
        ),
      ],
    );
  }
}
