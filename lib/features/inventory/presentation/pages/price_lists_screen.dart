import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';

class PriceListsScreen extends StatefulWidget {
  const PriceListsScreen({super.key});
  @override
  State<PriceListsScreen> createState() => _PriceListsScreenState();
}

class _PriceListsScreenState extends State<PriceListsScreen> {
  String _active = 'whole';
  @override
  Widget build(BuildContext context) {
    const lists = [('retail', 'Retail · Standard', 'SAR', 'List', 412, M.blue), ('whole', 'Wholesale · Tier 1', 'SAR', 'Discount 15%', 412, M.green), ('whole2', 'Wholesale · Tier 2', 'SAR', 'Discount 25%', 412, M.green), ('export', 'Export · USD', 'USD', 'Markup 8%', 188, M.orange)];
    const items = [('STL-44021', 'Structural Steel I-Beam', '540.00', '459.00'), ('CMT-90112', 'Portland Cement Type I', '28.00', '23.80'), ('AGG-21044', 'Coarse Aggregate 20mm', '140.00', '119.00'), ('PLY-30022', 'Plywood Sheet 18mm', '105.00', '89.25'), ('PNT-55310', 'Epoxy Floor Coating', '44.00', '37.40')];
    return MScroll([
      for (final l in lists)
        GestureDetector(
          onTap: () => setState(() => _active = l.$1),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: _active == l.$1 ? tint(l.$6, 0x14) : M.surface, border: Border.all(color: _active == l.$1 ? l.$6 : M.border), borderRadius: BorderRadius.circular(10)),
            child: Row(children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3), decoration: BoxDecoration(color: tint(l.$6, 0x1F), borderRadius: BorderRadius.circular(4)), child: Text(l.$3, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 0.6, color: l.$6, fontFamily: M.body))),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(l.$2, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5, color: M.fg1, fontFamily: M.body)),
                const SizedBox(height: 2),
                Text('${l.$4} · ${l.$5} items', style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)),
              ])),
              if (_active == l.$1) Icon(MIcons.of('check'), size: 16, color: l.$6),
            ]),
          ),
        ),
      MCard(marker: M.green, title: 'Item Prices', sub: '5 items · 15% discount applied', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < items.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i < items.length - 1 ? const Border(bottom: BorderSide(color: M.border)) : null),
                child: Row(children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(items[i].$2, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
                    const SizedBox(height: 2),
                    Text(items[i].$1, style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)),
                  ])),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(items[i].$3, style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg4, decoration: TextDecoration.lineThrough)),
                    Text(items[i].$4, style: const TextStyle(fontFamily: M.mono, fontSize: 14, fontWeight: FontWeight.w700, color: M.green)),
                  ]),
                ]),
              ),
          ]),
        ),
      ]),
    ]);
  }
}
