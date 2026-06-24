// ============================================================
// KIT — Inventory/form primitives (port of window._minv)
// ------------------------------------------------------------
// ISection (collapsible) · IField · ITextarea · Scanner ·
// QtyStepper · ProductRow · AddProductBtn · UploadBox · IKV ·
// IToggle · InfoNote · ActionRow. Reused by Journal, Inventory,
// Currencies and Users screens.
// ============================================================

import 'package:flutter/material.dart';
import '../../components/layout/m_icons.dart';
import '../../components/layout/m_widgets.dart';
import '../../components/buttons/m_buttons.dart';

/// Collapsible section card: colored marker · icon · title · chevron.
class ISection extends StatefulWidget {
  final String icon;
  final String title;
  final Color marker;
  final String? sub;
  final bool defaultOpen;
  final List<Widget> children;
  final Widget? right;
  const ISection({
    super.key,
    required this.icon,
    required this.title,
    this.marker = M.blue,
    this.sub,
    this.defaultOpen = true,
    this.children = const [],
    this.right,
  });

  @override
  State<ISection> createState() => _ISectionState();
}

class _ISectionState extends State<ISection> {
  late bool _open = widget.defaultOpen;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: M.surface, border: Border.all(color: M.border), borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () => setState(() => _open = !_open),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 14, 16, 14),
              child: Row(
                children: [
                  Container(width: 4, height: 36, decoration: BoxDecoration(color: widget.marker, borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)))),
                  const SizedBox(width: 12),
                  Container(
                    width: 30, height: 30,
                    decoration: BoxDecoration(color: tint(widget.marker, 0x1F), borderRadius: BorderRadius.circular(8)),
                    child: Icon(MIcons.of(widget.icon), size: 16, color: widget.marker),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title.toUpperCase(),
                            style: const TextStyle(fontFamily: M.body, fontWeight: FontWeight.w700, fontSize: 12.5, letterSpacing: 0.7, color: M.fg1)),
                        if (widget.sub != null) Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(widget.sub!, style: const TextStyle(fontFamily: M.body, fontSize: 11.5, color: M.fg3)),
                        ),
                      ],
                    ),
                  ),
                  if (widget.right != null) widget.right!,
                  AnimatedRotation(
                    turns: _open ? 0 : -0.25,
                    duration: const Duration(milliseconds: 150),
                    child: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: M.fg3),
                  ),
                ],
              ),
            ),
          ),
          if (_open)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (int i = 0; i < widget.children.length; i++) ...[
                    if (i > 0) const SizedBox(height: 14),
                    widget.children[i],
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// Read-only flexible field (plain / locked / select / leading-icon / arabic).
class IField extends StatelessWidget {
  final String label;
  final String? value;
  final String? placeholder;
  final String? icon;
  final bool locked;
  final bool select;
  final bool mono;
  final bool ar;
  final bool required;
  const IField({
    super.key,
    required this.label,
    this.value,
    this.placeholder,
    this.icon,
    this.locked = false,
    this.select = false,
    this.mono = false,
    this.ar = false,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null && value!.isNotEmpty;
    return Directionality(
      textDirection: ar ? TextDirection.rtl : TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Text.rich(TextSpan(children: [
              TextSpan(text: label.toUpperCase()),
              if (required) const TextSpan(text: ' *', style: TextStyle(color: M.red)),
            ], style: const TextStyle(fontFamily: M.body, fontWeight: FontWeight.w700, fontSize: 10, letterSpacing: 0.5, color: M.fg2))),
          ),
          Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(color: M.input, border: Border.all(color: M.borderStrong), borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                if (icon != null) ...[Icon(MIcons.of(icon!), size: 16, color: M.fg3), const SizedBox(width: 10)],
                Expanded(
                  child: Text(hasValue ? value! : (placeholder ?? ''),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontFamily: mono ? M.mono : (ar ? M.arabic : M.body), fontSize: 14, color: hasValue ? M.fg1 : M.fg3)),
                ),
                if (locked) const Icon(Icons.lock_outline_rounded, size: 14, color: M.fg3),
                if (select) const Icon(Icons.keyboard_arrow_down_rounded, size: 15, color: M.fg3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ITextarea extends StatelessWidget {
  final String label;
  final String? placeholder;
  const ITextarea({super.key, required this.label, this.placeholder});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.only(bottom: 7), child: Eyebrow(label)),
        Container(
          constraints: const BoxConstraints(minHeight: 88),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(color: M.input, border: Border.all(color: M.borderStrong), borderRadius: BorderRadius.circular(8)),
          child: Text(placeholder ?? '', style: const TextStyle(fontFamily: M.body, fontSize: 14, color: M.fg3)),
        ),
      ],
    );
  }
}

class UploadBox extends StatelessWidget {
  const UploadBox({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 110),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: M.input, borderRadius: BorderRadius.circular(10)),
      child: CustomPaint(
        painter: _DashRect(),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload_outlined, size: 26, color: M.fg3),
            SizedBox(height: 8),
            Text('Click to upload or drag and drop', style: TextStyle(fontSize: 13, color: M.fg1, fontFamily: M.body, fontWeight: FontWeight.w600)),
            SizedBox(height: 4),
            Text('PDF, JPG, PNG (MAX 10MB)', style: TextStyle(fontFamily: M.mono, fontSize: 10.5, color: M.fg3)),
          ],
        ),
      ),
    );
  }
}

class IToggle extends StatelessWidget {
  final String label;
  final bool on;
  const IToggle({super.key, required this.label, this.on = false});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Eyebrow(label),
        Container(
          width: 42, height: 24,
          decoration: BoxDecoration(color: on ? M.blue : M.input, border: Border.all(color: M.borderStrong), borderRadius: BorderRadius.circular(999)),
          child: Align(
            alignment: on ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(width: 18, height: 18, margin: const EdgeInsets.symmetric(horizontal: 2), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
          ),
        ),
      ],
    );
  }
}

class InfoNote extends StatelessWidget {
  final Color tone;
  final String text;
  const InfoNote(this.text, {super.key, this.tone = M.orange});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(color: tint(tone, 0x14), border: Border.all(color: tint(tone, 0x40)), borderRadius: BorderRadius.circular(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, size: 14, color: tone),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 11.5, color: M.fg2, height: 1.5, fontFamily: M.body))),
        ],
      ),
    );
  }
}

class ActionRow extends StatelessWidget {
  final String secondary;
  final String primary;
  final String icon;
  final VoidCallback? onSecondary;
  final VoidCallback? onPrimary;
  const ActionRow({super.key, this.secondary = 'Cancel', required this.primary, this.icon = 'check', this.onSecondary, this.onPrimary});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: MBtn(secondary, variant: MBtnVariant.secondary, full: true, onTap: onSecondary)),
      const SizedBox(width: 10),
      Expanded(child: MBtn(primary, icon: icon, full: true, onTap: onPrimary)),
    ]);
  }
}

/// Quantity stepper (− value +).
class QtyStepper extends StatelessWidget {
  final int value;
  const QtyStepper({super.key, required this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: M.input, border: Border.all(color: M.border), borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(width: 36, height: 36, child: Icon(Icons.remove_rounded, size: 15, color: M.fg2)),
        SizedBox(width: 34, child: Text('$value', textAlign: TextAlign.center, style: const TextStyle(fontFamily: M.mono, fontSize: 14, fontWeight: FontWeight.w600, color: M.fg1))),
        const SizedBox(width: 36, height: 36, child: Icon(Icons.add_rounded, size: 15, color: M.fg2)),
      ]),
    );
  }
}

/// Product line row with qty stepper + price/total.
class ProductRow extends StatelessWidget {
  final String name, sku;
  final int qty;
  final String price, total, currency;
  final bool last;
  const ProductRow({super.key, required this.name, required this.sku, required this.qty, required this.price, required this.total, this.currency = '\$', this.last = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(border: last ? null : const Border(bottom: BorderSide(color: M.border))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
                    const SizedBox(height: 2),
                    Text('SKU: $sku', style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)),
                  ],
                ),
              ),
              const Icon(Icons.delete_outline_rounded, size: 16, color: M.fg3),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Eyebrow('Qty', color: M.fg3, size: 9.5),
                const SizedBox(width: 10),
                QtyStepper(value: qty),
              ]),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('$currency$price / unit', style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)),
                  const SizedBox(height: 2),
                  Text('$currency$total', style: const TextStyle(fontFamily: M.mono, fontSize: 16, fontWeight: FontWeight.w700, color: M.fg1)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddProductBtn extends StatelessWidget {
  final String label;
  const AddProductBtn({super.key, this.label = '+ Add Another Product'});
  @override
  Widget build(BuildContext context) => _DashedButton(label: label);
}

/// Barcode scanner placeholder with corner brackets.
class Scanner extends StatelessWidget {
  const Scanner({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 168,
          decoration: BoxDecoration(color: M.card2, borderRadius: BorderRadius.circular(12)),
          child: CustomPaint(
            painter: _ScanBrackets(),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.qr_code_2_rounded, size: 42, color: M.fg4),
                SizedBox(height: 12),
                Text('Point your camera at a barcode to scan', style: TextStyle(fontSize: 12, color: M.fg3, fontFamily: M.body)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 46,
          child: MBtn('Scan Manually', variant: MBtnVariant.secondary, full: true),
        ),
      ],
    );
  }
}

/// A dashed-border full-width button used for "add line / add product".
class _DashedButton extends StatelessWidget {
  final String label;
  const _DashedButton({required this.label});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      width: double.infinity,
      child: CustomPaint(
        painter: _DashRect(),
        child: Center(
          child: Text(label.toUpperCase(),
              style: const TextStyle(color: M.blue, fontWeight: FontWeight.w700, fontSize: 12, letterSpacing: 0.7, fontFamily: M.body)),
        ),
      ),
    );
  }
}

/// Public dashed "+ Add Line" button.
class AddLineBtn extends StatelessWidget {
  final String label;
  const AddLineBtn({super.key, this.label = '+ Add Line'});
  @override
  Widget build(BuildContext context) => _DashedButton(label: label);
}

class _DashRect extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = M.borderStrong..style = PaintingStyle.stroke..strokeWidth = 1.5;
    final path = Path()..addRRect(RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)));
    const dash = 6.0, gap = 4.0;
    for (final m in path.computeMetrics()) {
      double d = 0;
      while (d < m.length) {
        canvas.drawPath(m.extractPath(d, d + dash), paint);
        d += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _ScanBrackets extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = tint(M.blue, 0x99)..style = PaintingStyle.stroke..strokeWidth = 2..strokeCap = StrokeCap.round;
    const m = 18.0, len = 26.0;
    void corner(Offset o, int sx, int sy) {
      canvas.drawLine(o, o.translate(len * sx, 0), p);
      canvas.drawLine(o, o.translate(0, len * sy), p);
    }
    corner(const Offset(m, m), 1, 1);
    corner(Offset(size.width - m, m), -1, 1);
    corner(Offset(m, size.height - m), 1, -1);
    corner(Offset(size.width - m, size.height - m), -1, -1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
