part of 'journal_screens.dart';

class JournalListScreen extends StatefulWidget {
  const JournalListScreen({super.key});
  @override
  State<JournalListScreen> createState() => _JournalListScreenState();
}

class _JournalListScreenState extends State<JournalListScreen> {
  String _q = '';
  String _filter = 'All';

  @override
  Widget build(BuildContext context) {
    final ql = _q.trim().toLowerCase();
    final rows = _entries.where((e) {
      final hit = ql.isEmpty || '${e.$1} ${e.$2}'.toLowerCase().contains(ql);
      final fil = _filter == 'All' || e.$4 == _filter;
      return hit && fil;
    }).toList();

    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Journal Entries'),
      body: MScroll([
      SearchInput(placeholder: 'Search entries…', value: _q, onChange: (v) => setState(() => _q = v)),
      Segmented(options: const ['All', 'Posted', 'Draft'], value: _filter, onChange: (v) => setState(() => _filter = v)),
      MCard(pad: 8, children: [
        for (int i = 0; i < rows.length; i++)
          GestureDetector(
            onTap: () => context.goTo('journalEntryDetail'),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              decoration: BoxDecoration(border: i == rows.length - 1 ? null : Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
              child: Row(children: [
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Text(rows[i].$1, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).colorScheme.primary)),
                      const SizedBox(width: 8),
                      Pill(rows[i].$4, tone: rows[i].$4 == 'Posted' ? PillTone.success : PillTone.warning),
                    ]),
                    const SizedBox(height: 4),
                    Text(rows[i].$2, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, color: SuperMaterialThemeData.of(context).superTheme.fg2, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                  ]),
                ),
                const SizedBox(width: 10),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(rows[i].$3, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
                  const SizedBox(height: 2),
                  Text(rows[i].$5, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10.5, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                ]),
              ]),
            ),
          ),
        if (rows.isEmpty) Padding(padding: EdgeInsets.symmetric(vertical: 28), child: Center(child: Text('No entries match.', style: TextStyle(color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)))),
      ]),
    ]),
    );
  }
}
