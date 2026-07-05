import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';

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

class WarehousesListScreen extends StatelessWidget {
  const WarehousesListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const stores = [('ST-001', 'Downtown Central', 1248, 1800, 'Layla Ahmed', '342.8K'), ('ST-002', 'King Fahd Warehouse', 4892, 6000, 'Mohammed Saleh', '1.82M'), ('ST-003', 'Jeddah Showroom', 412, 600, 'Sara Al-Otaibi', '128.6K'), ('ST-004', 'Dammam Distribution', 2104, 2400, 'Khalid Al-Rashid', '624.2K'), ('ST-005', 'Madinah Outlet', 0, 500, '— Unassigned —', '0.00')];
    return Scaffold(
      backgroundColor: M.bg,
      appBar: AppBar(backgroundColor: M.bg, elevation: 0, title: const Text('Warehouses')),
      body: MScroll([
      MCard(accentColor: M.blue, title: '5 Warehouses', subtitle: 'Capacity & assigned manager', pad: 8, children: [
        for (int i = 0; i < stores.length; i++) _WarehouseRow(s: stores[i], last: i == stores.length - 1),
      ]),
    ]),
    );
  }
}
