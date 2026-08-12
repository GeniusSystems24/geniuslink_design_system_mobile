part of 'ledger_screens.dart';

class OpDetailScreen extends StatelessWidget {
  const OpDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const lines = [
      ('1200 — Inventory (WIP)', '+5,400.00', true, 'Debit'),
      ('5001 — Cost of Goods Sold', '+1,200.00', true, 'Debit'),
      ('1100 — Bank · NCB Main', '−6,600.00', false, 'Credit'),
    ];
    var trailing = const Pill('Posted');
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Financial Operation')),
      body: MScroll([
        SuperSectionCard2(
          trailing: trailing,
          title: 'Operation Summary',
          subtitle: (null),
          initiallyExpanded: true,
          accentColor: accentColor,
          icon: null,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'OP-2024-0883',
                style: TextStyle(
                  fontFamily: SuperMaterialThemeData.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                  fontSize: 12,
                  color: SuperMaterialThemeData.of(context).colorScheme.primary,
                ),
              ),
              const Row(
                children: [
                  Expanded(
                    child: Mini(
                      label: 'Total Debits',
                      value: '6,600.00',
                      sub: 'SAR',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Mini(
                      label: 'Difference',
                      value: '0.00',
                      sub: 'SAR',
                      hi: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          trailing: (null),
          title: 'Ledger Lines',
          subtitle: (null),
          initiallyExpanded: true,
          accentColor: accentColor3,
          icon: null,
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    for (int i = 0; i < lines.length; i++)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: i == lines.length - 1
                              ? null
                              : Border(
                                  bottom: BorderSide(
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).superTheme.border,
                                  ),
                                ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lines[i].$1,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: SuperMaterialThemeData.of(
                                        context,
                                      ).superTheme.fg1,
                                      fontFamily: SuperMaterialThemeData.of(
                                        context,
                                      ).textTheme.bodyMedium?.fontFamily,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Pill(
                                    lines[i].$4,
                                    tone: lines[i].$4 == 'Debit'
                                        ? PillTone.info
                                        : PillTone.danger,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              lines[i].$2,
                              style: TextStyle(
                                fontFamily: SuperMaterialThemeData.of(
                                  context,
                                ).textTheme.bodyMedium?.fontFamily,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                                color: lines[i].$3
                                    ? SuperMaterialThemeData.of(
                                        context,
                                      ).colorScheme.secondary
                                    : SuperMaterialThemeData.of(
                                        context,
                                      ).colorScheme.error,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          trailing: (null),
          title: 'Audit',
          subtitle: (null),
          initiallyExpanded: true,
          accentColor: accentColor2,
          icon: null,
          padding: const EdgeInsets.all(16),
          child: AuditColumn(
            connectIndictors: true,
            items: [
              AuditItem(
                title: 'Operation created',
                doAt: DateTime(2025, 12, 18, 9, 21),
                doBy: 'Layla A.',
                indicatorColor: accentColor2,
              ),
              AuditItem(
                title: 'Submitted for review',
                doAt: DateTime(2025, 12, 18, 9, 24),
                doBy: 'Layla A.',
                indicatorColor: accentColor2,
              ),
              AuditItem(
                title: 'Approved & posted',
                doAt: DateTime(2025, 12, 18, 10, 5),
                doBy: 'Controller',
                indicatorColor: accentColor2,
              ),
            ],
          ),
        ),
        MBtn(
          'Back to Operations',
          variant: MBtnVariant.secondary,
          icon: 'back',
          full: true,
          onTap: () => context.goTo('more'),
        ),
      ]),
    );
  }
}
