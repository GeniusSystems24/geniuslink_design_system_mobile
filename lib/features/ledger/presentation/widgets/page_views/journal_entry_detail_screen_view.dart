part of '../../pages/journal_screens.dart';

// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py

/// Renders the presentation for [JournalEntryDetailScreen].
///
/// This widget contains the screen's existing layout and presentation
/// state while the corresponding `*Screen` file remains a small public
/// navigation/compatibility boundary. Business and data-layer behavior
/// is intentionally not introduced by this refactor.
///
/// Example:
///
/// ```dart
/// JournalEntryDetailView(
///   entry: entry,
/// )
/// ```
class JournalEntryDetailView extends StatelessWidget {
  final JournalEntrySummary entry;

  const JournalEntryDetailView({required this.entry, super.key});

  @override
  Widget build(BuildContext context) {
    var trailing = Pill(
      entry.status == JournalEntryStatus.posted ? 'Posted' : 'Draft',
      tone: entry.status == JournalEntryStatus.posted
          ? PillTone.success
          : PillTone.warning,
    );
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(
        title: Text(GeniusLinkLocalization.of(context).journalEntryDetail),
        actions: const [AppLanguageToggleButton(), AppThemeToggleButton()],
      ),
      body: MScroll([
        SuperSectionCard2(
          trailing: trailing,
          title: GeniusLinkLocalization.of(context).journalEntry,

          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(16),
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 12,
                large: 12,
                child: Text(
                  '${entry.reference} · ${_dateLabel(entry.occurredAt)}',
                  style: TextStyle(
                    fontFamily: SuperMaterialThemeData.of(
                      context,
                    ).textTheme.bodyMedium?.fontFamily,
                    fontSize: 12,
                    color: SuperMaterialThemeData.of(
                      context,
                    ).colorScheme.primary,
                  ),
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 12,
                large: 12,
                child: Text(
                  entry.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: SuperMaterialThemeData.of(context).superTheme.fg1,
                    fontFamily: SuperMaterialThemeData.of(
                      context,
                    ).textTheme.bodyMedium?.fontFamily,
                  ),
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).lines,

          initiallyExpanded: true,
          accentColor: accentColor2,

          padding: EdgeInsets.all(16),
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 12,
                large: 12,
                child: JournalPreview(
                  numbered: true,
                  rows: [
                    for (final line in entry.lines)
                      (
                        '${line.account.name} (${line.account.code})',
                        line.side == JournalSide.debit
                            ? SuperFormat.number(line.amount, decimals: 2)
                            : null,
                        line.side == JournalSide.credit
                            ? SuperFormat.number(line.amount, decimals: 2)
                            : null,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        MBtn(
          GeniusLinkLocalization.of(context).backToEntries,
          variant: MBtnVariant.secondary,
          icon: 'back',
          full: true,
          onTap: () => context.goTo('journalList'),
        ),
      ]),
    );
  }

  String _dateLabel(DateTime value) =>
      '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
}
