part of 'banking_cash_screens.dart';

class CreateDepositScreen extends StatelessWidget {
  const CreateDepositScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Create Deposit')),
      body: MScroll([
      ISection(icon: 'download', title: 'Deposit Amount', accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, children: [
        MMoney(label: 'Amount', value: '120,000.00', accent: SuperMaterialThemeData.of(context).colorScheme.secondary, required: true, sign: '+'),
        const MMethod(value: 'cash'),
      ]),
      ISection(icon: 'card', title: 'Destination', accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, children: const [
        IField(label: 'Deposit To', value: 'Bank · NCB Main (1100)', select: true, required: true),
        IField(label: 'Reference', placeholder: 'e.g. Counter slip no.'),
        IField(label: 'Value Date', value: 'Dec 19, 2025', icon: 'calendar'),
      ]),
      ISection(icon: 'ledger', title: 'Journal Preview', accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, defaultOpen: false, children: const [
        JournalPreview(rows: [
          ('Bank · NCB Main (1100)', '120,000.00', null),
          ('Cash Box (1001)', null, '120,000.00'),
        ]),
      ]),
      const ITextarea(label: 'Memo', placeholder: 'Optional note for this deposit…'),
      const ActionRow(primary: 'Create Deposit'),
    ]),
    );
  }
}
