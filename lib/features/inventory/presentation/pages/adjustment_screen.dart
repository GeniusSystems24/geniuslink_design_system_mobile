import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';

class _AdjLine extends StatelessWidget {
  final (String, String, int, int, String) item;
  final bool last;
  const _AdjLine({required this.item, required this.last});
  @override
  Widget build(BuildContext context) {
    final delta = item.$4 - item.$3;
    final pos = delta > 0;
    final tone = delta == 0 ? M.fg2 : (pos ? M.green : M.red);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          border:
              last ? null : const Border(bottom: BorderSide(color: M.border))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(item.$2,
                  style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: M.fg1,
                      fontFamily: M.body)),
              const SizedBox(height: 2),
              Text('${item.$1} · ${item.$5}',
                  style: const TextStyle(
                      fontFamily: M.mono, fontSize: 11, color: M.fg3)),
            ]),
          ),
          Text('${pos ? '+' : ''}$delta',
              style: TextStyle(
                  fontFamily: M.mono,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: tone)),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          Text.rich(TextSpan(children: [
            const TextSpan(text: 'System ', style: TextStyle(color: M.fg3)),
            TextSpan(text: '${item.$3}', style: const TextStyle(color: M.fg2))
          ], style: const TextStyle(fontFamily: M.mono, fontSize: 11))),
          const SizedBox(width: 16),
          Text.rich(TextSpan(children: [
            const TextSpan(text: 'Counted ', style: TextStyle(color: M.fg3)),
            TextSpan(
                text: '${item.$4}',
                style:
                    const TextStyle(color: M.fg1, fontWeight: FontWeight.w600))
          ], style: const TextStyle(fontFamily: M.mono, fontSize: 11))),
        ]),
      ]),
    );
  }
}

class AdjustmentScreen extends StatelessWidget {
  const AdjustmentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const items = [
      ('STL-44021', 'Structural Steel I-Beam', 142, 140, 'Damaged · 2 units'),
      (
        'CMT-90112',
        'Portland Cement Type I',
        1820,
        1834,
        'Receiving miscount · +14'
      ),
      ('AGG-21044', 'Coarse Aggregate 20mm', 48, 46, 'Spillage · 2 tons'),
    ];
    return Scaffold(
      backgroundColor: M.bg,
      appBar: AppBar(backgroundColor: M.bg, elevation: 0, title: const Text('Inventory Adjustment')),
      body: MScroll([
      const ISection(
          icon: 'box',
          title: 'Adjustment Details',
          marker: M.blue,
          children: [
            IField(
                label: 'Serial No',
                value: 'INV-ADJ-2024-0058',
                mono: true,
                locked: true),
            IField(
                label: 'Reason', value: 'Physical Stock Count', select: true),
            IField(
                label: 'Store',
                placeholder: 'Search store…',
                icon: 'store',
                required: true),
            IField(
                label: 'Count Date',
                placeholder: 'mm/dd/yyyy',
                mono: true,
                icon: 'calendar'),
          ]),
      const MCard(
          accentColor: M.orange,
          title: 'Variance Summary',
          subtitle: 'Net financial impact of this reconciliation',
          children: [
            Row(children: [
              Expanded(child: Mini(label: 'Lines Adjusted', value: '3')),
              SizedBox(width: 12),
              Expanded(
                  child: Mini(
                      label: 'Net Adjustment', value: '-307.00', sub: 'SAR')),
            ]),
          ]),
      MCard(accentColor: M.green, title: 'Adjustment Lines', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < items.length; i++)
              _AdjLine(item: items[i], last: i == items.length - 1),
          ]),
        ),
      ]),
      const ISection(
          icon: 'doc',
          title: 'Documentation & Approval',
          marker: M.orange,
          children: [
            ITextarea(
                label: 'Adjustment Notes',
                placeholder: 'Auditor name, witness, count session reference…'),
            UploadBox(),
            InfoNote(
                'Adjustments above 1,000 SAR require dual approval. This entry posts to the audit log immediately and notifies the controller.'),
          ]),
      const ActionRow(primary: 'Post Adjustment'),
    ]),
    );
  }
}
