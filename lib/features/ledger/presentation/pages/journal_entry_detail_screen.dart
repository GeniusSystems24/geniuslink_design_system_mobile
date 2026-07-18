
part of 'journal_screens.dart';

class JournalEntryDetailScreen extends StatelessWidget {
  final JournalEntrySummary entry;

  const JournalEntryDetailScreen({required this.entry, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Journal Entry Detail'),
      body: MScroll([
        MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Journal Entry', trailing: Pill(entry.status == JournalEntryStatus.posted ? 'Posted' : 'Draft', tone: entry.status == JournalEntryStatus.posted ? PillTone.success : PillTone.warning), children: [
          Text('${entry.reference} · ${_dateLabel(entry.occurredAt)}', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).colorScheme.primary)),
          Text(entry.description, style: TextStyle(fontSize: 14, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
        ]),
        MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Lines', pad: 16, children: [
          JournalPreview(numbered: true, rows: [
            for (final line in entry.lines) ('${line.account.name} (${line.account.code})', line.side == JournalSide.debit ? SuperFormat.number(line.amount, decimals: 2) : null, line.side == JournalSide.credit ? SuperFormat.number(line.amount, decimals: 2) : null),
          ]),
        ]),
        MBtn('Back to Entries', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => context.goTo('journalList')),
      ]),
    );
  }

  String _dateLabel(DateTime value) => '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
}
