// ============================================================
// KIT — Inventory/form primitives (port of window._minv)
// ------------------------------------------------------------
// ISection (collapsible) · IField · ITextarea · Scanner ·
// QtyStepper · ProductRow · AddProductBtn · UploadBox · IKV ·
// IToggle · InfoNote · ActionRow. Reused by Journal, Inventory,
// Currencies and Users screens.
// ============================================================

import 'package:flutter/material.dart';
import 'package:super_auto_suggestion_box/super_auto_suggestion_box.dart' as suggest;
import 'package:super_form_field/super_form_field.dart';
import '../../components/layout/m_icons.dart';
import '../../components/layout/m_widgets.dart';
import '../../components/buttons/m_buttons.dart';

import 'package:gl_mobile_app/design_system/theme/super_core_theme_helpers.dart';

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
    final leadingIcon = icon == null ? null : MIcons.of(icon!);
    if (select) {
      final options = value == null || value!.isEmpty
          ? const <SuperOption<String>>[]
          : <SuperOption<String>>[
              SuperOption<String>(value: value!, label: value!),
            ];
      return SuperSelectFormField<String>(
        label: label,
        options: options,
        initialValue: value,
        placeholder: placeholder,
        required: required,
        readOnly: true,
        searchable: options.length > 8,
        leadingIcon: leadingIcon,
        arabic: ar,
      );
    }

    return SuperTextFormField(
      label: label,
      initialValue: value ?? '',
      placeholder: placeholder,
      required: required,
      readOnly: true,
      leadingIcon: leadingIcon,
      arabic: ar,
    );
  }
}

class ITextarea extends StatelessWidget {
  final String label;
  final String? placeholder;

  const ITextarea({super.key, required this.label, this.placeholder});

  @override
  Widget build(BuildContext context) => SuperTextFormField(
        label: label,
        placeholder: placeholder,
        multiline: true,
        rows: 3,
      );
}

class UploadBox extends StatelessWidget {
  const UploadBox({super.key});

  @override
  Widget build(BuildContext context) => SuperAttachmentFormField(
        label: 'Attachments',
        accept: '.pdf,.jpg,.jpeg,.png',
        maxSizeMB: 10,
        maxFiles: 5,
        multiple: true,
        onBrowse: () async => const <SuperFile>[],
      );
}

class IToggle extends StatelessWidget {
  final String label;
  final bool on;

  const IToggle({super.key, required this.label, this.on = false});

  @override
  Widget build(BuildContext context) => SuperBoolFormField(
        title: label,
        initialValue: on,
        readOnly: true,
      );
}

class InfoNote extends StatelessWidget {
  final Color? tone;
  final String text;
  const InfoNote(this.text, {super.key, this.tone});
  @override
  Widget build(BuildContext context) {
    final resolvedTone = tone ?? SuperMaterialThemeData.of(context).colorScheme.tertiary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
          color: superCoreTint(resolvedTone, 0x14),
          border: Border.all(color: superCoreTint(resolvedTone, 0x40)),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, size: 14, color: resolvedTone),
          const SizedBox(width: 10),
          Expanded(
              child: Text(text,
                  style: TextStyle(
                      fontSize: 11.5,
                      color: SuperMaterialThemeData.of(context).superTheme.fg2,
                      height: 1.5,
                      fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily))),
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
  const ActionRow(
      {super.key,
      this.secondary = 'Cancel',
      required this.primary,
      this.icon = 'check',
      this.onSecondary,
      this.onPrimary});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: MBtn(secondary,
              variant: MBtnVariant.secondary, full: true, onTap: onSecondary)),
      const SizedBox(width: 10),
      Expanded(child: MBtn(primary, icon: icon, full: true, onTap: onPrimary)),
    ]);
  }
}

/// Product line row with editable qty + price/total.
class ProductRow extends StatelessWidget {
  final String name, sku;
  final SuperNumericFieldController qtyController;
  final String price, total, currency;
  final bool last;
  const ProductRow(
      {super.key,
      required this.name,
      required this.sku,
      required this.qtyController,
      required this.price,
      required this.total,
      this.currency = '\$',
      this.last = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
          border:
              last ? null : Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
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
                    Text(name,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: SuperMaterialThemeData.of(context).superTheme.fg1,
                            fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                    const SizedBox(height: 2),
                    Text('SKU: $sku',
                        style: TextStyle(
                            fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                  ],
                ),
              ),
              Icon(Icons.delete_outline_rounded, size: 16, color: SuperMaterialThemeData.of(context).superTheme.fg3),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Eyebrow('Qty', color: SuperMaterialThemeData.of(context).superTheme.fg3, size: 9.5),
                const SizedBox(width: 10),
                SizedBox(
                  width: 140,
                  child: SuperNumericFormField(
                    controller: qtyController,
                    decimals: 0,
                    step: 1,
                    min: 1,
                    allowNegative: false,
                    stepper: true,
                    density: FieldDensity.compact,
                  ),
                ),
              ]),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('$currency$price / unit',
                      style: TextStyle(
                          fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                  const SizedBox(height: 2),
                  Text('$currency$total',
                      style: TextStyle(
                          fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: SuperMaterialThemeData.of(context).superTheme.fg1)),
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

/// Barcode scanner with a searchable product picker. Fires [onPick] when a
/// product is selected (raw label, e.g. "CMT-90112 — Portland Cement Type I").
class Scanner extends StatefulWidget {
  final ValueChanged<String>? onPick;

  const Scanner({super.key, this.onPick});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final _skuController = suggest.AutoSuggestionsBoxController<String>(
    source: suggest.SuggestionSources.strings([
      'CMT-90112 — Portland Cement Type I',
      'STL-44021 — Structural Steel I-Beam',
      'RBR-33210 — Rebar 16mm',
      'PLY-55109 — Plywood 18mm',
      'CBL-66112 — PVC Conduit 25mm',
    ]),
    allowFreeText: true,
  );
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _skuController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _commit(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) return;
    widget.onPick?.call(normalized);
    _skuController.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 168,
          decoration: BoxDecoration(
              color: SuperPalette.bluePalette.darkSurface2, borderRadius: BorderRadius.circular(12)),
          child: CustomPaint(
            painter: _ScanBrackets(SuperMaterialThemeData.of(context).colorScheme.primary),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.qr_code_2_rounded, size: 42, color: SuperMaterialThemeData.of(context).superTheme.fg4),
                const SizedBox(height: 12),
                Text('Point your camera at a barcode to scan',
                    style: TextStyle(
                        fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        suggest.AutoSuggestionsBox<String>(
          controller: _skuController,
          focusNode: _focusNode,
          hintText: 'Search or type SKU manually…',
          bare: true,
          fieldHeight: 46,
          leading: const Icon(Icons.qr_code_scanner_rounded, size: 18),
          onSelected: (item) => _commit(item.label),
          onSubmitted: _commit,
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
        painter: _DashRect(SuperMaterialThemeData.of(context).superTheme.borderStrong),
        child: Center(
          child: Text(label.toUpperCase(),
              style: TextStyle(
                  color: SuperMaterialThemeData.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  letterSpacing: 0.7,
                  fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
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
  final Color borderColor;
  const _DashRect(this.borderColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Offset.zero & size, const Radius.circular(10)));
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
  bool shouldRepaint(covariant _DashRect old) => old.borderColor != borderColor;
}

class _ScanBrackets extends CustomPainter {
  final Color accentColor;
  const _ScanBrackets(this.accentColor);

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = superCoreTint(accentColor, 0x99)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
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
  bool shouldRepaint(covariant _ScanBrackets old) => old.accentColor != accentColor;
}
