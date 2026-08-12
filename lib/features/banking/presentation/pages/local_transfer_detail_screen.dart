part of 'banking_transfer_screens.dart';

class LocalTransferDetailScreen extends StatelessWidget {
  const LocalTransferDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var trailing = const Pill('Posted');
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.primary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var accentColor4 = SuperMaterialThemeData.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Local Transfer Detail')),
      body: MScroll([
        SuperSectionCard2(
          trailing: trailing,
          title: 'Inter-Account Settlement',
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
          trailing: (null),
          title: 'Flow',
          subtitle: (null),
          initiallyExpanded: true,
          accentColor: accentColor4,
          icon: null,
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
                  label: 'To',
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
          trailing: (null),
          title: 'Amount',
          subtitle: (null),
          initiallyExpanded: true,
          accentColor: accentColor2,
          icon: null,
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
                    'Transferred',
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
          trailing: (null),
          title: 'Audit',
          subtitle: (null),
          initiallyExpanded: true,
          accentColor: accentColor3,
          icon: null,
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
