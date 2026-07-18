part of 'currencies_screens.dart';

class CurrencyDetailScreen extends StatelessWidget {
  const CurrencyDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const history = [('Dec 18, 2025', '3.750200', 'System · ECB feed'), ('Dec 11, 2025', '3.751400', 'System · ECB feed'), ('Dec 04, 2025', '3.749800', 'Layla A. (manual)'), ('Nov 27, 2025', '3.752100', 'System · ECB feed')];
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Currency Detail'),
      body: MScroll([
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Current Rate', subtitle: 'Per 1 SAR · updated Dec 18, 2025', trailing: Pill('Active'), children: [
        Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Text('USD', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 14, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
          SizedBox(width: 10),
          Text('3.750200', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 34, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).superTheme.fg1, letterSpacing: -0.6)),
          SizedBox(width: 8),
          Text('▲ 0.03%', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).colorScheme.secondary)),
        ]),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Definition', children: [
        KV('ISO Code', 'USD', mono: true), KV('Symbol', '\$'),
        KV('Name English', 'US Dollar'), KV('Name Arabic', 'دولار أمريكي', ar: true),
        KV('Decimal Places', '2', mono: true), KV('Source', 'ECB Daily Feed'),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.tertiary, title: 'Rate History', subtitle: 'Last 4 updates', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < history.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i < history.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                child: Row(children: [
                  SizedBox(width: 92, child: Text(history[i].$1, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg2))),
                  Expanded(child: Text(history[i].$2, textAlign: TextAlign.right, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1))),
                  const SizedBox(width: 12),
                  SizedBox(width: 96, child: Text(history[i].$3, textAlign: TextAlign.right, style: TextStyle(fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily))),
                ]),
              ),
          ]),
        ),
      ]),
      MBtn('Back to List', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => context.goTo('currenciesList')),
    ]),
    );
  }
}
