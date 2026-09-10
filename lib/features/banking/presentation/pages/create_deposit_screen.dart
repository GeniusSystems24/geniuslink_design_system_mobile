part of 'banking_cash_screens.dart';

class CreateDepositScreen extends StatelessWidget {
  const CreateDepositScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var icon = MIcons.of('download');
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var icon2 = MIcons.of('ledger');
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon3 = MIcons.of('card');
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: Text(GeniusLinkLocalization.of(context).createDeposit), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
      body: MScroll([
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).depositAmount,
          initiallyExpanded: true,
          accentColor: accentColor,
          icon: icon,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              MMoney(
                label: GeniusLinkLocalization.of(context).amount,
                value: '120,000.00',
                accent: SuperMaterialThemeData.of(
                  context,
                ).colorScheme.secondary,
                required: true,
                sign: '+',
              ),
              const MMethod(value: 'cash'),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).destination,

          initiallyExpanded: true,
          accentColor: accentColor3,
          icon: icon3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              IField(
                label: GeniusLinkLocalization.of(context).depositTo,
                value: 'Bank · NCB Main (1100)',
                select: true,
                required: true,
              ),
              IField(label: GeniusLinkLocalization.of(context).reference, placeholder: GeniusLinkLocalization.of(context).eGCounterSlipNo),
              IField(
                label: GeniusLinkLocalization.of(context).valueDate,
                value: 'Dec 19, 2025',
                icon: 'calendar',
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
                  ('Bank · NCB Main (1100)', '120,000.00', null),
                  ('Cash Box (1001)', null, '120,000.00'),
                ],
              ),
            ],
          ),
        ),
        ITextarea(
          label: 'Memo',
          placeholder: GeniusLinkLocalization.of(context).optionalNoteForThisDeposit,
        ),
        const ActionRow(primary: 'Create Deposit'),
      ]),
    );
  }
}
