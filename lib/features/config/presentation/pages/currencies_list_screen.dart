part of 'currencies_screens.dart';

class CurrenciesListScreen extends StatelessWidget {
  final List<CurrencyDefinition> currencies;
  final ValueChanged<CurrencyDefinition>? onCurrencySelected;

  const CurrenciesListScreen({
    required this.currencies,
    this.onCurrencySelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Currencies')),
      body: MScroll([
        SuperSectionCard2(
          title: "",

          initiallyExpanded: true,
          accentColor: (null),

          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < currencies.length; i++)
                GestureDetector(
                  onTap: () {
                    final callback = onCurrencySelected;
                    if (callback != null) {
                      callback(currencies[i]);
                    } else {
                      context.goTo('currencyDetail');
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 13,
                    ),
                    decoration: BoxDecoration(
                      border: i < currencies.length - 1
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
                        Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: SuperMaterialThemeData.of(
                              context,
                            ).superTheme.inputBg,
                            border: Border.all(
                              color: SuperMaterialThemeData.of(
                                context,
                              ).superTheme.border,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            currencies[i].symbol,
                            style: TextStyle(
                              fontSize: 18,
                              color: SuperMaterialThemeData.of(
                                context,
                              ).superTheme.fg1,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    currencies[i].code,
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
                                  if (currencies[i].isBase)
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
                              const SizedBox(height: 2),
                              Text(
                                currencies[i].name,
                                style: TextStyle(
                                  fontSize: 12.5,
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
                            Text(
                              currencies[i].exchangeRate.toStringAsFixed(6),
                              style: TextStyle(
                                fontFamily: SuperMaterialThemeData.of(
                                  context,
                                ).textTheme.bodyMedium?.fontFamily,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: SuperMaterialThemeData.of(
                                  context,
                                ).superTheme.fg1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Pill(
                              currencies[i].status.name,
                              tone:
                                  currencies[i].status == CurrencyStatus.active
                                  ? PillTone.success
                                  : PillTone.neutral,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ]),
    );
  }
}
