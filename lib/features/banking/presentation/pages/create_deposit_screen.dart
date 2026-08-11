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
      appBar: SuperAppBar(title: const Text('Create Deposit')),
      body: MScroll([
        SuperSectionCard2(
          trailing: (null),
          title: 'Deposit Amount',
          subtitle: (null),
          initiallyExpanded: true,
          accentColor: accentColor,
          icon: icon,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              MMoney(
                label: 'Amount',
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
          trailing: (null),
          title: 'Destination',
          subtitle: (null),
          initiallyExpanded: true,
          accentColor: accentColor3,
          icon: icon3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              IField(
                label: 'Deposit To',
                value: 'Bank · NCB Main (1100)',
                select: true,
                required: true,
              ),
              IField(label: 'Reference', placeholder: 'e.g. Counter slip no.'),
              IField(
                label: 'Value Date',
                value: 'Dec 19, 2025',
                icon: 'calendar',
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          trailing: (null),
          title: 'Journal Preview',
          subtitle: (null),
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
        const ITextarea(
          label: 'Memo',
          placeholder: 'Optional note for this deposit…',
        ),
        const ActionRow(primary: 'Create Deposit'),
      ]),
    );
  }
}
