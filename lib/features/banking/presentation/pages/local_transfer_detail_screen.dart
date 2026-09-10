part of 'banking_transfer_screens.dart';

class LocalTransferDetailScreen extends StatelessWidget {
  const LocalTransferDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var trailing = Pill(GeniusLinkLocalization.of(context).posted);
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.primary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var accentColor4 = SuperMaterialThemeData.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Local Transfer Detail'), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
      body: MScroll([
        SuperSectionCard2(
          trailing: trailing,
          title: GeniusLinkLocalization.of(context).interAccountSettlement,

          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'TR-2024-9042 · Dec 18, 2025',
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
          title: 'Flow',

          initiallyExpanded: true,
          accentColor: accentColor4,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              FromToFlow(
                from: const FlowCardData(
                  label: 'From',
                  title: 'Bank · NCB Main',
                  subtitle: '1100',
                  meta: 'Balance after  ·  136,420.00',
                ),
                to: FlowCardData(
                  label: GeniusLinkLocalization.of(context).to,
                  title: 'Bank · Al Rajhi',
                  subtitle: '1101',
                  meta: 'Balance after  ·  56,240.00',
                  metaColor: SuperMaterialThemeData.of(
                    context,
                  ).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).amount,

          initiallyExpanded: true,
          accentColor: accentColor2,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Eyebrow(
                    GeniusLinkLocalization.of(context).transferred,
                    color: SuperMaterialThemeData.of(context).superTheme.fg3,
                    size: 11,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '50,000.00 ',
                          style: TextStyle(
                            fontFamily: SuperMaterialThemeData.of(
                              context,
                            ).textTheme.bodyMedium?.fontFamily,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: SuperMaterialThemeData.of(
                              context,
                            ).superTheme.fg1,
                          ),
                        ),
                        TextSpan(
                          text: 'SAR',
                          style: TextStyle(
                            fontFamily: SuperMaterialThemeData.of(
                              context,
                            ).textTheme.bodyMedium?.fontFamily,
                            fontSize: 12,
                            color: SuperMaterialThemeData.of(
                              context,
                            ).superTheme.fg3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).audit,

          initiallyExpanded: true,
          accentColor: accentColor3,

          padding: EdgeInsets.all(16),
          child: AuditColumn(
            items: [
              AuditItem(
                title: 'Created',
                doAt: DateTime(2025, 12, 18, 14, 2),
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
