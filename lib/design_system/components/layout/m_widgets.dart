// ============================================================
// GeniusLink Mobile — Layout widgets
// Eyebrow · MCard · MField · Mini · Avatar · KV · MScroll
// File placement:  lib/design_system/components/layout/m_widgets.dart
// ============================================================

import 'package:flutter/material.dart';
import '../../tokens/m_colors.dart';

export '../../tokens/m_colors.dart';

class Eyebrow extends StatelessWidget {
  final String text;
  final Color? color;
  final double size;
  const Eyebrow(this.text, {super.key, this.color, this.size = 10});
  @override
  Widget build(BuildContext context) => Text(text.toUpperCase(), style: TextStyle(fontFamily: M.body, fontWeight: FontWeight.w700, fontSize: size, letterSpacing: 0.6, color: color ?? M.fg2));
}

class MCard extends StatelessWidget {
  final List<Widget> children;
  final Color? marker;
  final String? title, sub;
  final Widget? right;
  final double pad;
  const MCard({super.key, this.children = const [], this.marker, this.title, this.sub, this.right, this.pad = 16});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(pad),
      decoration: BoxDecoration(color: M.surface, border: Border.all(color: M.border), borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (title != null) ...[
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (marker != null) Container(width: 4, constraints: const BoxConstraints(minHeight: 32), margin: const EdgeInsetsDirectional.only(end: 10), decoration: BoxDecoration(color: marker, borderRadius: BorderRadius.circular(12))),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title!, style: const TextStyle(fontFamily: M.body, fontWeight: FontWeight.w700, fontSize: 15, color: M.fg1)),
              if (sub != null) Padding(padding: const EdgeInsets.only(top: 3), child: Text(sub!, style: const TextStyle(fontFamily: M.body, fontSize: 11.5, color: M.fg3))),
            ])),
            if (right != null) right!,
          ]),
          if (children.isNotEmpty) const SizedBox(height: 14),
        ],
        for (int i = 0; i < children.length; i++) ...[
          if (i > 0) const SizedBox(height: 14),
          children[i],
        ],
      ]),
    );
  }
}

class MField extends StatelessWidget {
  final String label;
  final String? placeholder, value;
  final bool ar, mono, required;
  const MField({super.key, required this.label, this.placeholder, this.value, this.ar = false, this.mono = false, this.required = false});

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null && value!.isNotEmpty;
    return Directionality(
      textDirection: ar ? TextDirection.rtl : TextDirection.ltr,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(padding: const EdgeInsets.only(bottom: 7), child: Text.rich(TextSpan(children: [
          TextSpan(text: label.toUpperCase()),
          if (required) const TextSpan(text: ' *', style: TextStyle(color: M.red)),
        ], style: const TextStyle(fontFamily: M.body, fontWeight: FontWeight.w700, fontSize: 10, letterSpacing: 0.5, color: M.fg2)))),
        Container(
          height: 46, padding: const EdgeInsets.symmetric(horizontal: 14),
          alignment: ar ? Alignment.centerRight : Alignment.centerLeft,
          decoration: BoxDecoration(color: M.input, border: Border.all(color: M.borderStrong), borderRadius: BorderRadius.circular(8)),
          child: Text(hasValue ? value! : (placeholder ?? ''), maxLines: 1, overflow: TextOverflow.ellipsis,
              style: TextStyle(fontFamily: mono ? M.mono : (ar ? M.arabic : M.body), fontSize: 14, color: hasValue ? M.fg1 : M.fg3)),
        ),
      ]),
    );
  }
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
      decoration: BoxDecoration(color: hi ? tint(M.green, 0x14) : M.bg, border: Border.all(color: hi ? tint(M.green, 0x4D) : M.border), borderRadius: BorderRadius.circular(10)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Eyebrow(label, color: M.fg3, size: 9.5),
        Padding(padding: const EdgeInsets.only(top: 6), child: Text(value, style: TextStyle(fontFamily: M.mono, fontSize: 20, fontWeight: FontWeight.w600, color: hi ? M.green : M.fg1))),
        if (sub != null) Padding(padding: const EdgeInsets.only(top: 3), child: Text(sub!, style: const TextStyle(fontFamily: M.mono, fontSize: 10, color: M.fg3))),
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
      decoration: BoxDecoration(color: M.input, shape: BoxShape.circle, border: Border.all(color: M.borderStrong)),
      child: Text(initials, style: TextStyle(fontFamily: M.display, fontWeight: FontWeight.w700, fontSize: size * 0.36, color: M.fg2)),
    );
  }
}

class KV extends StatelessWidget {
  final String k, v;
  final bool mono, ar;
  const KV(this.k, this.v, {super.key, this.mono = false, this.ar = false});
  @override
  Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Eyebrow(k, color: M.fg3),
        const SizedBox(width: 12),
        Expanded(child: Text(v, textAlign: TextAlign.end, style: TextStyle(fontSize: 13.5, color: M.fg1, fontFamily: ar ? M.arabic : (mono ? M.mono : M.body)))),
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
