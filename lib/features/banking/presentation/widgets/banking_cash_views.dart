import 'package:flutter/material.dart';

import 'package:gl_mobile_app/app/router/navigation_extensions.dart';
import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/features/accounts/presentation/widgets/audit_column.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/shared/presentation/widgets/feature_page_scaffold.dart';

/// Presentation view extracted from `CreateDepositScreen`.
///
/// Keeping rendering in a dedicated widget lets the page remain a lifecycle,
/// controller, and navigation boundary while this view stays independently
/// composable and testable.
///
/// Example:
///
/// ```dart
/// const CreateDepositView()
/// ```
class CreateDepositView extends StatelessWidget {
  const CreateDepositView({super.key});
  @override
  Widget build(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var icon = MIcons.of('download');
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var icon2 = MIcons.of('ledger');
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon3 = MIcons.of('card');
    return FeaturePageScaffold(
      title: Text(GeniusLinkLocalization.of(context).createDeposit),
      automaticallyImplyLeading: true,
      children: [
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).depositAmount,
          initiallyExpanded: true,
          accentColor: accentColor,
          icon: icon,
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 6,
                large: 6,
                child: MMoney(
                  label: GeniusLinkLocalization.of(context).amount,
                  value: '120,000.00',
                  accent: SuperMaterialThemeData.of(
                    context,
                  ).colorScheme.secondary,
                  required: true,
                  sign: '+',
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 12,
                large: 12,
                child: const MMethod(value: 'cash'),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).destination,

          initiallyExpanded: true,
          accentColor: accentColor3,
          icon: icon3,
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: IField(
                  label: GeniusLinkLocalization.of(context).depositTo,
                  value: 'Bank · NCB Main (1100)',
                  select: true,
                  required: true,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: IField(
                  label: GeniusLinkLocalization.of(context).reference,
                  placeholder: GeniusLinkLocalization.of(
                    context,
                  ).eGCounterSlipNo,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: IField(
                  label: GeniusLinkLocalization.of(context).valueDate,
                  value: 'Dec 19, 2025',
                  icon: 'calendar',
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).journalPreview,

          initiallyExpanded: false,
          accentColor: accentColor2,
          icon: icon2,
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 12,
                large: 12,
                child: JournalPreview(
                  rows: [
                    ('Bank · NCB Main (1100)', '120,000.00', null),
                    ('Cash Box (1001)', null, '120,000.00'),
                  ],
                ),
              ),
            ],
          ),
        ),
        ITextarea(
          label: 'Memo',
          placeholder: GeniusLinkLocalization.of(
            context,
          ).optionalNoteForThisDeposit,
        ),
        const ActionRow(primary: 'Create Deposit'),
      ],
    );
  }
}

/// Presentation view extracted from `DepositDetailScreen`.
///
/// Keeping rendering in a dedicated widget lets the page remain a lifecycle,
/// controller, and navigation boundary while this view stays independently
/// composable and testable.
///
/// Example:
///
/// ```dart
/// const DepositDetailView()
/// ```
class DepositDetailView extends StatelessWidget {
  const DepositDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.primary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    return FeaturePageScaffold(
      title: Text(GeniusLinkLocalization.of(context).depositReceipt),
      automaticallyImplyLeading: true,
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: superCoreTint(
              SuperMaterialThemeData.of(context).colorScheme.secondary,
              0x14,
            ),
            border: Border.all(
              color: superCoreTint(
                SuperMaterialThemeData.of(context).colorScheme.secondary,
                0x40,
              ),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Eyebrow(
                'Deposit Receipt · DEP-2024-0182',
                color: SuperMaterialThemeData.of(context).colorScheme.secondary,
                size: 10,
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '+120,000.00 ',
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: SuperMaterialThemeData.of(
                        context,
                      ).colorScheme.secondary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    'SAR',
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 13,
                      color: SuperMaterialThemeData.of(context).superTheme.fg3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).details,

          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(16),
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 6,
                large: 6,
                child: BKV('Method', 'Cash'),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 6,
                large: 6,
                child: BKV('Deposited To', 'Bank · NCB Main (1100)'),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 6,
                large: 6,
                child: BKV('Value Date', 'Dec 19, 2025', mono: true),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 6,
                large: 6,
                child: BKV('Reference', 'CTR-9920', mono: true),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 6,
                large: 6,
                child: BKV('Status', 'Cleared'),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).postedJournal,

          initiallyExpanded: true,
          accentColor: accentColor3,

          padding: EdgeInsets.all(16),
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 12,
                large: 12,
                child: JournalPreview(
                  rows: [
                    ('Bank · NCB Main (1100)', '120,000.00', null),
                    ('Cash Box (1001)', null, '120,000.00'),
                  ],
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).audit,

          initiallyExpanded: true,
          accentColor: accentColor2,

          padding: EdgeInsets.all(16),
          child: AuditColumn(
            items: [
              AuditItem(
                title: 'Created',
                doAt: DateTime(2025, 12, 19, 9, 42),
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

/// Presentation view extracted from `CreateWithdrawalScreen`.
///
/// Keeping rendering in a dedicated widget lets the page remain a lifecycle,
/// controller, and navigation boundary while this view stays independently
/// composable and testable.
///
/// Example:
///
/// ```dart
/// const CreateWithdrawalView()
/// ```
class CreateWithdrawalView extends StatelessWidget {
  const CreateWithdrawalView({super.key});
  @override
  Widget build(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.error;
    var icon = MIcons.of('card');
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon2 = MIcons.of('building');
    return FeaturePageScaffold(
      title: Text(GeniusLinkLocalization.of(context).createWithdrawal),
      automaticallyImplyLeading: true,
      children: [
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).withdrawalAmount,

          initiallyExpanded: true,
          accentColor: accentColor,
          icon: icon,
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 6,
                large: 6,
                child: MMoney(
                  label: GeniusLinkLocalization.of(context).amount,
                  value: '12,045.00',
                  accent: SuperMaterialThemeData.of(context).colorScheme.error,
                  required: true,
                  sign: '−',
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 12,
                large: 12,
                child: const MMethod(value: 'wire'),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: 'Source & Purpose',

          initiallyExpanded: true,
          accentColor: accentColor2,
          icon: icon2,
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: IField(
                  label: GeniusLinkLocalization.of(context).withdrawFrom,
                  value: 'Bank · NCB Main (1100)',
                  select: true,
                  required: true,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: IField(
                  label: GeniusLinkLocalization.of(context).payee,
                  placeholder: GeniusLinkLocalization.of(
                    context,
                  ).eGGlobalSteelImports,
                  required: true,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: IField(
                  label: GeniusLinkLocalization.of(context).expenseAccount,
                  value: 'Cost of Goods Sold (5001)',
                  select: true,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: IField(
                  label: GeniusLinkLocalization.of(context).valueDate,
                  value: 'Dec 19, 2025',
                  icon: 'calendar',
                ),
              ),
            ],
          ),
        ),
        InfoNote(
          GeniusLinkLocalization.of(
            context,
          ).withdrawalsAbove10000SarRequireASecondApprovalBeforePosting,
          tone: SuperMaterialThemeData.of(context).colorScheme.tertiary,
        ),
        const ActionRow(primary: 'Submit for Approval'),
      ],
    );
  }
}

/// Presentation view extracted from `WithdrawalDetailScreen`.
///
/// Keeping rendering in a dedicated widget lets the page remain a lifecycle,
/// controller, and navigation boundary while this view stays independently
/// composable and testable.
///
/// Example:
///
/// ```dart
/// const WithdrawalDetailView()
/// ```
class WithdrawalDetailView extends StatelessWidget {
  const WithdrawalDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.primary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    return FeaturePageScaffold(
      title: Text(GeniusLinkLocalization.of(context).withdrawalVoucher),
      automaticallyImplyLeading: true,
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: superCoreTint(
              SuperMaterialThemeData.of(context).colorScheme.error,
              0x14,
            ),
            border: Border.all(
              color: superCoreTint(
                SuperMaterialThemeData.of(context).colorScheme.error,
                0x40,
              ),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Eyebrow(
                    'Withdrawal Voucher · WD-2024-0311',
                    color: SuperMaterialThemeData.of(context).colorScheme.error,
                    size: 10,
                  ),
                  Pill(GeniusLinkLocalization.of(context).approved),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '−12,045.00 ',
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: SuperMaterialThemeData.of(
                        context,
                      ).colorScheme.error,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    'SAR',
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 13,
                      color: SuperMaterialThemeData.of(context).superTheme.fg3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).details,

          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(16),
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 6,
                large: 6,
                child: BKV('Method', 'Wire Transfer'),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 6,
                large: 6,
                child: BKV('Payee', 'Global Steel Imports'),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 6,
                large: 6,
                child: BKV('From', 'Bank · NCB Main (1100)'),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 6,
                large: 6,
                child: BKV('Value Date', 'Dec 19, 2025', mono: true),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).postedJournal,

          initiallyExpanded: true,
          accentColor: accentColor2,

          padding: EdgeInsets.all(16),
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 12,
                large: 12,
                child: JournalPreview(
                  rows: [
                    ('Cost of Goods Sold (5001)', '12,045.00', null),
                    ('Bank · NCB Main (1100)', null, '12,045.00'),
                  ],
                ),
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
