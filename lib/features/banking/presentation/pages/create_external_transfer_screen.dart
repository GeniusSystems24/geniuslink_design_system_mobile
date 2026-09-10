part of 'banking_transfer_screens.dart';

class CreateExternalTransferScreen extends StatelessWidget {
  const CreateExternalTransferScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var icon = MIcons.of('globe');
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon2 = MIcons.of('percent');
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var icon3 = MIcons.of('building');
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: Text(GeniusLinkLocalization.of(context).createExternalTransfer), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
      body: MScroll([
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
              IField(label: GeniusLinkLocalization.of(context).purposeCode, value: 'GSD — Goods', select: true),
            ],
          ),
        ),
        InfoNote(
          GeniusLinkLocalization.of(context).externalWiresSettleIn12BusinessDaysAndRequireDualApproval,
          tone: SuperMaterialThemeData.of(context).colorScheme.primary,
        ),
        const ActionRow(primary: 'Submit Wire'),
      ]),
    );
  }
}
