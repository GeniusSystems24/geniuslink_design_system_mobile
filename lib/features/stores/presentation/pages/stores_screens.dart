// ============================================================
// VIEW — Stores feature (ports MobileStores)
// list · createStore · storeDetail · issue
// ============================================================

import 'package:flutter/material.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';

final _stores = [
  ('ST-001', 'Downtown Central', 'وسط المدينة', '342,820', '1,248'),
  ('ST-002', 'King Fahd Warehouse', 'مستودع الملك فهد', '1,820,460', '4,892'),
  ('ST-003', 'Jeddah Showroom', 'صالة عرض جدة', '128,640', '412'),
];

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Stores')),
      body: MScroll([
      for (final s in _stores)
        GestureDetector(
          onTap: () => context.goTo('storeDetail'),
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: SuperThemeData.dark.surface, border: Border.all(color: SuperThemeData.dark.border), borderRadius: BorderRadius.circular(12)),
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
                          Text(s.$2, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: SuperThemeData.dark.fg1, fontFamily: SuperTokens.bodyFont)),
                          const SizedBox(height: 2),
                          Directionality(textDirection: TextDirection.rtl,
                              child: Text(s.$3, style: TextStyle(fontFamily: SuperTokens.arabicFont, fontSize: 12.5, color: SuperThemeData.dark.fg3))),
                        ],
                      ),
                    ),
                    Text(s.$1, style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 11, color: SuperThemeData.dark.fg3)),
                  ],
                ),
                Container(margin: const EdgeInsets.only(top: 14), padding: const EdgeInsets.only(top: 14),
                    decoration: BoxDecoration(border: Border(top: BorderSide(color: SuperThemeData.dark.border))),
                    child: Row(children: [
                      _stat('Value', '${s.$4} SAR'),
                      const SizedBox(width: 20),
                      _stat('SKUs', s.$5),
                    ])),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _stat(String label, String value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Eyebrow(label, color: SuperThemeData.dark.fg3, size: 9.5),
          const SizedBox(height: 3),
          Text(value, style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 15, fontWeight: FontWeight.w600, color: SuperThemeData.dark.fg1)),
        ],
      );
}

class CreateStoreScreen extends StatelessWidget {
  const CreateStoreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Create Store')),
      body: const MScroll([
      MCard(accentColor: SuperTokens.accent, title: 'Store Details', subtitle: 'Name and location', children: [
        MField(label: 'Name English', placeholder: 'e.g. Downtown Central Store', required: true),
        MField(label: 'الاسم بالعربية', placeholder: 'مثال: متجر وسط المدينة', ar: true, required: true),
        MField(label: 'Location Code', value: 'ST-001', mono: true),
        MField(label: 'Store Category', value: 'Retail'),
        MField(label: 'Note', placeholder: 'Add internal notes…'),
      ]),
      Row(children: [
        Expanded(child: MBtn('Cancel', variant: MBtnVariant.secondary, full: true)),
        SizedBox(width: 10),
        Expanded(child: MBtn('Create', icon: 'check', full: true)),
      ]),
    ]),
    );
  }
}

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
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Store Detail')),
      body: MScroll([
      const MCard(accentColor: SuperTokens.success, title: 'Store Summary', trailing: Pill('Active'), children: [
        Row(children: [
          Expanded(child: Mini(label: 'Stock Value', value: '342,820', sub: 'SAR', hi: true)),
          SizedBox(width: 12),
          Expanded(child: Mini(label: 'SKUs', value: '1,248')),
        ]),
      ]),
      MCard(accentColor: SuperTokens.success, title: 'Stock On Hand', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < items.length; i++) _stockRow(items[i], i == items.length - 1),
          ]),
        ),
      ]),
      MBtn('Back to List', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => context.goTo('stores')),
    ]),
    );
  }

  Widget _stockRow((String, String, String, String) it, bool last) {
    final qtyColor = it.$3 == '0' ? SuperTokens.danger : (it.$4 == 'low' ? SuperTokens.warning : SuperThemeData.dark.fg1);
    final tone = it.$4 == 'in' ? PillTone.success : (it.$4 == 'low' ? PillTone.warning : PillTone.danger);
    final tlabel = it.$4 == 'in' ? 'In' : (it.$4 == 'low' ? 'Low' : 'Out');
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(border: last ? null : Border(bottom: BorderSide(color: SuperThemeData.dark.border))),
      child: Row(children: [
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(it.$2, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: SuperThemeData.dark.fg1, fontFamily: SuperTokens.bodyFont)),
            const SizedBox(height: 2),
            Text(it.$1, style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 11, color: SuperThemeData.dark.fg3)),
          ]),
        ),
        Text(it.$3, style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 14, fontWeight: FontWeight.w600, color: qtyColor)),
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
    return Scaffold(
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Issue Inventory')),
      body: MScroll([
      const MCard(accentColor: SuperTokens.accent, title: 'Issue Details', children: [
        MField(label: 'Serial No', value: 'INV-ISS-2024-0089', mono: true),
        MField(label: 'Store', placeholder: 'Search store…', required: true),
        MField(label: 'Currency', value: 'USD — US Dollar'),
      ]),
      MCard(accentColor: SuperTokens.success, title: 'Items', subtitle: '1 line · 12 units', children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: SuperThemeData.dark.bg, border: Border.all(color: SuperThemeData.dark.border), borderRadius: BorderRadius.circular(8)),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Structural Steel', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: SuperThemeData.dark.fg1, fontFamily: SuperTokens.bodyFont)),
                SizedBox(height: 2),
                Text('12 PCS × 450.00', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 11, color: SuperThemeData.dark.fg3)),
              ]),
            ),
            Text('5,400.00', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 15, fontWeight: FontWeight.w600, color: SuperThemeData.dark.fg1)),
          ]),
        ),
        _dashedAdd('scan', 'Scan to Add Item'),
      ]),
      MCard(accentColor: SuperTokens.success, title: 'Total', children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Eyebrow('Total Value', color: SuperThemeData.dark.fg3, size: 12),
          Text.rich(TextSpan(children: [
            TextSpan(text: '5,400.00 ', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 24, fontWeight: FontWeight.w700, color: SuperThemeData.dark.fg1)),
            TextSpan(text: 'USD', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 12, color: SuperThemeData.dark.fg3)),
          ])),
        ]),
      ]),
      const MBtn('Issue Inventory', icon: 'check', full: true),
    ]),
    );
  }

  static Widget _dashedAdd(String icon, String label) => Container(
        height: 44,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: DottedBorderBox(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(MIcons.of(icon), size: 16, color: SuperTokens.accent),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: SuperTokens.accent, fontWeight: FontWeight.w600, fontSize: 13, fontFamily: SuperTokens.bodyFont)),
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
      ..color = SuperThemeData.dark.borderStrong
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
