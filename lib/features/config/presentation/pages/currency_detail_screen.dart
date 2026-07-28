
part of 'currencies_screens.dart';

class CurrencyDetailScreen extends StatelessWidget {
  final CurrencyDefinition currency;

  const CurrencyDetailScreen({required this.currency, super.key});

  @override
  Widget build(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var trailing = Pill(currency.status.name, tone: currency.status == CurrencyStatus.active ? PillTone.success : PillTone.neutral);
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Currency Detail')),
      body: MScroll([
        SuperSectionCard2(
      trailing: trailing,
      title: 'Current Rate',
      subtitle: 'Per 1 base currency',
      initiallyExpanded: true,
      accentColor: accentColor3,
      icon: null,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
              Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
                Text(currency.code, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 14, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                const SizedBox(width: 10),
                Text(currency.exchangeRate.toStringAsFixed(6), style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 34, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).superTheme.fg1, letterSpacing: -0.6)),
              ]),
            ],
      ),
    ),
        SuperSectionCard2(
      trailing: (null),
      title: 'Definition',
      subtitle: (null),
      initiallyExpanded: true,
      accentColor: accentColor2,
      icon: null,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
            KV('ISO Code', currency.code, mono: true),
            KV('Symbol', currency.symbol),
            KV('Name English', currency.name),
            if (currency.localizedName case final localizedName?) KV('Localized Name', localizedName, ar: true),
            KV('Decimal Places', '${currency.decimalPlaces}', mono: true),
            KV('Source', currency.source),
          ],
      ),
    ),
        SuperSectionCard2(
      trailing: (null),
      title: 'Rate History',
      subtitle: 'Recent updates',
      initiallyExpanded: true,
      accentColor: accentColor,
      icon: null,
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(children: [
                for (int i = 0; i < currency.rateHistory.length; i++)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(border: i < currency.rateHistory.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                    child: Row(children: [
                      SizedBox(width: 92, child: Text(_formatDate(currency.rateHistory[i].effectiveAt), style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg2))),
                      Expanded(child: Text(currency.rateHistory[i].rate.toStringAsFixed(6), textAlign: TextAlign.right, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1))),
                      const SizedBox(width: 12),
                      SizedBox(width: 112, child: Text(currency.rateHistory[i].source, textAlign: TextAlign.right, style: TextStyle(fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily))),
                    ]),
                  ),
                if (currency.rateHistory.isEmpty) Padding(padding: const EdgeInsets.all(16), child: Text('No rate history available.', style: TextStyle(color: SuperMaterialThemeData.of(context).superTheme.fg3))),
              ]),
            ),
          ],
      ),
    ),
        MBtn('Back to List', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => context.goTo('currenciesList')),
      ]),
    );
  }

  String _formatDate(DateTime value) => '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
}
