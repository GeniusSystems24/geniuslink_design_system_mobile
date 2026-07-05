import 'package:flutter/material.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';

const _products = [
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
      backgroundColor: M.bg,
      appBar: AppBar(backgroundColor: M.bg, elevation: 0, title: const Text('Products')),
      body: MScroll([
      Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
            color: M.input,
            border: Border.all(color: M.borderStrong),
            borderRadius: BorderRadius.circular(10)),
        child: const Row(children: [
          Icon(Icons.search_rounded, size: 16, color: M.fg3),
          SizedBox(width: 10),
          Text('Search product or SKU…',
              style: TextStyle(color: M.fg3, fontSize: 14, fontFamily: M.body))
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
                    color: on ? M.blue : M.input,
                    border: Border.all(color: on ? M.blue : M.border),
                    borderRadius: BorderRadius.circular(999)),
                child: Text(cats[i].toUpperCase(),
                    style: TextStyle(
                        fontFamily: M.body,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                        color: on ? Colors.white : M.fg3)),
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
                      ? const Border(bottom: BorderSide(color: M.border))
                      : null),
              child: Row(children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(rows[i].$2,
                            style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                                color: M.fg1,
                                fontFamily: M.body)),
                        const SizedBox(height: 3),
                        Row(children: [
                          Text(rows[i].$1,
                              style: const TextStyle(
                                  fontFamily: M.mono,
                                  fontSize: 11,
                                  color: M.fg3)),
                          const Text('  ·  ',
                              style: TextStyle(color: M.fg4, fontSize: 11)),
                          Text(rows[i].$3,
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: M.fg3,
                                  fontFamily: M.body)),
                        ]),
                      ]),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: '${rows[i].$5} ',
                        style: TextStyle(
                            fontFamily: M.mono,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: rows[i].$5 == 0
                                ? M.red
                                : (rows[i].$6 == 'low' ? M.orange : M.fg1))),
                    TextSpan(
                        text: rows[i].$4,
                        style: const TextStyle(
                            fontFamily: M.mono, fontSize: 10, color: M.fg3)),
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
