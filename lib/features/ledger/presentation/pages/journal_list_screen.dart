
part of 'journal_screens.dart';

class JournalListScreen extends StatefulWidget {
  final List<JournalEntrySummary> entries;
  final ValueChanged<JournalEntrySummary>? onEntrySelected;

  const JournalListScreen({required this.entries, this.onEntrySelected, super.key});

  @override
  State<JournalListScreen> createState() => _JournalListScreenState();
}

class _JournalListScreenState extends State<JournalListScreen> {
  String _query = '';
  JournalEntryStatus? _filter;

  @override
  Widget build(BuildContext context) {
    final query = _query.trim().toLowerCase();
    final rows = widget.entries.where((entry) {
      final matchesQuery = query.isEmpty || '${entry.reference} ${entry.description}'.toLowerCase().contains(query);
      return matchesQuery && (_filter == null || entry.status == _filter);
    }).toList();
    final filterLabel = _filter == null ? 'All' : _statusLabel(_filter!);
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Journal Entries')),
      body: MScroll([
        SearchInput(placeholder: 'Search entries…', value: _query, onChange: (value) => setState(() => _query = value)),
        Segmented(options: const ['All', 'Posted', 'Draft'], value: filterLabel, onChange: (value) => setState(() => _filter = switch (value) { 'Posted' => JournalEntryStatus.posted, 'Draft' => JournalEntryStatus.draft, _ => null })),
        SuperSectionCard2(
      trailing: (null),
      title: "",
      subtitle: (null),
      initiallyExpanded: true,
      accentColor: (null),
      icon: null,
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
            for (int i = 0; i < rows.length; i++)
              GestureDetector(
                onTap: () {
                  final callback = widget.onEntrySelected;
                  if (callback != null) {
                    callback(rows[i]);
                  } else {
                    context.goTo('journalEntryDetail');
                  }
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  decoration: BoxDecoration(border: i == rows.length - 1 ? null : Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
                  child: Row(children: [
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [Text(rows[i].reference, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).colorScheme.primary)), const SizedBox(width: 8), Pill(_statusLabel(rows[i].status), tone: rows[i].status == JournalEntryStatus.posted ? PillTone.success : PillTone.warning)]),
                      const SizedBox(height: 4),
                      Text(rows[i].description, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, color: SuperMaterialThemeData.of(context).superTheme.fg2, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                    ])),
                    const SizedBox(width: 10),
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Text(SuperFormat.number(rows[i].amount, decimals: 2), style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
                      const SizedBox(height: 2),
                      Text(_dateLabel(rows[i].occurredAt), style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10.5, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                    ]),
                  ]),
                ),
              ),
            if (rows.isEmpty) Padding(padding: const EdgeInsets.symmetric(vertical: 28), child: Center(child: Text('No entries match.', style: TextStyle(color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)))),
          ],
      ),
    ),
      ]),
    );
  }

  String _statusLabel(JournalEntryStatus status) => status == JournalEntryStatus.posted ? 'Posted' : 'Draft';
  String _dateLabel(DateTime value) => '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
}
