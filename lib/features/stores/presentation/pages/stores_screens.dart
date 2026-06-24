// ============================================================
// VIEW — Stores feature (ports MobileStores)
// list · createStore · storeDetail · issue
// ============================================================

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';
import '../../../../workspace/presentation/controllers/nav_controller.dart';

const _stores = [
  ('ST-001', 'Downtown Central', 'وسط المدينة', '342,820', '1,248'),
  ('ST-002', 'King Fahd Warehouse', 'مستودع الملك فهد', '1,820,460', '4,892'),
  ('ST-003', 'Jeddah Showroom', 'صالة عرض جدة', '128,640', '412'),
];

class StoresScreen extends StatelessWidget {
  final NavController nav;
  const StoresScreen({super.key, required this.nav});

  @override
  Widget build(BuildContext context) {
    return MScroll([
      for (final s in _stores)
        GestureDetector(
          onTap: () => nav.go('storeDetail'),
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: M.surface, border: Border.all(color: M.border), borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s.$2, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
                          const SizedBox(height: 2),
                          Directionality(textDirection: TextDirection.rtl,
                              child: Text(s.$3, style: const TextStyle(fontFamily: M.arabic, fontSize: 12.5, color: M.fg3))),
                        ],
                      ),
                    ),
                    Text(s.$1, style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)),
                  ],
                ),
                Container(margin: const EdgeInsets.only(top: 14), padding: const EdgeInsets.only(top: 14),
                    decoration: const BoxDecoration(border: Border(top: BorderSide(color: M.border))),
                    child: Row(children: [
                      _stat('Value', '${s.$4} SAR'),
                      const SizedBox(width: 20),
                      _stat('SKUs', s.$5),
                    ])),
              ],
            ),
          ),
        ),
    ]);
  }

  Widget _stat(String label, String value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Eyebrow(label, color: M.fg3, size: 9.5),
          const SizedBox(height: 3),
          Text(value, style: const TextStyle(fontFamily: M.mono, fontSize: 15, fontWeight: FontWeight.w600, color: M.fg1)),
        ],
      );
}

class CreateStoreScreen extends StatelessWidget {
  const CreateStoreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MScroll([
      const MCard(marker: M.blue, title: 'Store Details', sub: 'Name and location', children: [
        MField(label: 'Name English', placeholder: 'e.g. Downtown Central Store', required: true),
        MField(label: 'الاسم بالعربية', placeholder: 'مثال: متجر وسط المدينة', ar: true, required: true),
        MField(label: 'Location Code', value: 'ST-001', mono: true),
        MField(label: 'Store Category', value: 'Retail'),
        MField(label: 'Note', placeholder: 'Add internal notes…'),
      ]),
      const Row(children: [
        Expanded(child: MBtn('Cancel', variant: MBtnVariant.secondary, full: true)),
        SizedBox(width: 10),
        Expanded(child: MBtn('Create', icon: 'check', full: true)),
      ]),
    ]);
  }
}

class StoreDetailScreen extends StatelessWidget {
  final NavController nav;
  const StoreDetailScreen({super.key, required this.nav});
  @override
  Widget build(BuildContext context) {
    const items = [
      ('STL-44021', 'Steel I-Beam', '142', 'in'),
      ('AGG-21044', 'Aggregate 20mm', '46', 'low'),
      ('RBR-71203', 'Rebar #6', '0', 'out'),
    ];
    return MScroll([
      const MCard(marker: M.green, title: 'Store Summary', right: Pill('Active'), children: [
        Row(children: [
          Expanded(child: Mini(label: 'Stock Value', value: '342,820', sub: 'SAR', hi: true)),
          SizedBox(width: 12),
          Expanded(child: Mini(label: 'SKUs', value: '1,248')),
        ]),
      ]),
      MCard(marker: M.green, title: 'Stock On Hand', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < items.length; i++) _stockRow(items[i], i == items.length - 1),
          ]),
        ),
      ]),
      MBtn('Back to List', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => nav.back('stores')),
    ]);
  }

  Widget _stockRow((String, String, String, String) it, bool last) {
    final qtyColor = it.$3 == '0' ? M.red : (it.$4 == 'low' ? M.orange : M.fg1);
    final tone = it.$4 == 'in' ? PillTone.success : (it.$4 == 'low' ? PillTone.warning : PillTone.danger);
    final tlabel = it.$4 == 'in' ? 'In' : (it.$4 == 'low' ? 'Low' : 'Out');
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(border: last ? null : const Border(bottom: BorderSide(color: M.border))),
      child: Row(children: [
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(it.$2, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
            const SizedBox(height: 2),
            Text(it.$1, style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)),
          ]),
        ),
        Text(it.$3, style: TextStyle(fontFamily: M.mono, fontSize: 14, fontWeight: FontWeight.w600, color: qtyColor)),
        const SizedBox(width: 12),
        Pill(tlabel, tone: tone),
      ]),
    );
  }
}

class IssueInventoryScreen extends StatelessWidget {
  const IssueInventoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MScroll([
      const MCard(marker: M.blue, title: 'Issue Details', children: [
        MField(label: 'Serial No', value: 'INV-ISS-2024-0089', mono: true),
        MField(label: 'Store', placeholder: 'Search store…', required: true),
        MField(label: 'Currency', value: 'USD — US Dollar'),
      ]),
      MCard(marker: M.green, title: 'Items', sub: '1 line · 12 units', children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: M.bg, border: Border.all(color: M.border), borderRadius: BorderRadius.circular(8)),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Structural Steel', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
                SizedBox(height: 2),
                Text('12 PCS × 450.00', style: TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)),
              ]),
            ),
            Text('5,400.00', style: TextStyle(fontFamily: M.mono, fontSize: 15, fontWeight: FontWeight.w600, color: M.fg1)),
          ]),
        ),
        _dashedAdd('scan', 'Scan to Add Item'),
      ]),
      const MCard(marker: M.green, title: 'Total', children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Eyebrow('Total Value', color: M.fg3, size: 12),
          Text.rich(TextSpan(children: [
            TextSpan(text: '5,400.00 ', style: TextStyle(fontFamily: M.mono, fontSize: 24, fontWeight: FontWeight.w700, color: M.fg1)),
            TextSpan(text: 'USD', style: TextStyle(fontFamily: M.mono, fontSize: 12, color: M.fg3)),
          ])),
        ]),
      ]),
      const MBtn('Issue Inventory', icon: 'check', full: true),
    ]);
  }

  static Widget _dashedAdd(String icon, String label) => Container(
        height: 44,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: DottedBorderBox(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(MIcons.of(icon), size: 16, color: M.blue),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: M.blue, fontWeight: FontWeight.w600, fontSize: 13, fontFamily: M.body)),
          ]),
        ),
      );
}

/// A dashed-border container (CustomPaint) for "add" affordances.
class DottedBorderBox extends StatelessWidget {
  final Widget child;
  const DottedBorderBox({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashPainter(),
      child: Center(child: child),
    );
  }
}

class _DashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = M.borderStrong
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final rrect = RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(8));
    final path = Path()..addRRect(rrect);
    const dash = 5.0, gap = 4.0;
    for (final metric in path.computeMetrics()) {
      double d = 0;
      while (d < metric.length) {
        canvas.drawPath(metric.extractPath(d, d + dash), paint);
        d += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
