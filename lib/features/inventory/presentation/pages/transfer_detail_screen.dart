import 'package:flutter/material.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';
import 'inventory_shared_widgets.dart';

class _TransferFlowCard extends StatelessWidget {
  final Color tone, deltaColor;
  final String label, store, ar, delta;
  const _TransferFlowCard(
      {required this.tone,
      required this.label,
      required this.store,
      required this.ar,
      required this.delta,
      required this.deltaColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: tint(tone, 0x0F),
          border: Border.all(color: tint(tone, 0x40)),
          borderRadius: BorderRadius.circular(10)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            width: 4,
            height: 56,
            decoration: BoxDecoration(
                color: tone, borderRadius: BorderRadius.circular(12))),
        const SizedBox(width: 12),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Eyebrow(label, color: tone, size: 9.5),
            const SizedBox(height: 6),
            Text(store,
                style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: M.fg1,
                    fontFamily: M.body)),
            Directionality(
                textDirection: TextDirection.rtl,
                child: Text(ar,
                    style: const TextStyle(
                        fontFamily: M.arabic, fontSize: 12, color: M.fg3))),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(top: 10),
              width: double.infinity,
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: M.border))),
              child: Text(delta,
                  style: TextStyle(
                      fontFamily: M.mono,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: deltaColor)),
            ),
          ]),
        ),
      ]),
    );
  }
}

class TransferDetailScreen extends StatelessWidget {
  const TransferDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const items = [
      ('Coarse Aggregate 20mm', '18 TON × 125.00', '2,250.00'),
      ('Reinforcement Bar #6', '240 PCS × 78.00', '18,720.00')
    ];
    return Scaffold(
      backgroundColor: M.bg,
      appBar: AppBar(backgroundColor: M.bg, elevation: 0, title: const Text('Transfer Detail')),
      body: MScroll([
      MCard(
          accentColor: M.blue,
          title: 'In Transit',
          trailing: const Pill('In Transit', tone: PillTone.warning),
          children: [
            const Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Text('INV-TRF-2024-0117',
                    style: TextStyle(
                        fontFamily: M.mono, fontSize: 12, color: M.blue))),
            _TransferFlowCard(
                tone: M.orange,
                label: 'From Store',
                store: 'ST-001 · Downtown Central',
                ar: 'متجر وسط المدينة',
                delta: '-54,892 SAR',
                deltaColor: M.red),
            Transform.translate(
              offset: const Offset(0, -6),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                    color: M.blue,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: tint(M.blue, 0x99),
                          blurRadius: 18,
                          offset: const Offset(0, 6))
                    ]),
                child: const Icon(Icons.keyboard_arrow_down_rounded,
                    size: 22, color: Colors.white),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -6),
              child: const _TransferFlowCard(
                  tone: M.green,
                  label: 'To Store',
                  store: 'ST-002 · King Fahd Warehouse',
                  ar: 'مستودع الملك فهد',
                  delta: '+54,892 SAR',
                  deltaColor: M.green),
            ),
          ]),
      MCard(
          accentColor: M.green,
          title: 'Items in Transit',
          subtitle: '2 lines · 258 units',
          pad: 8,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(children: [
                for (int i = 0; i < items.length; i++)
                  ItemLine(item: items[i], last: i == items.length - 1),
              ]),
            ),
          ]),
      const MCard(accentColor: M.blue, title: 'Logistics & Tracking', children: [
        KV('Carrier', 'Plate 4892-RKD'),
        KV('Driver', 'Mohammed S.'),
        KV('Expected Arrival', 'Dec 20, 2025', mono: true),
      ]),
      MBtn('Back to List',
          variant: MBtnVariant.secondary,
          icon: 'back',
          full: true,
          onTap: () => context.goTo('transferList')),
    ]),
    );
  }
}
