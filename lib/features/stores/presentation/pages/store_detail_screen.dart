part of 'stores_screens.dart';

class StoreDetailScreen extends StatelessWidget {
  const StoreDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const items = [
      ('STL-44021', 'Steel I-Beam', '142', 'in'),
      ('AGG-21044', 'Aggregate 20mm', '46', 'low'),
      ('RBR-71203', 'Rebar #6', '0', 'out'),
    ];
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Store Detail'),
      body: MScroll([
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Store Summary', trailing: const Pill('Active'), children: const [
        Row(children: [
          Expanded(child: Mini(label: 'Stock Value', value: '342,820', sub: 'SAR', hi: true)),
          SizedBox(width: 12),
          Expanded(child: Mini(label: 'SKUs', value: '1,248')),
        ]),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Stock On Hand', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < items.length; i++) _stockRow(context, items[i], i == items.length - 1),
          ]),
        ),
      ]),
      MBtn('Back to List', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => context.goTo('stores')),
    ]),
    );
  }

  Widget _stockRow(BuildContext context, (String, String, String, String) it, bool last) {
    final qtyColor = it.$3 == '0' ? SuperMaterialThemeData.of(context).colorScheme.error : (it.$4 == 'low' ? SuperMaterialThemeData.of(context).colorScheme.tertiary : SuperMaterialThemeData.of(context).superTheme.fg1);
    final tone = it.$4 == 'in' ? PillTone.success : (it.$4 == 'low' ? PillTone.warning : PillTone.danger);
    final tlabel = it.$4 == 'in' ? 'In' : (it.$4 == 'low' ? 'Low' : 'Out');
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(border: last ? null : Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
      child: Row(children: [
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(it.$2, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
            const SizedBox(height: 2),
            Text(it.$1, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
          ]),
        ),
        Text(it.$3, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 14, fontWeight: FontWeight.w600, color: qtyColor)),
        const SizedBox(width: 12),
        Pill(tlabel, tone: tone),
      ]),
    );
  }
}
