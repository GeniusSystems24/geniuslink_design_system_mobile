// ============================================================
// GeniusLink Mobile — Layout widgets
// Eyebrow · MCard · MField · Mini · Avatar · KV · MScroll
// File placement:  lib/design_system/components/layout/m_widgets.dart
// ============================================================

import 'package:flutter/material.dart';
import 'package:super_form_field/super_form_field.dart';
import 'package:super_core/super_core.dart';
import 'package:gl_mobile_app/design_system/theme/super_core_theme_helpers.dart';
class Eyebrow extends StatelessWidget {
  final String text;
  final Color? color;
  final double size;
  const Eyebrow(this.text, {super.key, this.color, this.size = 10});
  @override
  Widget build(BuildContext context) => Text(text.toUpperCase(), style: TextStyle(fontFamily: SuperTokens.bodyFont, fontWeight: FontWeight.w700, fontSize: size, letterSpacing: 0.6, color: color ?? SuperThemeData.dark.fg2));
}

class MCard extends StatefulWidget {
  final List<Widget> children;
  final Color? accentColor;
  final String? title, subtitle;
  final Widget? trailing;
  final IconData? icon;
  final double pad;
  final bool collapsible;
  final bool initiallyExpanded;

  const MCard({
    super.key,
    this.children = const [],
    this.accentColor,
    this.title,
    this.subtitle,
    this.trailing,
    this.icon,
    this.pad = 16,
    this.collapsible = false,
    this.initiallyExpanded = true,
  });

  @override
  State<MCard> createState() => _MCardState();
}

class _MCardState extends State<MCard> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  void _toggle() {
    if (widget.collapsible) setState(() => _expanded = !_expanded);
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.accentColor;

    return Container(
      padding: EdgeInsets.all(widget.pad),
      decoration: BoxDecoration(
        color: SuperThemeData.dark.surface,
        border: Border.all(color: SuperThemeData.dark.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) ...[
            GestureDetector(
              onTap: widget.collapsible ? _toggle : null,
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  Expanded(
                    child: _MCardTitle(
                      title: widget.title!,
                      subtitle: widget.subtitle,
                      accentColor: accent,
                      icon: widget.icon,
                      trailing: widget.trailing,
                    ),
                  ),
                  if (widget.collapsible)
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: SuperThemeData.dark.fg3,
                        size: 22,
                      ),
                    ),
                ],
              ),
            ),
          ],
          ClipRect(
            child: AnimatedAlign(
              alignment: Alignment.topCenter,
              heightFactor: _expanded ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.title != null)
                    const SizedBox(height: 14),
                  ...widget.children,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MCardTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color? accentColor;
  final IconData? icon;
  final Widget? trailing;

  const _MCardTitle({
    required this.title,
    this.subtitle,
    this.accentColor,
    this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null)
          Container(
            width: 24,
            height: subtitle != null ? 40 : 24,
            decoration: BoxDecoration(
              color: accentColor?.withValues(alpha: 0.12),
              borderRadius: const BorderRadiusDirectional.horizontal(
                start: Radius.circular(2),
              ),
            ),
            child: Icon(icon, size: 14, color: accentColor),
          ),
        Container(
          width: 4,
          height: subtitle != null ? 40 : 24,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontFamily: SuperTokens.bodyFont, fontWeight: FontWeight.w700, fontSize: 15, color: SuperThemeData.dark.fg1),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Tooltip(
                  message: subtitle!,
                  child: Text(
                    subtitle!.toUpperCase(),
                    style: TextStyle(fontFamily: SuperTokens.bodyFont, fontWeight: FontWeight.w700, fontSize: 10, letterSpacing: 0.5, color: SuperThemeData.dark.fg3),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 12),
          trailing!,
        ],
      ],
    );
  }
}

class MField extends StatelessWidget {
  final String label;
  final String? placeholder, value;
  final bool ar, mono, required;

  const MField({
    super.key,
    required this.label,
    this.placeholder,
    this.value,
    this.ar = false,
    this.mono = false,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) => SuperTextFormField(
        label: label,
        initialValue: value ?? '',
        placeholder: placeholder,
        required: required,
        arabic: ar,
        readOnly: true,
      );
}

class Mini extends StatelessWidget {
  final String label, value;
  final String? sub;
  final bool hi;
  const Mini({super.key, required this.label, required this.value, this.sub, this.hi = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: hi ? superCoreTint(SuperTokens.success, 0x14) : SuperThemeData.dark.bg, border: Border.all(color: hi ? superCoreTint(SuperTokens.success, 0x4D) : SuperThemeData.dark.border), borderRadius: BorderRadius.circular(10)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Eyebrow(label, color: SuperThemeData.dark.fg3, size: 9.5),
        Padding(padding: const EdgeInsets.only(top: 6), child: Text(value, style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 20, fontWeight: FontWeight.w600, color: hi ? SuperTokens.success : SuperThemeData.dark.fg1))),
        if (sub != null) Padding(padding: const EdgeInsets.only(top: 3), child: Text(sub!, style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 10, color: SuperThemeData.dark.fg3))),
      ]),
    );
  }
}

class Avatar extends StatelessWidget {
  final String name;
  final double size;
  const Avatar(this.name, {super.key, this.size = 40});
  @override
  Widget build(BuildContext context) {
    final parts = name.trim().split(RegExp(r'\s+'));
    final initials = parts.take(2).map((w) => w.isEmpty ? '' : w[0]).join();
    return Container(
      width: size, height: size, alignment: Alignment.center,
      decoration: BoxDecoration(color: SuperThemeData.dark.inputBg, shape: BoxShape.circle, border: Border.all(color: SuperThemeData.dark.borderStrong)),
      child: Text(initials, style: TextStyle(fontFamily: SuperTokens.displayFont, fontWeight: FontWeight.w700, fontSize: size * 0.36, color: SuperThemeData.dark.fg2)),
    );
  }
}

class KV extends StatelessWidget {
  final String k, v;
  final bool mono, ar;
  const KV(this.k, this.v, {super.key, this.mono = false, this.ar = false});
  @override
  Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Eyebrow(k, color: SuperThemeData.dark.fg3),
        const SizedBox(width: 12),
        Expanded(child: Text(v, textAlign: TextAlign.end, style: TextStyle(fontSize: 13.5, color: SuperThemeData.dark.fg1, fontFamily: ar ? SuperTokens.arabicFont : (mono ? SuperTokens.monoFont : SuperTokens.bodyFont)))),
      ]);
}

class MScroll extends StatelessWidget {
  final List<Widget> children;
  final double pad;
  const MScroll(this.children, {super.key, this.pad = 16});
  @override
  Widget build(BuildContext context) => ListView.separated(
        padding: EdgeInsets.fromLTRB(pad, pad, pad, 24),
        itemCount: children.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (_, i) => children[i],
      );
}
