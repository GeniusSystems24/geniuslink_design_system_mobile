part of 'reports_screens.dart';

class InventoryValuationScreen extends StatefulWidget {
  const InventoryValuationScreen({super.key});
  @override
  State<InventoryValuationScreen> createState() =>
      _InventoryValuationScreenState();
}

class _InventoryValuationScreenState extends State<InventoryValuationScreen> {
  String _store = 'All';
  @override
  Widget build(BuildContext context) {
    const rows = [
      ('STL-44021', 'Structural Steel I-Beam', 142, 450.0, 'Downtown'),
      ('CMT-90112', 'Portland Cement Type I', 1820, 24.5, 'King Fahd'),
      ('AGG-21044', 'Coarse Aggregate 20mm', 46, 125.0, 'Downtown'),
      ('PLY-30022', 'Plywood Sheet 18mm', 312, 92.0, 'Jeddah'),
      ('RBR-71203', 'Reinforcement Bar #6', 0, 78.0, 'Downtown')
    ];
    final visible =
        _store == 'All' ? rows : rows.where((r) => r.$5 == _store).toList();
    final total = visible.fold<double>(0, (s, r) => s + r.$3 * r.$4);
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Inventory Valuation')),
      body: MScroll([
        MCard(pad: 14, children: [
          Segmented(
              options: const ['All', 'Downtown', 'King Fahd', 'Jeddah'],
              value: _store,
              onChange: (v) => setState(() => _store = v)),
          Row(children: [
            Eyebrow('Method', color: SuperMaterialThemeData.of(context).superTheme.fg3, size: 9.5),
            const SizedBox(width: 7),
            Text('Weighted Avg',
                style: TextStyle(
                    fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: SuperMaterialThemeData.of(context).superTheme.fg1)),
          ]),
        ]),
        MCard(
            accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary,
            title: 'Stock Valuation',
            subtitle: 'Quantity × weighted-average unit cost',
            pad: 8,
            children: [
              MTable(
                showSearch: true,
                searchHint: 'Search SKU, product or store…',
                itemNoun: 'item',
                itemNounPlural: 'items',
                columns: [
                  const MCol('item', 'Item', flex: 1),
                  MCol('qty', 'Qty',
                      fixed: 70,
                      align: TextAlign.right,
                      numeric: true,
                      format: (v) => switch (v) {
                            final int n when n != 0 => '$n',
                            _ => '\u2014'
                          }),
                  MCol('value', 'Value',
                      fixed: 110,
                      align: TextAlign.right,
                      numeric: true,
                      format: (v) => _money((v as num?) ?? 0)),
                ],
                rows: [
                  for (final r in visible)
                    {
                      'item': '${r.$2}\n${r.$1} · ${r.$5} · ${_money(r.$4)}',
                      'qty': r.$3,
                      'value': r.$3 * r.$4
                    }
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: ReportTotalBar(
                    label: 'Total Inventory Value', value: _money(total)),
              ),
            ]),
      ]),
    );
  }
}
