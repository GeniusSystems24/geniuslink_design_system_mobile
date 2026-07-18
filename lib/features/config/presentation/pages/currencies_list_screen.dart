part of 'currencies_screens.dart';

class CurrenciesListScreen extends StatelessWidget {
  const CurrenciesListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Currencies'),
      body: MScroll([
      MCard(pad: 8, children: [
        for (int i = 0; i < _currencies.length; i++)
          GestureDetector(
            onTap: () => context.goTo('currencyDetail'),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
              decoration: BoxDecoration(border: i < _currencies.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
              child: Row(children: [
                Container(width: 40, height: 40, alignment: Alignment.center, decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.inputBg, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(10)), child: Text(_currencies[i].$3, style: TextStyle(fontSize: 18, color: SuperMaterialThemeData.of(context).superTheme.fg1))),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Text(_currencies[i].$1, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
                    if (_currencies[i].$5) Container(margin: const EdgeInsets.only(left: 7), padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2), decoration: BoxDecoration(color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.primary, 0x24), borderRadius: BorderRadius.circular(4)), child: Text('BASE', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w700, letterSpacing: 0.6, color: SuperMaterialThemeData.of(context).colorScheme.primary, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily))),
                  ]),
                  const SizedBox(height: 2),
                  Text(_currencies[i].$2, style: TextStyle(fontSize: 12.5, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                ])),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(_currencies[i].$4, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
                  const SizedBox(height: 4),
                  Pill(_currencies[i].$6, tone: _currencies[i].$6 == 'active' ? PillTone.success : PillTone.neutral),
                ]),
              ]),
            ),
          ),
      ]),
    ]),
    );
  }
}
