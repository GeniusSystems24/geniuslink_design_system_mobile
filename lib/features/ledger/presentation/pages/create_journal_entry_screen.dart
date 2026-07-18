part of 'journal_screens.dart';

class CreateJournalEntryScreen extends StatelessWidget {
  const CreateJournalEntryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Create Journal Entry'),
      body: MScroll([
      ISection(icon: 'doc', title: 'Entry Header', accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, children: [
        IField(label: 'Serial No', value: 'JV-2024-0227', mono: true, locked: true),
        IField(label: 'Date', value: 'Dec 19, 2025', icon: 'calendar'),
        IField(label: 'Currency', value: 'SAR — Saudi Riyal', select: true),
        ITextarea(label: 'Description', placeholder: 'Describe this journal entry…'),
      ]),
      ISection(icon: 'ledger', title: 'Journal Lines', accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, sub: '2 lines · balanced', children: [
        const JournalLineEditor(account: 'Bank · NCB Main (1100)', side: 'Debit', amount: '6,600.00'),
        const JournalLineEditor(account: 'Sales Revenue (4001)', side: 'Credit', amount: '6,600.00'),
        const AddLineBtn(),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.bg, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(8)),
          child: Row(children: [
            Expanded(child: JournalTotal('Debits', '6,600.00', SuperMaterialThemeData.of(context).superTheme.fg1)),
            Expanded(child: JournalTotal('Credits', '6,600.00', SuperMaterialThemeData.of(context).superTheme.fg1)),
            Expanded(child: JournalTotal('Diff', '0.00', SuperMaterialThemeData.of(context).colorScheme.secondary)),
          ]),
        ),
      ]),
      const ActionRow(primary: 'Post Entry'),
    ]),
    );
  }
}
