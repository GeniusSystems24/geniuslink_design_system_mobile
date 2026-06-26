import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';

class UomScreen extends StatefulWidget {
  const UomScreen({super.key});
  @override
  State<UomScreen> createState() => _UomScreenState();
}

class _UomScreenState extends State<UomScreen> {
  String _active = 'count';
  @override
  Widget build(BuildContext context) {
    final groups = {
      'count': ('Count', 'PCS', M.blue, [('PCS', 'Piece', '1', true), ('DZN', 'Dozen', '12', false), ('BOX', 'Box', '24', false), ('CTN', 'Carton', '144', false), ('PLT', 'Pallet', '600', false)]),
      'weight': ('Weight', 'KG', M.green, [('G', 'Gram', '0.001', false), ('KG', 'Kilogram', '1', true), ('TON', 'Tonne', '1000', false), ('BAG', 'Bag 50kg', '50', false)]),
      'length': ('Length', 'M', M.orange, [('CM', 'Centimeter', '0.01', false), ('M', 'Meter', '1', true), ('KM', 'Kilometer', '1000', false)]),
      'volume': ('Volume', 'L', M.blue, [('ML', 'Milliliter', '0.001', false), ('L', 'Liter', '1', true), ('M3', 'Cubic Meter', '1000', false)]),
    };
    final cur = groups[_active]!;
    return MScroll([
      GridView.count(
        crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 2.1,
        children: [
          for (final e in groups.entries)
            GestureDetector(
              onTap: () => setState(() => _active = e.key),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: _active == e.key ? tint(e.value.$3, 0x14) : M.surface, border: Border.all(color: _active == e.key ? e.value.$3 : M.border), borderRadius: BorderRadius.circular(10)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Eyebrow(e.value.$1, color: M.fg3, size: 10),
                  const SizedBox(height: 6),
                  Text('${e.value.$4.length} units', style: TextStyle(fontFamily: M.mono, fontSize: 16, fontWeight: FontWeight.w700, color: e.value.$3)),
                  const SizedBox(height: 2),
                  Text('base · ${e.value.$2}', style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)),
                ]),
              ),
            ),
        ],
      ),
      MCard(marker: cur.$3, title: '${cur.$1} Units', sub: 'Convert to base ${cur.$2}', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < cur.$4.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 13),
                decoration: BoxDecoration(border: i < cur.$4.length - 1 ? const Border(bottom: BorderSide(color: M.border)) : null),
                child: Row(children: [
                  SizedBox(width: 50, child: Text(cur.$4[i].$1, style: TextStyle(fontFamily: M.mono, fontSize: 12, fontWeight: FontWeight.w700, color: cur.$4[i].$4 ? cur.$3 : M.fg2))),
                  Expanded(child: Text(cur.$4[i].$2, style: const TextStyle(fontSize: 13, color: M.fg1, fontFamily: M.body))),
                  Text('×${cur.$4[i].$3}', style: const TextStyle(fontFamily: M.mono, fontSize: 13, fontWeight: FontWeight.w600, color: M.fg2)),
                  if (cur.$4[i].$4) const Padding(padding: EdgeInsets.only(left: 10), child: Pill('Base', tone: PillTone.info)),
                ]),
              ),
          ]),
        ),
      ]),
    ]);
  }
}
