import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';
import '../../../../workspace/presentation/bloc/nav_cubit.dart';
import 'inventory_shared_widgets.dart';

class ReceiveDetailScreen extends StatelessWidget {
  final NavCubit nav;
  const ReceiveDetailScreen({super.key, required this.nav});
  @override
  Widget build(BuildContext context) {
    const items = [
      ('Portland Cement Type I', '400 BAG × 24.50', '9,800.00'),
      ('Structural Steel I-Beam', '32 PCS × 450.00', '14,400.00')
    ];
    return MScroll([
      MCard(
          marker: M.green,
          title: 'Received Value',
          sub: 'INV-REC-2024-0241 · Dec 16, 2025',
          right: const Pill('Posted'),
          children: const [
            Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text('SAR',
                      style: TextStyle(
                          fontFamily: M.mono, fontSize: 14, color: M.fg3)),
                  SizedBox(width: 8),
                  Text('+24,200.00',
                      style: TextStyle(
                          fontFamily: M.mono,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: M.green,
                          letterSpacing: -0.6)),
                ]),
          ]),
      const MCard(marker: M.blue, title: 'Receipt Information', children: [
        KV('Serial No', 'INV-REC-2024-0241', mono: true),
        KV('Receiving Store', 'King Fahd Warehouse'),
        KV('Supplier', 'ABC Trading Co.'),
        KV('PO Reference', 'PO-2024-1182', mono: true),
      ]),
      MCard(
          marker: M.green,
          title: 'Items',
          sub: '2 lines · 432 units',
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
      const MCard(marker: M.orange, title: 'Audit Information', children: [
        AuditGridLite(rows: [
          ('Received By', 'Layla A. (ID: 12)', false),
          ('Received At', 'Dec 16, 14:32', true),
          ('Linked Journal', 'JV-2024-0241', true),
          ('Audit Hash', 'b3e1…a072', true)
        ]),
      ]),
      MBtn('Back to List',
          variant: MBtnVariant.secondary,
          icon: 'back',
          full: true,
          onTap: () => nav.back('more')),
    ]);
  }
}

class AuditGridLite extends StatelessWidget {
  final List<(String, String, bool)> rows;
  const AuditGridLite({super.key, required this.rows});
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 4.2,
      children: [
        for (final r in rows)
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Eyebrow(r.$1, color: M.fg3, size: 9.5),
                const SizedBox(height: 5),
                Text(r.$2,
                    style: TextStyle(
                        fontSize: 12.5,
                        color: M.fg1,
                        fontFamily: r.$3 ? M.mono : M.body)),
              ]),
      ],
    );
  }
}
