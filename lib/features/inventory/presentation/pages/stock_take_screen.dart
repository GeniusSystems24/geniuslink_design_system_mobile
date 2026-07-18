import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';

class _CountRow extends StatelessWidget {
  final (String, String, int, int) item;
  final bool last;
  const _CountRow({required this.item, required this.last});
  @override
  Widget build(BuildContext context) {
    final pending = item.$4 == -1;
    final delta = pending ? 0 : item.$4 - item.$3;
    final tone = pending ? SuperThemeData.dark.fg3 : (delta == 0 ? SuperTokens.success : (delta < 0 ? SuperTokens.danger : SuperTokens.warning));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(border: last ? null : Border(bottom: BorderSide(color: SuperThemeData.dark.border))),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(item.$2, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SuperThemeData.dark.fg1, fontFamily: SuperTokens.bodyFont)),
          const SizedBox(height: 2),
          Text('${item.$1} · exp ${item.$3}', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 11, color: SuperThemeData.dark.fg3)),
        ])),
        if (pending)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: SuperThemeData.dark.inputBg, border: Border.all(color: SuperThemeData.dark.border), borderRadius: BorderRadius.circular(6)),
            child: Text('COUNT', style: TextStyle(fontFamily: SuperTokens.bodyFont, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: SuperThemeData.dark.fg3)),
          )
        else
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('${item.$4}', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 14, fontWeight: FontWeight.w700, color: SuperThemeData.dark.fg1)),
            Text('${delta > 0 ? '+' : ''}$delta', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 11, fontWeight: FontWeight.w700, color: tone)),
          ]),
      ]),
    );
  }
}

class StockTakeScreen extends StatelessWidget {
  const StockTakeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const items = [
      ('STL-44021', 'Structural Steel I-Beam', 142, 140), ('CMT-90112', 'Portland Cement Type I', 1820, 1820),
      ('AGG-21044', 'Coarse Aggregate 20mm', 48, 46), ('PLY-30022', 'Plywood Sheet 18mm', 312, -1),
      ('PNT-55310', 'Epoxy Floor Coating', 88, -1), ('RBR-71203', 'Reinforcement Bar #6', 0, -1),
    ];
    return Scaffold(
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Stock Take')),
      body: MScroll([
      MCard(accentColor: SuperTokens.accent, title: 'STK-2024-0014', subtitle: 'King Fahd Warehouse · Started Dec 18, 09:14', trailing: const Pill('In Progress', tone: PillTone.warning), children: [
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end, children: [
            Eyebrow('3 of 6 counted', size: 10),
            Text('50%', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 22, fontWeight: FontWeight.w700, color: SuperTokens.accent)),
          ]),
          const SizedBox(height: 8),
          ClipRRect(borderRadius: BorderRadius.circular(999), child: Stack(children: [
            Container(height: 8, color: SuperThemeData.dark.inputBg),
            FractionallySizedBox(widthFactor: 0.5, child: Container(height: 8, color: SuperTokens.accent)),
          ])),
        ]),
        GridView.count(crossAxisCount: 3, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1.4, children: const [
          Mini(label: 'Match', value: '1'), Mini(label: 'Short', value: '2'), Mini(label: 'Over', value: '0'),
        ]),
      ]),
      MCard(accentColor: SuperTokens.success, title: 'Count Sheet', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < items.length; i++) _CountRow(item: items[i], last: i == items.length - 1),
          ]),
        ),
      ]),
      const ActionRow(primary: 'Post Stock Take'),
    ]),
    );
  }
}
