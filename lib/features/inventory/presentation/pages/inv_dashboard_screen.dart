import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';

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

class InvDashboardScreen extends StatelessWidget {
  const InvDashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const kpis = [('Stock Value', '2.82M', 'SAR · 5 stores', M.blue), ('SKUs', '4,891', '+18 this week', M.blue), ('Low Stock', '47', 'reorder needed', M.orange), ('Out of Stock', '12', 'urgent', M.red)];
    const ops = [('INV-REC-0241', 'Receive', '+24,200', M.green), ('INV-ISS-0089', 'Issue', '-5,400', M.red), ('INV-TRF-0117', 'Transfer', '+20,970', M.blue), ('INV-ADJ-0058', 'Adjustment', '-307', M.orange)];
    const low = [('AGG-21044', 'Coarse Aggregate 20mm', 46, 80, 58), ('TMR-19080', 'Timber 2×4 Treated', 24, 60, 40), ('RBR-71203', 'Reinforcement Bar #6', 0, 100, 0)];
    return Scaffold(
      backgroundColor: M.bg,
      appBar: AppBar(backgroundColor: M.bg, elevation: 0, title: const Text('Inventory')),
      body: MScroll([
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
      MCard(accentColor: M.blue, title: 'Recent Operations', pad: 8, children: [
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
      MCard(accentColor: M.orange, title: 'Reorder Alerts', subtitle: '3 products at or below reorder level', children: [
        for (final p in low) _ReorderBar(p: p),
        const MBtn('Generate Purchase Order', icon: 'paperclip', full: true),
      ]),
    ]),
    );
  }
}
