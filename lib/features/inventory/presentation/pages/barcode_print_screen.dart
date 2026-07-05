import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';

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
    return Scaffold(
      backgroundColor: M.bg,
      appBar: AppBar(backgroundColor: M.bg, elevation: 0, title: const Text('Barcode Print')),
      body: MScroll([
      MCard(accentColor: M.green, title: 'Preview', subtitle: 'Code 128 · $size mm', children: [
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
    ]),
    );
  }
}
