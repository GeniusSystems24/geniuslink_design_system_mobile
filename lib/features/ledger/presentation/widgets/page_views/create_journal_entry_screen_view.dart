part of '../../pages/journal_screens.dart';

// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py

/// Renders the presentation for [CreateJournalEntryScreen].
///
/// This widget contains the screen's existing layout and presentation
/// state while the corresponding `*Screen` file remains a small public
/// navigation/compatibility boundary. Business and data-layer behavior
/// is intentionally not introduced by this refactor.
///
/// Example:
///
/// ```dart
/// CreateJournalEntryView(
///   accounts: accounts,
/// )
/// ```
class CreateJournalEntryView extends StatelessWidget {
  final List<LedgerAccount> accounts;
  final List<JournalLine> initialLines;

  const CreateJournalEntryView({
    required this.accounts,
    this.initialLines = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final lines = initialLines.isNotEmpty
        ? initialLines
        : <JournalLine>[
            JournalLine(
              account: accounts.first,
              side: JournalSide.debit,
              amount: 6600,
            ),
            JournalLine(
              account: accounts.length > 9 ? accounts[9] : accounts.last,
              side: JournalSide.credit,
              amount: 6600,
            ),
          ];
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var icon = MIcons.of('ledger');
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon2 = MIcons.of('doc');
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(
        title: Text(GeniusLinkLocalization.of(context).createJournalEntry),
        actions: const [AppLanguageToggleButton(), AppThemeToggleButton()],
      ),
      body: MScroll([
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).entryHeader,

          initiallyExpanded: true,
          accentColor: accentColor2,
          icon: icon2,
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: IField(
                  label: GeniusLinkLocalization.of(context).serialNo,
                  value: 'JV-2024-0227',
                  mono: true,
                  locked: true,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: IField(
                  label: GeniusLinkLocalization.of(context).date,
                  value: 'Dec 19, 2025',
                  icon: 'calendar',
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: IField(
                  label: GeniusLinkLocalization.of(context).currency,
                  value: 'SAR — Saudi Riyal',
                  select: true,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 6,
                large: 6,
                child: ITextarea(
                  label: GeniusLinkLocalization.of(context).description,
                  placeholder: GeniusLinkLocalization.of(
                    context,
                  ).describeThisJournalEntry,
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).journalLines,
          subtitle: '${lines.length} lines',
          initiallyExpanded: true,
          accentColor: accentColor,
          icon: icon,
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              for (final line in lines)
                SuperGridCell(
                  mobile: 4,
                  tablet: 8,
                  desktop: 12,
                  large: 12,
                  child: JournalLineEditor(line: line, accounts: accounts),
                ),
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 12,
                large: 12,
                child: const AddLineBtn(),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 12,
                large: 12,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: SuperMaterialThemeData.of(context).superTheme.bg,
                    border: Border.all(
                      color: SuperMaterialThemeData.of(
                        context,
                      ).superTheme.border,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: JournalTotal(
                          'Debits',
                          SuperFormat.number(
                            lines
                                .where((line) => line.side == JournalSide.debit)
                                .fold<double>(
                                  0,
                                  (sum, line) => sum + line.amount,
                                ),
                            decimals: 2,
                          ),
                          SuperMaterialThemeData.of(context).superTheme.fg1,
                        ),
                      ),
                      Expanded(
                        child: JournalTotal(
                          'Credits',
                          SuperFormat.number(
                            lines
                                .where(
                                  (line) => line.side == JournalSide.credit,
                                )
                                .fold<double>(
                                  0,
                                  (sum, line) => sum + line.amount,
                                ),
                            decimals: 2,
                          ),
                          SuperMaterialThemeData.of(context).superTheme.fg1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const ActionRow(primary: 'Post Entry'),
      ]),
    );
  }
}
