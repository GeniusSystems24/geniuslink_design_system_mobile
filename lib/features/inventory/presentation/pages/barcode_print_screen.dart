import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

class _BarcodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rng = math.Random(42);
    final paint = Paint()..color = const Color(0xFF0B0C10);
    double x = 0;
    while (x < size.width - 2) {
      final bw = rng.nextDouble() > 0.6
          ? 3.0
          : (rng.nextDouble() > 0.5 ? 2.0 : 1.0);
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
    const tpls = [
      ('sm', 'Small Tag', '38×19'),
      ('md', 'Medium Label', '50×30'),
      ('lg', 'Large Shelf', '80×40'),
      ('sh', 'Shipping', '100×50'),
    ];
    final size = tpls.firstWhere((t) => t.$1 == _tpl).$3;
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var marker = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon = MIcons.of('box');
    var marker2 = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var icon2 = MIcons.of('doc');
    var marker3 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var icon3 = MIcons.of('scan');
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: Text(GeniusLinkLocalization.of(context).barcodePrint), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
      body: MScroll([
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).preview,
          subtitle: 'Code 128 · $size mm',
          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 260),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFD4D4D8)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Portland Cement Type I',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Color(0xFF0B0C10),
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 36,
                        child: CustomPaint(
                          painter: _BarcodePainter(),
                          size: const Size(double.infinity, 36),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'CMT-90112',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 10,
                              color: Color(0xFF0B0C10),
                            ),
                          ),
                          Text(
                            'SAR 28.00',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: Color(0xFF0B0C10),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Center(
                        child: Text(
                          '6 281000 901127',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 9,
                            letterSpacing: 0.8,
                            color: Color(0xFF0B0C10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).labelTemplate,

          initiallyExpanded: true,
          accentColor: marker,
          icon: icon,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 2.6,
                children: [
                  for (final t in tpls)
                    GestureDetector(
                      onTap: () => setState(() => _tpl = t.$1),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _tpl == t.$1
                              ? superCoreTint(
                                  SuperMaterialThemeData.of(
                                    context,
                                  ).colorScheme.primary,
                                  0x14,
                                )
                              : SuperMaterialThemeData.of(
                                  context,
                                ).superTheme.inputBg,
                          border: Border.all(
                            color: _tpl == t.$1
                                ? SuperMaterialThemeData.of(
                                    context,
                                  ).colorScheme.primary
                                : SuperMaterialThemeData.of(
                                    context,
                                  ).superTheme.border,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              t.$2,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: SuperMaterialThemeData.of(
                                  context,
                                ).superTheme.fg1,
                                fontFamily: SuperMaterialThemeData.of(
                                  context,
                                ).textTheme.bodyMedium?.fontFamily,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${t.$3} mm',
                              style: TextStyle(
                                fontFamily: SuperMaterialThemeData.of(
                                  context,
                                ).textTheme.bodyMedium?.fontFamily,
                                fontSize: 10.5,
                                color: SuperMaterialThemeData.of(
                                  context,
                                ).superTheme.fg3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: 'Print Settings',

          initiallyExpanded: true,
          accentColor: marker3,
          icon: icon3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              IField(label: GeniusLinkLocalization.of(context).symbology, value: 'Code 128', select: true),
              IField(label: GeniusLinkLocalization.of(context).paper, value: 'A4 (210 × 297 mm)', select: true),
              IField(label: GeniusLinkLocalization.of(context).copiesPerItem, placeholder: '1', mono: true),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).queue,
          subtitle: '4 products · 12 labels · 1 sheet',
          initiallyExpanded: true,
          accentColor: marker2,
          icon: icon2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final q in const [
                ('STL-44021', 'Structural Steel I-Beam', 4),
                ('CMT-90112', 'Portland Cement Type I', 12),
                ('AGG-21044', 'Coarse Aggregate 20mm', 2),
                ('PLY-30022', 'Plywood Sheet 18mm', 6),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              q.$2,
                              style: TextStyle(
                                fontSize: 12.5,
                                color: SuperMaterialThemeData.of(
                                  context,
                                ).superTheme.fg1,
                                fontWeight: FontWeight.w500,
                                fontFamily: SuperMaterialThemeData.of(
                                  context,
                                ).textTheme.bodyMedium?.fontFamily,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              q.$1,
                              style: TextStyle(
                                fontFamily: SuperMaterialThemeData.of(
                                  context,
                                ).textTheme.bodyMedium?.fontFamily,
                                fontSize: 10.5,
                                color: SuperMaterialThemeData.of(
                                  context,
                                ).superTheme.fg3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '×${q.$3}',
                        style: TextStyle(
                          fontFamily: SuperMaterialThemeData.of(
                            context,
                          ).textTheme.bodyMedium?.fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: SuperMaterialThemeData.of(
                            context,
                          ).superTheme.fg1,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const ActionRow(primary: 'Print 24 Labels'),
      ]),
    );
  }
}
