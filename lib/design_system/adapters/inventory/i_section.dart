// ============================================================
// KIT — Inventory/form primitives (port of window._minv)
// ------------------------------------------------------------
// ISection (collapsible) · IField · ITextarea · Scanner ·
// QtyStepper · ProductRow · AddProductBtn · UploadBox · IKV ·
// IToggle · InfoNote · ActionRow. Reused by Journal, Inventory,
// Currencies and Users screens.
// ============================================================

import 'package:flutter/material.dart';
import 'package:super_form_field/super_form_field.dart';

/// Collapsible section card: colored marker · icon · title · chevron.
class ISection extends StatefulWidget {
  final IconData? icon;
  final String title;
  final Color? marker;
  final String? sub;
  final bool defaultOpen;
  final List<Widget> children;
  final Widget? right;
  const ISection({
    super.key,
    required this.icon,
    required this.title,
    Color? marker,
    Color? accentColor,
    String? sub,
    String? subtitle,
    this.defaultOpen = true,
    this.children = const [],
    Widget? right,
    Widget? trailing,
  }) : marker = marker ?? accentColor,
       sub = sub ?? subtitle,
       right = right ?? trailing;

  @override
  State<ISection> createState() => _ISectionState();
}

class _ISectionState extends State<ISection> {
  late bool _open = widget.defaultOpen;

  @override
  Widget build(BuildContext context) {
    final marker =
        widget.marker ?? SuperMaterialThemeData.of(context).colorScheme.primary;
    return Container(
      decoration: BoxDecoration(
        color: SuperMaterialThemeData.of(context).superTheme.surface,
        border: Border.all(
          color: SuperMaterialThemeData.of(context).superTheme.border,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
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
                  Container(
                    width: 4,
                    height: 36,
                    decoration: BoxDecoration(
                      color: marker,
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  if (widget.icon != null) ...[
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: marker.withAlpha(0x1F.clamp(0, 255).toInt()),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(widget.icon, size: 16, color: marker),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title.toUpperCase(),
                          style: TextStyle(
                            fontFamily: SuperMaterialThemeData.of(
                              context,
                            ).textTheme.bodyMedium?.fontFamily,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.5,
                            letterSpacing: 0.7,
                            color: SuperMaterialThemeData.of(
                              context,
                            ).superTheme.fg1,
                          ),
                        ),
                        if (widget.sub != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              widget.sub!,
                              style: TextStyle(
                                fontFamily: SuperMaterialThemeData.of(
                                  context,
                                ).textTheme.bodyMedium?.fontFamily,
                                fontSize: 11.5,
                                color: SuperMaterialThemeData.of(
                                  context,
                                ).superTheme.fg3,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (widget.right != null) widget.right!,
                  AnimatedRotation(
                    turns: _open ? 0 : -0.25,
                    duration: const Duration(milliseconds: 150),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 18,
                      color: SuperMaterialThemeData.of(context).superTheme.fg3,
                    ),
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
