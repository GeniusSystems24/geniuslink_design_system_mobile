
part of 'journal_screens.dart';

class JournalEntryDetailScreen extends StatelessWidget {
  final JournalEntrySummary entry;

  const JournalEntryDetailScreen({required this.entry, super.key});

  @override
  Widget build(BuildContext context) {
    var trailing = Pill(entry.status == JournalEntryStatus.posted ? 'Posted' : 'Draft', tone: entry.status == JournalEntryStatus.posted ? PillTone.success : PillTone.warning);
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Journal Entry Detail')),
      body: MScroll([
        SuperSectionCard2(
      trailing: trailing,
      title: 'Journal Entry' ?? "",
      subtitle: (null),
      initiallyExpanded: true,
      accentColor: accentColor,
      icon: null,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
            Text('${entry.reference} · ${_dateLabel(entry.occurredAt)}', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).colorScheme.primary)),
            Text(entry.description, style: TextStyle(fontSize: 14, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
          ],
      ),
    ),
        SuperSectionCard2(
      trailing: (null),
      title: 'Lines' ?? "",
      subtitle: (null),
      initiallyExpanded: true,
      accentColor: accentColor2,
      icon: null,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
            JournalPreview(numbered: true, rows: [
              for (final line in entry.lines) ('${line.account.name} (${line.account.code})', line.side == JournalSide.debit ? SuperFormat.number(line.amount, decimals: 2) : null, line.side == JournalSide.credit ? SuperFormat.number(line.amount, decimals: 2) : null),
            ]),
          ],
      ),
    ),
        MBtn('Back to Entries', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => context.goTo('journalList')),
      ]),
    );
  }

  String _dateLabel(DateTime value) => '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
}
