part of 'journal_screens.dart';

class JournalEntryDetailScreen extends StatelessWidget {
  const JournalEntryDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Journal Entry Detail'),
      body: MScroll([
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Journal Entry', trailing: Pill('Posted'), children: [
        Text('JV-2024-0226 · Dec 18, 2025', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).colorScheme.primary)),
        Text('Mixed sale & revenue recognition', style: TextStyle(fontSize: 14, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Lines', pad: 16, children: [
        JournalPreview(numbered: true, rows: [
          ('Bank · NCB Main (1100)', '6,600.00', null),
          ('Sales Revenue (4001)', null, '6,000.00'),
          ('VAT Payable (2100)', null, '600.00'),
        ]),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Audit', children: [
        AuditGrid(rows: [
          ('Created By', 'Layla Ahmed', false),
          ('Created At', 'Dec 18, 09:21', true),
          ('Posted By', 'Controller', false),
          ('Reference', 'INV-S-2291', true),
        ]),
      ]),
      MBtn('Back to Entries', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => context.goTo('journalList')),
    ]),
    );
  }
}
