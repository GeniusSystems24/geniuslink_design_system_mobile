part of 'banking_transfer_screens.dart';

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
      ISection(icon: 'building', title: 'Accounts', accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, children: const [
        IField(label: 'From Account', value: 'Bank · NCB Main (1100)', select: true, required: true),
        IField(label: 'To Account', value: 'Bank · Al Rajhi (1101)', select: true, required: true),
        IField(label: 'Value Date', value: 'Dec 19, 2025', icon: 'calendar'),
        IField(label: 'Reference', placeholder: 'Internal note / slip no.'),
      ]),
      ISection(icon: 'ledger', title: 'Journal Preview', accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, defaultOpen: false, children: const [
        JournalPreview(rows: [
          ('Bank · Al Rajhi (1101)', '50,000.00', null),
          ('Bank · NCB Main (1100)', null, '50,000.00'),
        ]),
      ]),
      const ActionRow(primary: 'Create Transfer'),
    ]),
    );
  }
}
