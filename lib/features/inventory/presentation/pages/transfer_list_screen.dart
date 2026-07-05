import 'package:flutter/material.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';

class TransferListScreen extends StatefulWidget {
  const TransferListScreen({super.key});
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
    return Scaffold(
      backgroundColor: M.bg,
      appBar: AppBar(backgroundColor: M.bg, elevation: 0, title: const Text('Stock Transfers')),
      body: MScroll([
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
      MCard(accentColor: M.blue, title: '${visible.length} Transfers', pad: 8, children: [
        for (int i = 0; i < visible.length; i++)
          GestureDetector(
            onTap: () => context.goTo('transferDetail'),
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
    ]),
    );
  }
}
