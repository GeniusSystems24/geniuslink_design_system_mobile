part of 'banking_transfer_screens.dart';

class CreateLocalTransferScreen extends StatelessWidget {
  const CreateLocalTransferScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon = MIcons.of('swap');
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var icon2 = MIcons.of('ledger');
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var icon3 = MIcons.of('building');
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: Text(GeniusLinkLocalization.of(context).createLocalTransfer), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
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
                placeholder: GeniusLinkLocalization.of(context).internalNoteSlipNo,
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
      ]),
    );
  }
}
