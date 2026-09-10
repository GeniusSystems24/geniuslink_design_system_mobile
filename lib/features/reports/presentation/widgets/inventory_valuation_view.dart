part of '../pages/reports_screens.dart';

/// Presentation view extracted from `InventoryValuationScreen`.
///
/// The route/page boundary remains in `presentation/pages`, while this widget
/// owns the visual composition. Keeping presentation widgets separate makes
/// the view easier to reuse, test, and break down further without coupling
/// navigation to rendering details.
///
/// Example:
///
/// ```dart
/// const InventoryValuationView()
/// ```
class InventoryValuationView extends StatefulWidget {
  const InventoryValuationView({super.key});
  @override
  State<InventoryValuationView> createState() =>
      _InventoryValuationViewState();
}

class _InventoryValuationViewState extends State<InventoryValuationView> {
  String _store = 'All';
  @override
  Widget build(BuildContext context) {
    const rows = [
      ('STL-44021', 'Structural Steel I-Beam', 142, 450.0, 'Downtown'),
      ('CMT-90112', 'Portland Cement Type I', 1820, 24.5, 'King Fahd'),
      ('AGG-21044', 'Coarse Aggregate 20mm', 46, 125.0, 'Downtown'),
      ('PLY-30022', 'Plywood Sheet 18mm', 312, 92.0, 'Jeddah'),
      ('RBR-71203', 'Reinforcement Bar #6', 0, 78.0, 'Downtown'),
    ];
    final visible = _store == 'All'
        ? rows
        : rows.where((r) => r.$5 == _store).toList();
    final total = visible.fold<double>(0, (s, r) => s + r.$3 * r.$4);
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    return FeaturePageScaffold(
      title: Text(GeniusLinkLocalization.of(context).inventoryValuation),
      automaticallyImplyLeading: true,
      children: [
        SuperSectionCard2(
          title: "",

          initiallyExpanded: true,
          accentColor: (null),

          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Segmented(
                options: const ['All', 'Downtown', 'King Fahd', 'Jeddah'],
                value: _store,
                onChange: (v) => setState(() => _store = v),
              ),
              Row(
                children: [
                  Eyebrow(
                    GeniusLinkLocalization.of(context).method,
                    color: SuperMaterialThemeData.of(context).superTheme.fg3,
                    size: 9.5,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    GeniusLinkLocalization.of(context).weightedAvg,
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: SuperMaterialThemeData.of(context).superTheme.fg1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).stockValuation,
          subtitle: GeniusLinkLocalization.of(context).quantityWeightedAverageUnitCost,
          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              MTable(
                showSearch: true,
                searchHint: GeniusLinkLocalization.of(context).searchSkuProductOrStore,
                itemNoun: 'item',
                itemNounPlural: 'items',
                columns: [
                  const MCol('item', 'Item', flex: 1),
                  MCol(
                    'qty',
                    'Qty',
                    fixed: 70,
                    align: TextAlign.right,
                    numeric: true,
                    format: (v) => switch (v) {
                      final int n when n != 0 => '$n',
                      _ => '\u2014',
                    },
                  ),
                  MCol(
                    'value',
                    'Value',
                    fixed: 110,
                    align: TextAlign.right,
                    numeric: true,
                    format: (v) => _money((v as num?) ?? 0),
                  ),
                ],
                rows: [
                  for (final r in visible)
                    {
                      'item': '${r.$2}\n${r.$1} · ${r.$5} · ${_money(r.$4)}',
                      'qty': r.$3,
                      'value': r.$3 * r.$4,
                    },
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: ReportTotalBar(
                  label: GeniusLinkLocalization.of(context).totalInventoryValue,
                  value: _money(total),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
