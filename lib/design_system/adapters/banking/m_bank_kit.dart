// ============================================================
// KIT — Banking primitives (port of MobileBanking shared parts)
// MMoney · MMethod · JournalPreview · FromToFlow · FxTiles ·
// AuditGrid · AmountHead · BankNote · BKV
// ============================================================

import 'package:flutter/material.dart';
import '../../components/layout/m_widgets.dart';
import '../../components/feedback/m_feedback.dart';

import 'package:gl_mobile_app/design_system/theme/super_core_theme_helpers.dart';
import 'package:super_core/super_core.dart' hide PillTone;
/// Large money input — currency prefix + big mono figure, accent border.
class MMoney extends StatelessWidget {
  final String label;
  final String value;
  final String currency;
  final Color? accent;
  final bool required;
  final String sign;
  const MMoney(
      {super.key,
      required this.label,
      required this.value,
      this.currency = 'SAR',
      this.accent,
      this.required = false,
      this.sign = ''});
  @override
  Widget build(BuildContext context) {
    final resolvedAccent = accent ?? SuperMaterialThemeData.of(context).colorScheme.primary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 7),
          child: Text.rich(TextSpan(
              children: [
                TextSpan(text: label.toUpperCase()),
                if (required)
                  TextSpan(text: ' *', style: TextStyle(color: SuperMaterialThemeData.of(context).colorScheme.error)),
              ],
              style: TextStyle(
                  fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                  letterSpacing: 0.5,
                  color: SuperMaterialThemeData.of(context).superTheme.fg2))),
        ),
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: SuperMaterialThemeData.of(context).superTheme.inputBg,
              border: Border.all(color: resolvedAccent),
              borderRadius: BorderRadius.circular(10)),
          child: Row(children: [
            Text(currency,
                style: TextStyle(
                    fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: SuperMaterialThemeData.of(context).superTheme.fg3)),
            const SizedBox(width: 10),
            Text('$sign$value',
                style: TextStyle(
                    fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: resolvedAccent,
                    letterSpacing: -0.3)),
          ]),
        ),
      ],
    );
  }
}

/// Payment-method chips (4-up).
class MMethod extends StatelessWidget {
  final String value;
  const MMethod({super.key, required this.value});
  @override
  Widget build(BuildContext context) {
    const methods = [
      ('cash', 'Cash'),
      ('cheque', 'Cheque'),
      ('wire', 'Wire'),
      ('card', 'Card')
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.only(bottom: 7),
            child: Eyebrow('Payment Method')),
        Row(children: [
          for (int i = 0; i < methods.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            Expanded(child: _chip(context, methods[i].$1, methods[i].$2)),
          ],
        ]),
      ],
    );
  }

  Widget _chip(BuildContext context, String id, String label) {
    final on = id == value;
    return Container(
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: on ? superCoreTint(SuperMaterialThemeData.of(context).colorScheme.primary, 0x1F) : SuperMaterialThemeData.of(context).superTheme.inputBg,
        border: Border.all(color: on ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
              color: on ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.fg2)),
    );
  }
}

/// Double-entry journal preview. Each row: (account, debit?, credit?).
class JournalPreview extends StatelessWidget {
  final List<(String account, String? debit, String? credit)> rows;
  final bool numbered;
  const JournalPreview({super.key, required this.rows, this.numbered = false});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      for (int i = 0; i < rows.length; i++)
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
              border: i == rows.length - 1
                  ? null
                  : Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
          child: Row(children: [
            if (numbered) ...[
              SizedBox(
                  width: 20,
                  child: Text((i + 1).toString().padLeft(2, '0'),
                      style: TextStyle(
                          fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg4))),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(rows[i].$1,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: SuperMaterialThemeData.of(context).superTheme.fg1,
                          fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                  const SizedBox(height: 4),
                  Pill(rows[i].$2 != null ? 'Debit' : 'Credit',
                      tone:
                          rows[i].$2 != null ? PillTone.info : PillTone.danger),
                ],
              ),
            ),
            Text(rows[i].$2 ?? rows[i].$3 ?? '',
                style: TextStyle(
                    fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: rows[i].$2 != null ? SuperMaterialThemeData.of(context).colorScheme.secondary : SuperMaterialThemeData.of(context).colorScheme.error)),
          ]),
        ),
    ]);
  }
}

class FlowCardData {
  final String label, title;
  final String? sub, meta;
  final Color? metaColor;
  const FlowCardData(
      {required this.label,
      required this.title,
      String? sub,
      String? subtitle,
      this.meta,
      this.metaColor})
      : sub = sub ?? subtitle;
}

/// Vertical From → To flow with a circular arrow between cards.
class FromToFlow extends StatelessWidget {
  final FlowCardData from, to;
  const FromToFlow({super.key, required this.from, required this.to});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _card(context, SuperMaterialThemeData.of(context).colorScheme.tertiary, from),
      Transform.translate(
        offset: const Offset(0, -6),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
              color: SuperMaterialThemeData.of(context).colorScheme.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.primary, 0x99),
                    blurRadius: 18,
                    offset: const Offset(0, 6))
              ]),
          child: const Icon(Icons.keyboard_arrow_down_rounded,
              size: 22, color: Colors.white),
        ),
      ),
      Transform.translate(
          offset: const Offset(0, -6), child: _card(context, SuperMaterialThemeData.of(context).colorScheme.secondary, to)),
    ]);
  }

  Widget _card(BuildContext context, Color tone, FlowCardData d) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: superCoreTint(tone, 0x0F),
            border: Border.all(color: superCoreTint(tone, 0x40)),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 4,
                height: 48,
                decoration: BoxDecoration(
                    color: tone, borderRadius: BorderRadius.circular(12))),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Eyebrow(d.label, color: tone, size: 9.5),
                  const SizedBox(height: 6),
                  Text(d.title,
                      style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: SuperMaterialThemeData.of(context).superTheme.fg1,
                          fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                  if (d.sub != null)
                    Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(d.sub!,
                            style: TextStyle(
                                fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
                                fontSize: 11,
                                color: SuperMaterialThemeData.of(context).superTheme.fg3))),
                  if (d.meta != null)
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.only(top: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border(top: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
                      child: Text(d.meta!,
                          style: TextStyle(
                              fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: d.metaColor ?? SuperMaterialThemeData.of(context).superTheme.fg2)),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
}

/// 3-up FX tiles. Each: (label, value, sub, accent?).
class FxTiles extends StatelessWidget {
  final List<(String, String, String, Color?)> tiles;
  const FxTiles({super.key, required this.tiles});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      for (int i = 0; i < tiles.length; i++) ...[
        if (i > 0) const SizedBox(width: 8),
        Expanded(child: _tile(context, tiles[i])),
      ],
    ]);
  }

  Widget _tile(BuildContext context, (String, String, String, Color?) t) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: SuperMaterialThemeData.of(context).superTheme.bg,
            border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.border),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Eyebrow(t.$1, color: SuperMaterialThemeData.of(context).superTheme.fg3, size: 8.5),
            const SizedBox(height: 6),
            Text(t.$2,
                style: TextStyle(
                    fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: t.$4 ?? SuperMaterialThemeData.of(context).superTheme.fg1,
                    letterSpacing: -0.3)),
            const SizedBox(height: 3),
            Text(t.$3,
                style: TextStyle(
                    fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 9.5, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
          ],
        ),
      );
}

/// 2-column audit grid. Each: (key, value, mono?).
class AuditGrid extends StatelessWidget {
  final List<(String, String, bool)> rows;
  const AuditGrid({super.key, required this.rows});
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 4.2,
      children: [
        for (final r in rows)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Eyebrow(r.$1, color: SuperMaterialThemeData.of(context).superTheme.fg3, size: 9.5),
              const SizedBox(height: 5),
              Text(r.$2,
                  style: TextStyle(
                      fontSize: 12.5,
                      color: SuperMaterialThemeData.of(context).superTheme.fg1,
                      fontFamily: r.$3 ? SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily : SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
            ],
          ),
      ],
    );
  }
}

/// Banking key/value row.
class BKV extends StatelessWidget {
  final String k, v;
  final bool mono, ar;
  const BKV(this.k, this.v, {super.key, this.mono = false, this.ar = false});
  @override
  Widget build(BuildContext context) => KV(k, v, mono: mono, ar: ar);
}

class BankNote extends StatelessWidget {
  final Color? tone;
  final String text;
  const BankNote(this.text, {super.key, this.tone});
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
          Container(
              width: 7,
              height: 7,
              margin: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(color: resolvedTone, shape: BoxShape.circle)),
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
