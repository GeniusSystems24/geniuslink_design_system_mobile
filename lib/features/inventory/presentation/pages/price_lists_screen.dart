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
    const lists = [('retail', 'Retail · Standard', 'SAR', 'List', 412, SuperTokens.accent), ('whole', 'Wholesale · Tier 1', 'SAR', 'Discount 15%', 412, SuperTokens.success), ('whole2', 'Wholesale · Tier 2', 'SAR', 'Discount 25%', 412, SuperTokens.success), ('export', 'Export · USD', 'USD', 'Markup 8%', 188, SuperTokens.warning)];
    const items = [('STL-44021', 'Structural Steel I-Beam', '540.00', '459.00'), ('CMT-90112', 'Portland Cement Type I', '28.00', '23.80'), ('AGG-21044', 'Coarse Aggregate 20mm', '140.00', '119.00'), ('PLY-30022', 'Plywood Sheet 18mm', '105.00', '89.25'), ('PNT-55310', 'Epoxy Floor Coating', '44.00', '37.40')];
    return Scaffold(
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Price Lists')),
      body: MScroll([
      for (final l in lists)
        GestureDetector(
          onTap: () => setState(() => _active = l.$1),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: _active == l.$1 ? superCoreTint(l.$6, 0x14) : SuperThemeData.dark.surface, border: Border.all(color: _active == l.$1 ? l.$6 : SuperThemeData.dark.border), borderRadius: BorderRadius.circular(10)),
            child: Row(children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3), decoration: BoxDecoration(color: superCoreTint(l.$6, 0x1F), borderRadius: BorderRadius.circular(4)), child: Text(l.$3, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 0.6, color: l.$6, fontFamily: SuperTokens.bodyFont))),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(l.$2, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5, color: SuperThemeData.dark.fg1, fontFamily: SuperTokens.bodyFont)),
                const SizedBox(height: 2),
                Text('${l.$4} · ${l.$5} items', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 11, color: SuperThemeData.dark.fg3)),
              ])),
              if (_active == l.$1) Icon(MIcons.of('check'), size: 16, color: l.$6),
            ]),
          ),
        ),
      MCard(accentColor: SuperTokens.success, title: 'Item Prices', subtitle: '5 items · 15% discount applied', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < items.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i < items.length - 1 ? Border(bottom: BorderSide(color: SuperThemeData.dark.border)) : null),
                child: Row(children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(items[i].$2, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SuperThemeData.dark.fg1, fontFamily: SuperTokens.bodyFont)),
                    const SizedBox(height: 2),
                    Text(items[i].$1, style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 11, color: SuperThemeData.dark.fg3)),
                  ])),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(items[i].$3, style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 11, color: SuperThemeData.dark.fg4, decoration: TextDecoration.lineThrough)),
                    Text(items[i].$4, style: const TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 14, fontWeight: FontWeight.w700, color: SuperTokens.success)),
                  ]),
                ]),
              ),
          ]),
        ),
      ]),
    ]),
    );
  }
}
