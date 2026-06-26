// ============================================================
// VIEW — Inventory Extras (ports MobileInventoryExtras)
// invDashboard · stockTake · categories · uom · priceLists
// barcodePrint · warehousesList · transferList
// ============================================================

import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';
import '../../../../design_system/adapters/inventory/m_inv_kit.dart';
import '../../../../workspace/presentation/bloc/nav_cubit.dart';

/* ───────── 1 · INVENTORY DASHBOARD ───────── */
class InvDashboardScreen extends StatelessWidget {
  const InvDashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const kpis = [('Stock Value', '2.82M', 'SAR · 5 stores', M.blue), ('SKUs', '4,891', '+18 this week', M.blue), ('Low Stock', '47', 'reorder needed', M.orange), ('Out of Stock', '12', 'urgent', M.red)];
    const ops = [('INV-REC-0241', 'Receive', '+24,200', M.green), ('INV-ISS-0089', 'Issue', '−5,400', M.red), ('INV-TRF-0117', 'Transfer', '±20,970', M.blue), ('INV-ADJ-0058', 'Adjustment', '−307', M.orange)];
    const low = [('AGG-21044', 'Coarse Aggregate 20mm', 46, 80, 58), ('TMR-19080', 'Timber 2×4 Treated', 24, 60, 40), ('RBR-71203', 'Reinforcement Bar #6', 0, 100, 0)];
    return MScroll([
      GridView.count(
        crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1.8,
        children: [
          for (final k in kpis)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: M.surface, border: Border.all(color: M.border), borderRadius: BorderRadius.circular(10)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Eyebrow(k.$1, color: M.fg3, size: 9.5),
                const SizedBox(height: 6),
                Text(k.$2, style: TextStyle(fontFamily: M.mono, fontSize: 22, fontWeight: FontWeight.w700, color: k.$4, height: 1.1)),
                const SizedBox(height: 4),
                Text(k.$3, style: const TextStyle(fontFamily: M.mono, fontSize: 10.5, color: M.fg3)),
              ]),
            ),
        ],
      ),
      MCard(marker: M.blue, title: 'Recent Operations', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < ops.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i < ops.length - 1 ? const Border(bottom: BorderSide(color: M.border)) : null),
                child: Row(children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(ops[i].$1, style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.blue)),
                    const SizedBox(height: 2),
                    Text(ops[i].$2, style: const TextStyle(fontSize: 12, color: M.fg3, fontFamily: M.body)),
                  ])),
                  Text(ops[i].$3, style: TextStyle(fontFamily: M.mono, fontSize: 14, fontWeight: FontWeight.w700, color: ops[i].$4)),
                ]),
              ),
          ]),
        ),
      ]),
      MCard(marker: M.orange, title: 'Reorder Alerts', sub: '3 products at or below reorder level', children: [
        for (final p in low) _ReorderBar(p: p),
        const MBtn('Generate Purchase Order', icon: 'paperclip', full: true),
      ]),
    ]);
  }
}

class _ReorderBar extends StatelessWidget {
  final (String, String, int, int, int) p;
  const _ReorderBar({required this.p});
  @override
  Widget build(BuildContext context) {
    final tone = p.$3 == 0 ? M.red : (p.$5 < 50 ? M.orange : M.green);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(p.$2, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
          const SizedBox(height: 2),
          Text(p.$1, style: const TextStyle(fontFamily: M.mono, fontSize: 10.5, color: M.fg3)),
        ])),
        Text('${p.$3}/${p.$4}', style: TextStyle(fontFamily: M.mono, fontSize: 13, fontWeight: FontWeight.w700, color: tone)),
      ]),
      const SizedBox(height: 6),
      ClipRRect(borderRadius: BorderRadius.circular(999), child: Stack(children: [
        Container(height: 5, color: M.input),
        FractionallySizedBox(widthFactor: p.$5 / 100, child: Container(height: 5, color: tone)),
      ])),
    ]);
  }
}

/* ───────── 2 · STOCK TAKE ───────── */
class StockTakeScreen extends StatelessWidget {
  const StockTakeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const items = [
      ('STL-44021', 'Structural Steel I-Beam', 142, 140), ('CMT-90112', 'Portland Cement Type I', 1820, 1820),
      ('AGG-21044', 'Coarse Aggregate 20mm', 48, 46), ('PLY-30022', 'Plywood Sheet 18mm', 312, -1),
      ('PNT-55310', 'Epoxy Floor Coating', 88, -1), ('RBR-71203', 'Reinforcement Bar #6', 0, -1),
    ];
    return MScroll([
      MCard(marker: M.blue, title: 'STK-2024-0014', sub: 'King Fahd Warehouse · Started Dec 18, 09:14', right: const Pill('In Progress', tone: PillTone.warning), children: [
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end, children: [
            Eyebrow('3 of 6 counted', size: 10),
            Text('50%', style: TextStyle(fontFamily: M.mono, fontSize: 22, fontWeight: FontWeight.w700, color: M.blue)),
          ]),
          const SizedBox(height: 8),
          ClipRRect(borderRadius: BorderRadius.circular(999), child: Stack(children: [
            Container(height: 8, color: M.input),
            FractionallySizedBox(widthFactor: 0.5, child: Container(height: 8, color: M.blue)),
          ])),
        ]),
        GridView.count(crossAxisCount: 3, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1.4, children: [
          const Mini(label: 'Match', value: '1'), const Mini(label: 'Short', value: '2'), const Mini(label: 'Over', value: '0'),
        ]),
      ]),
      MCard(marker: M.green, title: 'Count Sheet', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < items.length; i++) _CountRow(item: items[i], last: i == items.length - 1),
          ]),
        ),
      ]),
      const ActionRow(primary: 'Post Stock Take'),
    ]);
  }
}

class _CountRow extends StatelessWidget {
  final (String, String, int, int) item;
  final bool last;
  const _CountRow({required this.item, required this.last});
  @override
  Widget build(BuildContext context) {
    final pending = item.$4 == -1;
    final delta = pending ? 0 : item.$4 - item.$3;
    final tone = pending ? M.fg3 : (delta == 0 ? M.green : (delta < 0 ? M.red : M.orange));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(border: last ? null : const Border(bottom: BorderSide(color: M.border))),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(item.$2, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
          const SizedBox(height: 2),
          Text('${item.$1} · exp ${item.$3}', style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)),
        ])),
        if (pending)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: M.input, border: Border.all(color: M.border), borderRadius: BorderRadius.circular(6)),
            child: const Text('COUNT', style: TextStyle(fontFamily: M.body, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: M.fg3)),
          )
        else
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('${item.$4}', style: const TextStyle(fontFamily: M.mono, fontSize: 14, fontWeight: FontWeight.w700, color: M.fg1)),
            Text('${delta > 0 ? '+' : ''}$delta', style: TextStyle(fontFamily: M.mono, fontSize: 11, fontWeight: FontWeight.w700, color: tone)),
          ]),
      ]),
    );
  }
}

/* ───────── 3 · CATEGORIES ───────── */
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final _open = <String>{'steel'};
  @override
  Widget build(BuildContext context) {
    final tree = [
      ('steel', 'CAT-001', 'Steel', 412, '1,820,420', [('CAT-001-01', 'Reinforcement Bars', 88), ('CAT-001-02', 'Structural Beams', 142), ('CAT-001-03', 'Steel Plates', 64)]),
      ('cement', 'CAT-002', 'Cement & Mortars', 96, '188,640', [('CAT-002-01', 'Ordinary Portland', 42), ('CAT-002-02', 'Sulfate Resistant', 28)]),
      ('agg', 'CAT-003', 'Aggregates', 64, '142,800', <(String, String, int)>[]),
      ('timber', 'CAT-004', 'Timber & Wood', 184, '484,210', [('CAT-004-01', 'Sawn Lumber', 92), ('CAT-004-02', 'Plywood', 92)]),
      ('finish', 'CAT-005', 'Finishing Materials', 128, '184,390', <(String, String, int)>[]),
    ];
    return MScroll([
      MCard(marker: M.blue, title: 'Category Tree', sub: '5 top-level groups', pad: 8, children: [
        for (final node in tree) ...[
          GestureDetector(
            onTap: () => setState(() => _open.contains(node.$1) ? _open.remove(node.$1) : _open.add(node.$1)),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
              child: Row(children: [
                Container(
                  width: 22, height: 22, alignment: Alignment.center,
                  decoration: BoxDecoration(color: tint(M.blue, 0x1F), borderRadius: BorderRadius.circular(6)),
                  child: Icon(node.$6.isNotEmpty ? (_open.contains(node.$1) ? Icons.keyboard_arrow_down_rounded : Icons.chevron_right_rounded) : Icons.description_outlined, size: 13, color: M.blue),
                ),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(node.$3, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
                  const SizedBox(height: 2),
                  Text('${node.$2} · ${node.$4} SKUs', style: const TextStyle(fontFamily: M.mono, fontSize: 10.5, color: M.fg3)),
                ])),
                Text(node.$5, style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)),
              ]),
            ),
          ),
          if (_open.contains(node.$1))
            for (final ch in node.$6)
              Padding(
                padding: const EdgeInsets.only(left: 36, right: 4, top: 2, bottom: 12),
                child: Row(children: [
                  Icon(MIcons.of('doc'), size: 11, color: M.fg4),
                  const SizedBox(width: 10),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(ch.$2, style: const TextStyle(fontSize: 12.5, color: M.fg2, fontFamily: M.body)),
                    Text(ch.$1, style: const TextStyle(fontFamily: M.mono, fontSize: 10, color: M.fg4)),
                  ])),
                  Text('${ch.$3}', style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)),
                ]),
              ),
        ],
      ]),
      const ISection(icon: 'briefcase', title: 'New Category', sub: 'Quick inline form', marker: M.green, defaultOpen: false, children: [
        IField(label: 'Code', placeholder: 'e.g. CAT-006', mono: true, required: true),
        IField(label: 'Parent', value: '— Top Level —', select: true),
        IField(label: 'Name (English)', placeholder: 'e.g. Adhesives & Sealants', required: true),
        IField(label: 'الاسم بالعربية', placeholder: 'مثال: لاصقات', ar: true, required: true),
        ActionRow(primary: 'Create Category'),
      ]),
    ]);
  }
}

/* ───────── 4 · UNITS OF MEASURE ───────── */
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

/* ───────── 5 · PRICE LISTS ───────── */
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

/* ───────── 6 · BARCODE PRINT ───────── */
class BarcodePrintScreen extends StatefulWidget {
  const BarcodePrintScreen({super.key});
  @override
  State<BarcodePrintScreen> createState() => _BarcodePrintScreenState();
}

class _BarcodePrintScreenState extends State<BarcodePrintScreen> {
  String _tpl = 'md';
  @override
  Widget build(BuildContext context) {
    const tpls = [('sm', 'Small Tag', '38×19'), ('md', 'Medium Label', '50×30'), ('lg', 'Large Shelf', '80×40'), ('sh', 'Shipping', '100×50')];
    final size = tpls.firstWhere((t) => t.$1 == _tpl).$3;
    return MScroll([
      MCard(marker: M.green, title: 'Preview', sub: 'Code 128 · $size mm', children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 260),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(border: Border.all(color: const Color(0xFFD4D4D8)), borderRadius: BorderRadius.circular(4)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              const Text('Portland Cement Type I', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Color(0xFF0B0C10), height: 1.2)),
              const SizedBox(height: 8),
              SizedBox(height: 36, child: CustomPaint(painter: _BarcodePainter(), size: const Size(double.infinity, 36))),
              const SizedBox(height: 8),
              const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text('CMT-90112', style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF0B0C10))),
                Text('SAR 28.00', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF0B0C10))),
              ]),
              const SizedBox(height: 6),
              const Center(child: Text('6 281000 901127', style: TextStyle(fontFamily: 'monospace', fontSize: 9, letterSpacing: 0.8, color: Color(0xFF0B0C10)))),
            ]),
          ),
        ),
      ]),
      ISection(icon: 'box', title: 'Label Template', marker: M.blue, children: [
        GridView.count(
          crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 2.6,
          children: [
            for (final t in tpls)
              GestureDetector(
                onTap: () => setState(() => _tpl = t.$1),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: _tpl == t.$1 ? tint(M.blue, 0x14) : M.input, border: Border.all(color: _tpl == t.$1 ? M.blue : M.border), borderRadius: BorderRadius.circular(8)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(t.$2, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: M.fg1, fontFamily: M.body)),
                    const SizedBox(height: 4),
                    Text('${t.$3} mm', style: const TextStyle(fontFamily: M.mono, fontSize: 10.5, color: M.fg3)),
                  ]),
                ),
              ),
          ],
        ),
      ]),
      const ISection(icon: 'scan', title: 'Print Settings', marker: M.green, children: [
        IField(label: 'Symbology', value: 'Code 128', select: true),
        IField(label: 'Paper', value: 'A4 (210 × 297 mm)', select: true),
        IField(label: 'Copies per Item', placeholder: '1', mono: true),
      ]),
      ISection(icon: 'doc', title: 'Queue', sub: '4 products · 12 labels · 1 sheet', marker: M.orange, children: [
        for (final q in const [('STL-44021', 'Structural Steel I-Beam', 4), ('CMT-90112', 'Portland Cement Type I', 12), ('AGG-21044', 'Coarse Aggregate 20mm', 2), ('PLY-30022', 'Plywood Sheet 18mm', 6)])
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(q.$2, style: const TextStyle(fontSize: 12.5, color: M.fg1, fontWeight: FontWeight.w500, fontFamily: M.body)),
                const SizedBox(height: 2),
                Text(q.$1, style: const TextStyle(fontFamily: M.mono, fontSize: 10.5, color: M.fg3)),
              ])),
              Text('×${q.$3}', style: const TextStyle(fontFamily: M.mono, fontSize: 13, fontWeight: FontWeight.w700, color: M.fg1)),
            ]),
          ),
      ]),
      const ActionRow(primary: 'Print 24 Labels'),
    ]);
  }
}

class _BarcodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rng = math.Random(42);
    final paint = Paint()..color = const Color(0xFF0B0C10);
    double x = 0;
    while (x < size.width - 2) {
      final bw = rng.nextDouble() > 0.6 ? 3.0 : (rng.nextDouble() > 0.5 ? 2.0 : 1.0);
      canvas.drawRect(Rect.fromLTWH(x, 0, bw, size.height), paint);
      x += bw + (rng.nextDouble() > 0.55 ? 2 : 1);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

/* ───────── 7 · WAREHOUSES LIST ───────── */
class WarehousesListScreen extends StatelessWidget {
  const WarehousesListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const stores = [('ST-001', 'Downtown Central', 1248, 1800, 'Layla Ahmed', '342.8K'), ('ST-002', 'King Fahd Warehouse', 4892, 6000, 'Mohammed Saleh', '1.82M'), ('ST-003', 'Jeddah Showroom', 412, 600, 'Sara Al-Otaibi', '128.6K'), ('ST-004', 'Dammam Distribution', 2104, 2400, 'Khalid Al-Rashid', '624.2K'), ('ST-005', 'Madinah Outlet', 0, 500, '— Unassigned —', '0.00')];
    return MScroll([
      MCard(marker: M.blue, title: '5 Warehouses', sub: 'Capacity & assigned manager', pad: 8, children: [
        for (int i = 0; i < stores.length; i++) _WarehouseRow(s: stores[i], last: i == stores.length - 1),
      ]),
    ]);
  }
}

class _WarehouseRow extends StatelessWidget {
  final (String, String, int, int, String, String) s;
  final bool last;
  const _WarehouseRow({required this.s, required this.last});
  @override
  Widget build(BuildContext context) {
    final pct = math.min(100, ((s.$3 / s.$4) * 100).round());
    final tone = pct >= 90 ? M.red : (pct >= 70 ? M.orange : M.green);
    final unassigned = s.$5.contains('—');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
      decoration: BoxDecoration(border: last ? null : const Border(bottom: BorderSide(color: M.border))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(padding: const EdgeInsets.only(top: 2), child: SizedBox(width: 54, child: Text(s.$1, style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)))),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(s.$2, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
            const SizedBox(height: 4),
            Row(children: [
              Container(width: 18, height: 18, alignment: Alignment.center, decoration: BoxDecoration(color: unassigned ? M.input : tint(M.blue, 0x26), shape: BoxShape.circle), child: Text(unassigned ? '—' : s.$5.split(' ').take(2).map((w) => w[0]).join(), style: TextStyle(fontSize: 8, fontWeight: FontWeight.w700, color: unassigned ? M.fg4 : M.blue))),
              const SizedBox(width: 6),
              Text(s.$5, style: const TextStyle(fontSize: 11.5, color: M.fg3, fontFamily: M.body)),
            ]),
          ])),
          Text(s.$6, style: const TextStyle(fontFamily: M.mono, fontSize: 13, fontWeight: FontWeight.w700, color: M.fg1)),
        ]),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('${s.$3} / ${s.$4}', style: const TextStyle(fontFamily: M.mono, fontSize: 10.5, color: M.fg3)),
          Text('$pct%', style: TextStyle(fontFamily: M.mono, fontSize: 10.5, fontWeight: FontWeight.w700, color: tone)),
        ]),
        const SizedBox(height: 4),
        ClipRRect(borderRadius: BorderRadius.circular(999), child: Stack(children: [Container(height: 5, color: M.input), FractionallySizedBox(widthFactor: pct / 100, child: Container(height: 5, color: tone))])),
      ]),
    );
  }
}

/* ───────── 8 · TRANSFER LIST ───────── */
class TransferListScreen extends StatefulWidget {
  final NavCubit nav;
  const TransferListScreen({super.key, required this.nav});
  @override
  State<TransferListScreen> createState() => _TransferListScreenState();
}

class _TransferListScreenState extends State<TransferListScreen> {
  String _status = 'all';
  @override
  Widget build(BuildContext context) {
    const transfers = [
      ('INV-TRF-2024-0117', 'ST-001', 'ST-002', '20,970', 'Dec 14', 'in-transit'), ('INV-TRF-2024-0116', 'ST-002', 'ST-003', '48,200', 'Dec 12', 'delivered'),
      ('INV-TRF-2024-0115', 'ST-004', 'ST-001', '12,840', 'Dec 10', 'delivered'), ('INV-TRF-2024-0114', 'ST-001', 'ST-005', '5,400', 'Dec 09', 'draft'),
      ('INV-TRF-2024-0113', 'ST-002', 'ST-001', '88,400', 'Dec 07', 'delivered'), ('INV-TRF-2024-0112', 'ST-003', 'ST-002', '14,200', 'Dec 05', 'cancelled'),
    ];
    const filters = [('all', 'All', M.fg2), ('draft', 'Draft', M.fg2), ('in-transit', 'Transit', M.orange), ('delivered', 'Delivered', M.green), ('cancelled', 'Cancelled', M.red)];
    final visible = transfers.where((t) => _status == 'all' || t.$6 == _status).toList();
    PillTone tone(String s) => s == 'delivered' ? PillTone.success : (s == 'in-transit' ? PillTone.warning : (s == 'cancelled' ? PillTone.danger : PillTone.neutral));
    String label(String s) => s == 'in-transit' ? 'Transit' : (s[0].toUpperCase() + s.substring(1));
    return MScroll([
      SizedBox(
        height: 32,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: filters.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (_, i) {
            final f = filters[i];
            final on = _status == f.$1;
            return GestureDetector(
              onTap: () => setState(() => _status = f.$1),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14), alignment: Alignment.center,
                decoration: BoxDecoration(color: on ? tint(f.$3, 0x1F) : M.input, border: Border.all(color: on ? f.$3 : M.border), borderRadius: BorderRadius.circular(999)),
                child: Text(f.$2.toUpperCase(), style: TextStyle(fontFamily: M.body, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: on ? f.$3 : M.fg3)),
              ),
            );
          },
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(color: M.input, border: Border.all(color: M.border), borderRadius: BorderRadius.circular(8)),
        child: Row(children: [
          Icon(MIcons.of('clock'), size: 13, color: M.fg3),
          const SizedBox(width: 8),
          const Text('Dec 01 – Dec 31, 2025', style: TextStyle(fontFamily: M.mono, fontSize: 12, color: M.fg2)),
          const Spacer(),
          Icon(MIcons.of('chevD'), size: 13, color: M.fg3),
        ]),
      ),
      MCard(marker: M.blue, title: '${visible.length} Transfers', pad: 8, children: [
        for (int i = 0; i < visible.length; i++)
          GestureDetector(
            onTap: () => widget.nav.go('transferDetail'),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
              decoration: BoxDecoration(border: i < visible.length - 1 ? const Border(bottom: BorderSide(color: M.border)) : null),
              child: Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(visible[i].$1, style: const TextStyle(fontFamily: M.mono, fontSize: 11.5, color: M.blue)),
                  const SizedBox(height: 4),
                  Row(children: [
                    Text(visible[i].$2, style: const TextStyle(fontFamily: M.body, fontSize: 12, color: M.fg2)),
                    Icon(MIcons.of('chevR'), size: 11, color: M.fg4),
                    Text(visible[i].$3, style: const TextStyle(fontFamily: M.body, fontSize: 12, color: M.fg2)),
                    Text('  · ${visible[i].$5}', style: const TextStyle(color: M.fg4, fontSize: 12, fontFamily: M.body)),
                  ]),
                ])),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(visible[i].$4, style: const TextStyle(fontFamily: M.mono, fontSize: 13, fontWeight: FontWeight.w700, color: M.fg1)),
                  const SizedBox(height: 4),
                  Pill(label(visible[i].$6), tone: tone(visible[i].$6)),
                ]),
              ]),
            ),
          ),
      ]),
    ]);
  }
}
