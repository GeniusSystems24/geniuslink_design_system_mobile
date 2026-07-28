// ============================================================
// GeniusLink Mobile — Layout widgets
// Eyebrow · MCard · MField · Mini · Avatar · KV · MScroll
// File placement:  lib/design_system/components/layout/m_widgets.dart
// ============================================================

import 'package:flutter/material.dart';
import 'package:super_form_field/super_form_field.dart';
import 'package:gl_mobile_app/design_system/theme/super_core_theme_helpers.dart';

class Eyebrow extends StatelessWidget {
  final String text;
  final Color? color;
  final double size;
  const Eyebrow(this.text, {super.key, this.color, this.size = 10});
  @override
  Widget build(BuildContext context) => Text(
    text.toUpperCase(),
    style: TextStyle(
      fontFamily: SuperMaterialThemeData.of(
        context,
      ).textTheme.bodyMedium?.fontFamily,
      fontWeight: FontWeight.w700,
      fontSize: size,
      letterSpacing: 0.6,
      color: color ?? SuperMaterialThemeData.of(context).superTheme.fg2,
    ),
  );
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
    decoration: InputDecoration(labelText: label, hintText: placeholder),
    initialValue: value ?? '',
    required: required,
    arabic: ar,
    readOnly: true,
  );
}

class Mini extends StatelessWidget {
  final String label, value;
  final String? sub;
  final bool hi;
  const Mini({
    super.key,
    required this.label,
    required this.value,
    this.sub,
    this.hi = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: hi
            ? superCoreTint(
                SuperMaterialThemeData.of(context).colorScheme.secondary,
                0x14,
              )
            : SuperMaterialThemeData.of(context).superTheme.bg,
        border: Border.all(
          color: hi
              ? superCoreTint(
                  SuperMaterialThemeData.of(context).colorScheme.secondary,
                  0x4D,
                )
              : SuperMaterialThemeData.of(context).superTheme.border,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Eyebrow(
            label,
            color: SuperMaterialThemeData.of(context).superTheme.fg3,
            size: 9.5,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              value,
              style: TextStyle(
                fontFamily: SuperMaterialThemeData.of(
                  context,
                ).textTheme.bodyMedium?.fontFamily,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: hi
                    ? SuperMaterialThemeData.of(context).colorScheme.secondary
                    : SuperMaterialThemeData.of(context).superTheme.fg1,
              ),
            ),
          ),
          if (sub != null)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                sub!,
                style: TextStyle(
                  fontFamily: SuperMaterialThemeData.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                  fontSize: 10,
                  color: SuperMaterialThemeData.of(context).superTheme.fg3,
                ),
              ),
            ),
        ],
      ),
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
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: SuperMaterialThemeData.of(context).superTheme.inputBg,
        shape: BoxShape.circle,
        border: Border.all(
          color: SuperMaterialThemeData.of(context).superTheme.borderStrong,
        ),
      ),
      child: Text(
        initials,
        style: TextStyle(
          fontFamily: SuperMaterialThemeData.of(
            context,
          ).textTheme.headlineMedium?.fontFamily,
          fontWeight: FontWeight.w700,
          fontSize: size * 0.36,
          color: SuperMaterialThemeData.of(context).superTheme.fg2,
        ),
      ),
    );
  }
}

class KV extends StatelessWidget {
  final String k, v;
  final bool mono, ar;
  const KV(this.k, this.v, {super.key, this.mono = false, this.ar = false});
  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Eyebrow(k, color: SuperMaterialThemeData.of(context).superTheme.fg3),
      const SizedBox(width: 12),
      Expanded(
        child: Text(
          v,
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 13.5,
            color: SuperMaterialThemeData.of(context).superTheme.fg1,
            fontFamily: ar
                ? SuperMaterialThemeData.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily
                : (mono
                      ? SuperMaterialThemeData.of(
                          context,
                        ).textTheme.bodyMedium?.fontFamily
                      : SuperMaterialThemeData.of(
                          context,
                        ).textTheme.bodyMedium?.fontFamily),
          ),
        ),
      ),
    ],
  );
}

class MScroll extends StatelessWidget {
  final List<Widget> children;
  final double pad;
  const MScroll(this.children, {super.key, this.pad = 16});
  @override
  Widget build(BuildContext context) => ListView.separated(
    padding: EdgeInsets.fromLTRB(pad, pad, pad, 24),
    itemCount: children.length,
    separatorBuilder: (_, _) => const SizedBox(height: 14),
    itemBuilder: (_, i) => children[i],
  );
}
