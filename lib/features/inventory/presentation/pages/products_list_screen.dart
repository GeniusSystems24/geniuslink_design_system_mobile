import 'package:flutter/material.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';

final _products = [
  ('STL-44021', 'Structural Steel I-Beam', 'Steel', 'PCS', 142, 'in'),
  ('CMT-90112', 'Portland Cement Type I', 'Cement', 'BAG', 1820, 'in'),
  ('AGG-21044', 'Coarse Aggregate 20mm', 'Aggregate', 'TON', 46, 'low'),
  ('RBR-71203', 'Reinforcement Bar #6', 'Steel', 'PCS', 0, 'out'),
  ('PLY-30022', 'Plywood Sheet 18mm', 'Timber', 'SHT', 312, 'in'),
  ('PNT-55310', 'Epoxy Floor Coating', 'Finishing', 'L', 88, 'in'),
];

PillTone _statusTone(String s) => s == 'in'
    ? PillTone.success
    : (s == 'low' ? PillTone.warning : PillTone.danger);
String _statusLabel(String s) =>
    s == 'in' ? 'In Stock' : (s == 'low' ? 'Low' : 'Out');

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});
  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  String _cat = 'All';
  @override
  Widget build(BuildContext context) {
    const cats = ['All', 'Steel', 'Cement', 'Aggregate', 'Timber', 'Finishing'];
    final rows = _cat == 'All'
        ? _products
        : _products.where((p) => p.$3 == _cat).toList();
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, elevation: 0, title: const Text('Products')),
      body: MScroll([
      Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
            color: SuperMaterialThemeData.of(context).superTheme.inputBg,
            border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.borderStrong),
            borderRadius: BorderRadius.circular(10)),
        child: Row(children: [
          Icon(Icons.search_rounded, size: 16, color: SuperMaterialThemeData.of(context).superTheme.fg3),
          SizedBox(width: 10),
          Text('Search product or SKU…',
              style: TextStyle(color: SuperMaterialThemeData.of(context).superTheme.fg3, fontSize: 14, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily))
        ]),
      ),
      SizedBox(
        height: 32,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: cats.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (_, i) {
            final on = cats[i] == _cat;
            return GestureDetector(
              onTap: () => setState(() => _cat = cats[i]),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: on ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.inputBg,
                    border: Border.all(color: on ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.border),
                    borderRadius: BorderRadius.circular(999)),
                child: Text(cats[i].toUpperCase(),
                    style: TextStyle(
                        fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                        color: on ? Colors.white : SuperMaterialThemeData.of(context).superTheme.fg3)),
              ),
            );
          },
        ),
      ),
      MCard(pad: 8, children: [
        for (int i = 0; i < rows.length; i++)
          GestureDetector(
            onTap: () => context.goTo('productDetail'),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
              decoration: BoxDecoration(
                  border: i < rows.length - 1
                      ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))
                      : null),
              child: Row(children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(rows[i].$2,
                            style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                                color: SuperMaterialThemeData.of(context).superTheme.fg1,
                                fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                        const SizedBox(height: 3),
                        Row(children: [
                          Text(rows[i].$1,
                              style: TextStyle(
                                  fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
                                  fontSize: 11,
                                  color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                          Text('  ·  ',
                              style: TextStyle(color: SuperMaterialThemeData.of(context).superTheme.fg4, fontSize: 11)),
                          Text(rows[i].$3,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: SuperMaterialThemeData.of(context).superTheme.fg3,
                                  fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                        ]),
                      ]),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: '${rows[i].$5} ',
                        style: TextStyle(
                            fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: rows[i].$5 == 0
                                ? SuperMaterialThemeData.of(context).colorScheme.error
                                : (rows[i].$6 == 'low' ? SuperMaterialThemeData.of(context).colorScheme.tertiary : SuperMaterialThemeData.of(context).superTheme.fg1))),
                    TextSpan(
                        text: rows[i].$4,
                        style: TextStyle(
                            fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                  ])),
                  const SizedBox(height: 4),
                  Pill(_statusLabel(rows[i].$6), tone: _statusTone(rows[i].$6)),
                ]),
              ]),
            ),
          ),
      ]),
    ]),
    );
  }
}
