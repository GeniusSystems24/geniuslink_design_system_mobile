part of 'banking_transfer_screens.dart';

class ExternalTransferDetailScreen extends StatelessWidget {
  const ExternalTransferDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var trailing = const Pill('Pending', tone: PillTone.warning);
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('External Wire Detail')),
      body: MScroll([
        SuperSectionCard2(
          trailing: trailing,
          title: 'External Wire',
          
          initiallyExpanded: true,
          accentColor: accentColor2,
          
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'EXT-2024-0311 · Dec 18, 2025',
                style: TextStyle(
                  fontFamily: SuperMaterialThemeData.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                  fontSize: 12,
                  color: SuperMaterialThemeData.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          
          title: 'Amount & FX',
          
          initiallyExpanded: true,
          accentColor: accentColor3,
          
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '−11,000.00 ',
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: SuperMaterialThemeData.of(
                        context,
                      ).colorScheme.error,
                    ),
                  ),
                  Text(
                    'USD',
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 12,
                      color: SuperMaterialThemeData.of(context).superTheme.fg3,
                    ),
                  ),
                ],
              ),
              FxTiles(
                tiles: [
                  ('Rate', '3.7500', 'USD → SAR', null),
                  (
                    'Debited',
                    '41,250.00',
                    'SAR',
                    SuperMaterialThemeData.of(context).superTheme.fg1,
                  ),
                  (
                    'Fee',
                    '75.00',
                    'SAR',
                    SuperMaterialThemeData.of(context).colorScheme.tertiary,
                  ),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          
          title: 'Beneficiary',
          
          initiallyExpanded: true,
          accentColor: accentColor,
          
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              BKV('Name', 'Global Steel Imports'),
              BKV('IBAN', 'DE89 3704 0044 0532 0130 00', mono: true),
              BKV('SWIFT', 'COBADEFFXXX', mono: true),
              BKV('Purpose', 'GSD — Goods'),
            ],
          ),
        ),
        BankNote(
          'Awaiting controller approval. Funds are reserved until the wire is released or cancelled.',
          tone: SuperMaterialThemeData.of(context).colorScheme.tertiary,
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
