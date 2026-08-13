part of 'currencies_screens.dart';

class ExchangeRateSetupScreen extends StatelessWidget {
  const ExchangeRateSetupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const pairs = [
      ('USD', 'US Dollar', '3.750200', '3.751400', true),
      ('EUR', 'Euro', '4.082100', '4.079800', true),
      ('GBP', 'British Pound', '4.761000', '4.758200', true),
      ('AED', 'UAE Dirham', '1.020800', '1.020800', false),
      ('KWD', 'Kuwaiti Dinar', '12.18000', '12.17200', false),
    ];
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.primary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Exchange Rates')),
      body: MScroll([
        SuperSectionCard2(
          
          title: 'Base Currency',
          
          initiallyExpanded: true,
          accentColor: accentColor,
          
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'SAR',
                        style: TextStyle(
                          fontFamily: SuperMaterialThemeData.of(
                            context,
                          ).textTheme.bodyMedium?.fontFamily,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: SuperMaterialThemeData.of(
                            context,
                          ).superTheme.fg1,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 7),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: superCoreTint(
                            SuperMaterialThemeData.of(
                              context,
                            ).colorScheme.primary,
                            0x24,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'BASE',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.6,
                            color: SuperMaterialThemeData.of(
                              context,
                            ).colorScheme.primary,
                            fontFamily: SuperMaterialThemeData.of(
                              context,
                            ).textTheme.bodyMedium?.fontFamily,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Effective Dec 18, 2025',
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 11,
                      color: SuperMaterialThemeData.of(context).superTheme.fg3,
                    ),
                  ),
                ],
              ),
              const MBtn(
                'Pull ECB Feed',
                variant: MBtnVariant.secondary,
                icon: 'download',
                full: true,
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          
          title: 'Rates per 1 SAR',
          subtitle: 'Auto-fed pairs sync daily; manual pairs are editable',
          initiallyExpanded: true,
          accentColor: accentColor2,
          
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    for (int i = 0; i < pairs.length; i++)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: i < pairs.length - 1
                              ? Border(
                                  bottom: BorderSide(
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).superTheme.border,
                                  ),
                                )
                              : null,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        pairs[i].$1,
                                        style: TextStyle(
                                          fontFamily: SuperMaterialThemeData.of(
                                            context,
                                          ).textTheme.bodyMedium?.fontFamily,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: SuperMaterialThemeData.of(
                                            context,
                                          ).superTheme.fg1,
                                        ),
                                      ),
                                      const SizedBox(width: 7),
                                      Pill(
                                        pairs[i].$5 ? 'Auto' : 'Manual',
                                        tone: pairs[i].$5
                                            ? PillTone.info
                                            : PillTone.neutral,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    pairs[i].$2,
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      color: SuperMaterialThemeData.of(
                                        context,
                                      ).superTheme.fg3,
                                      fontFamily: SuperMaterialThemeData.of(
                                        context,
                                      ).textTheme.bodyMedium?.fontFamily,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: pairs[i].$5
                                      ? EdgeInsets.zero
                                      : const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                  decoration: pairs[i].$5
                                      ? null
                                      : BoxDecoration(
                                          color: SuperMaterialThemeData.of(
                                            context,
                                          ).superTheme.inputBg,
                                          border: Border.all(
                                            color: SuperMaterialThemeData.of(
                                              context,
                                            ).superTheme.borderStrong,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                  child: Text(
                                    pairs[i].$3,
                                    style: TextStyle(
                                      fontFamily: SuperMaterialThemeData.of(
                                        context,
                                      ).textTheme.bodyMedium?.fontFamily,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: SuperMaterialThemeData.of(
                                        context,
                                      ).superTheme.fg1,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'prev ${pairs[i].$4}',
                                  style: TextStyle(
                                    fontFamily: SuperMaterialThemeData.of(
                                      context,
                                    ).textTheme.bodyMedium?.fontFamily,
                                    fontSize: 10,
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).superTheme.fg3,
                                  ),
                                ),
                              ],
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
        const ActionRow(primary: 'Save Rates'),
      ]),
    );
  }
}
