part of 'journal_screens.dart';

class CreateJournalEntryScreen extends StatelessWidget {
  final List<LedgerAccount> accounts;
  final List<JournalLine> initialLines;

  const CreateJournalEntryScreen({
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
      appBar: SuperAppBar(title: const Text('Create Journal Entry')),
      body: MScroll([
        SuperSectionCard2(
          trailing: (null),
          title: 'Entry Header',
          subtitle: (null),
          initiallyExpanded: true,
          accentColor: accentColor2,
          icon: icon2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              IField(
                label: 'Serial No',
                value: 'JV-2024-0227',
                mono: true,
                locked: true,
              ),
              IField(label: 'Date', value: 'Dec 19, 2025', icon: 'calendar'),
              IField(
                label: 'Currency',
                value: 'SAR — Saudi Riyal',
                select: true,
              ),
              ITextarea(
                label: 'Description',
                placeholder: 'Describe this journal entry…',
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          trailing: (null),
          title: 'Journal Lines',
          subtitle: '${lines.length} lines',
          initiallyExpanded: true,
          accentColor: accentColor,
          icon: icon,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final line in lines)
                JournalLineEditor(line: line, accounts: accounts),
              const AddLineBtn(),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: SuperMaterialThemeData.of(context).superTheme.bg,
                  border: Border.all(
                    color: SuperMaterialThemeData.of(context).superTheme.border,
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
                              .where((line) => line.side == JournalSide.credit)
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
            ],
          ),
        ),
        const ActionRow(primary: 'Post Entry'),
      ]),
    );
  }
}
