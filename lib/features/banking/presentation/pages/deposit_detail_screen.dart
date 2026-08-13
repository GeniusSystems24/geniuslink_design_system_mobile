part of 'banking_cash_screens.dart';

class DepositDetailScreen extends StatelessWidget {
  const DepositDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.primary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Deposit Receipt')),
      body: MScroll([
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: superCoreTint(
              SuperMaterialThemeData.of(context).colorScheme.secondary,
              0x14,
            ),
            border: Border.all(
              color: superCoreTint(
                SuperMaterialThemeData.of(context).colorScheme.secondary,
                0x40,
              ),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Eyebrow(
                'Deposit Receipt · DEP-2024-0182',
                color: SuperMaterialThemeData.of(context).colorScheme.secondary,
                size: 10,
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '+120,000.00 ',
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: SuperMaterialThemeData.of(
                        context,
                      ).colorScheme.secondary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    'SAR',
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 13,
                      color: SuperMaterialThemeData.of(context).superTheme.fg3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: 'Details',

          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              BKV('Method', 'Cash'),
              BKV('Deposited To', 'Bank · NCB Main (1100)'),
              BKV('Value Date', 'Dec 19, 2025', mono: true),
              BKV('Reference', 'CTR-9920', mono: true),
              BKV('Status', 'Cleared'),
            ],
          ),
        ),
        SuperSectionCard2(
          title: 'Posted Journal',

          initiallyExpanded: true,
          accentColor: accentColor3,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              JournalPreview(
                rows: [
                  ('Bank · NCB Main (1100)', '120,000.00', null),
                  ('Cash Box (1001)', null, '120,000.00'),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: 'Audit',

          initiallyExpanded: true,
          accentColor: accentColor2,

          padding: EdgeInsets.all(16),
          child: AuditColumn(
            items: [
              AuditItem(
                title: 'Created',
                doAt: DateTime(2025, 12, 19, 9, 42),
                doBy: 'Layla Ahmed',
              ),
            ],
          ),
        ),
        MBtn(
          'Back',
          variant: MBtnVariant.secondary,
          icon: 'back',
          full: true,
          onTap: () => context.goTo('more'),
        ),
      ]),
    );
  }
}
