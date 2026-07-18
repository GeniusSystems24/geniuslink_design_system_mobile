// ============================================================
// VIEW — Settings · Platform (ports MobileSettingsPlatform)
// setIntegrations · setWebhooks · setApiKeys
// setNotifications · setBilling · setBackup
// ============================================================

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../design_system/kit.dart';
import '../../../../core/bloc/form_cubit.dart';

class _PToggle extends StatelessWidget {
  final bool on;
  final VoidCallback onTap;

  const _PToggle({required this.on, required this.onTap});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 64,
        child: SuperBoolFormField(
          key: ValueKey(on),
          initialValue: on,
          enabledLabel: '',
          disabledLabel: '',
          onChanged: (_) => onTap(),
        ),
      );
}

class _PMono extends StatelessWidget {
  final String name;
  final Color tone;
  const _PMono({required this.name, required this.tone});
  @override
  Widget build(BuildContext context) => Container(
        width: 36, height: 36, alignment: Alignment.center,
        decoration: BoxDecoration(color: superCoreTint(tone, 0x1F), borderRadius: BorderRadius.circular(8)),
        child: Text(name[0], style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.headlineMedium?.fontFamily, fontWeight: FontWeight.w800, fontSize: 15, color: tone)),
      );
}

List<(String, Color, List<(String, Color, String, bool)>)> _integrationGroups(BuildContext context) {
  final colors = SuperMaterialThemeData.of(context).colorScheme;
  return [
    ('Banking & Payments', colors.primary, [('SAMA Open Banking', colors.primary, 'Statement sync', true), ('Mada Gateway', colors.secondary, 'Local card acquiring', true), ('Stripe', const Color(0xFF635BFF), 'International cards', false)]),
    ('E-commerce', colors.secondary, [('Salla', colors.secondary, 'Orders & inventory', true), ('Zid', colors.tertiary, 'Order import', false), ('Shopify', const Color(0xFF95BF47), 'Multi-channel', false)]),
    ('Email & Comms', colors.tertiary, [('SendGrid', colors.primary, 'Document email', true), ('Slack', const Color(0xFFE01E5A), 'Alert notifications', false)]),
  ];
}

class IntegrationsScreen extends StatelessWidget {
  const IntegrationsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final init = <String, bool>{};
    final groups = _integrationGroups(context);
    for (final g in groups) { for (final it in g.$3) { init[it.$1] = it.$4; } }
    return BlocProvider<FormCubit>(
      create: (_) => FormCubit(initial: {'state': init}, onSubmit: (_) async {}),
      child: const _IntegrationsView(),
    );
  }
}

class _IntegrationsView extends StatelessWidget {
  const _IntegrationsView();
  @override
  Widget build(BuildContext context) {
    final form = context.read<FormCubit>();
    return BlocBuilder<FormCubit, FormData>(
      builder: (context, fstate) {
        final st = Map<String, bool>.from(fstate.value<Map>('state') ?? const {});
        final groups = _integrationGroups(context);
        void toggle(String k) => form.setField('state', {...st, k: !(st[k] ?? false)});
        return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, elevation: 0, title: const Text('Integrations')),
      body: MScroll([
          for (final g in groups)
            MCard(title: g.$1, accentColor: g.$2, pad: 8, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(children: [
                  for (int i = 0; i < g.$3.length; i++)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(border: i < g.$3.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                      child: Row(children: [
                        _PMono(name: g.$3[i].$1, tone: g.$3[i].$2),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(g.$3[i].$1, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                          const SizedBox(height: 1),
                          Text(g.$3[i].$3, style: TextStyle(fontSize: 11.5, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                        ])),
                        if (st[g.$3[i].$1] == true) const Padding(padding: EdgeInsets.only(right: 8), child: Pill('On')),
                        _PToggle(on: st[g.$3[i].$1] ?? false, onTap: () => toggle(g.$3[i].$1)),
                      ]),
                    ),
                ]),
              ),
            ]),
        ]),
    );
      },
    );
  }
}

class WebhooksScreen extends StatelessWidget {
  const WebhooksScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormCubit>(
      create: (_) => FormCubit(initial: const {
        'hooks': [
          ['erp.acme.sa/hooks/postings', 'journal.posted,deposit.created', true, '200 · 2m'],
          ['api.najd.io/gl/inventory', 'inventory.adjusted,transfer.created', true, '200 · 1h'],
          ['hooks.slack.com/services/T0…', 'approval.requested', false, '410 · 3d'],
        ]
      }, onSubmit: (_) async {}),
      child: const _WebhooksView(),
    );
  }
}

class _WebhooksView extends StatelessWidget {
  const _WebhooksView();
  @override
  Widget build(BuildContext context) {
    final form = context.read<FormCubit>();
    return BlocBuilder<FormCubit, FormData>(
      builder: (context, fstate) {
        final hooks = [for (final h in (fstate.value<List>('hooks') ?? const [])) List<Object>.from(h as List)];
        void toggle(int i) { final n = [for (final h in hooks) List<Object>.from(h)]; n[i][2] = !(n[i][2] as bool); form.setField('hooks', n); }
        return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, elevation: 0, title: const Text('Webhooks')),
      body: MScroll([
          MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: '${hooks.length} Endpoints', subtitle: 'HMAC-signed · retried 5× on failure', pad: 8, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(children: [
                for (int i = 0; i < hooks.length; i++)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(border: i < hooks.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                    child: Column(children: [
                      Row(children: [
                        Icon(MIcons.of('link'), size: 15, color: hooks[i][2] as bool ? SuperMaterialThemeData.of(context).colorScheme.secondary : SuperMaterialThemeData.of(context).superTheme.fg4),
                        const SizedBox(width: 10),
                        Expanded(child: Text(hooks[i][0] as String, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg1))),
                        _PToggle(on: hooks[i][2] as bool, onTap: () => toggle(i)),
                      ]),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Row(children: [
                          Expanded(child: Wrap(spacing: 6, runSpacing: 6, children: [
                            for (final e in (hooks[i][1] as String).split(','))
                              Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2), decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.inputBg, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(4)), child: Text(e, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10, color: SuperMaterialThemeData.of(context).superTheme.fg2))),
                          ])),
                          Text(hooks[i][3] as String, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10, color: (hooks[i][3] as String).startsWith('2') ? SuperMaterialThemeData.of(context).colorScheme.secondary : SuperMaterialThemeData.of(context).colorScheme.error)),
                        ]),
                      ),
                    ]),
                  ),
              ]),
            ),
          ]),
          const MBtn('Add Endpoint', icon: 'plus', full: true),
        ]),
    );
      },
    );
  }
}

class ApiKeysScreen extends StatelessWidget {
  const ApiKeysScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormCubit>(
      create: (_) => FormCubit(initial: const {
        'keys': [
          ['Production · Server', 'gl_live_8f2a', 'read, write', '2m ago', false],
          ['Reporting · Read-only', 'gl_live_3b71', 'read', 'Yesterday', false],
          ['Staging', 'gl_test_aa90', 'read, write', 'Never', false],
        ]
      }, onSubmit: (_) async {}),
      child: const _ApiKeysView(),
    );
  }
}

class _ApiKeysView extends StatelessWidget {
  const _ApiKeysView();
  @override
  Widget build(BuildContext context) {
    final form = context.read<FormCubit>();
    return BlocBuilder<FormCubit, FormData>(
      builder: (context, fstate) {
        final keys = [for (final k in (fstate.value<List>('keys') ?? const [])) List<Object>.from(k as List)];
        List<List<Object>> clone() => [for (final k in keys) List<Object>.from(k)];
        void toggleReveal(int i) { final n = clone(); n[i][4] = !(n[i][4] as bool); form.setField('keys', n); }
        void revoke(int i) { final n = clone()..removeAt(i); form.setField('keys', n); }
        return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, elevation: 0, title: const Text('API Keys')),
      body: MScroll([
          InfoNote("A key's secret is shown only once at creation. Revoke and re-issue anytime.", tone: SuperMaterialThemeData.of(context).colorScheme.tertiary),
          MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: '${keys.length} Active Keys', pad: 8, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(children: [
                for (int i = 0; i < keys.length; i++)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(border: i < keys.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(keys[i][0] as String, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                        GestureDetector(onTap: () => revoke(i), child: Text('Revoke', style: TextStyle(color: SuperMaterialThemeData.of(context).colorScheme.error, fontSize: 11, fontWeight: FontWeight.w700, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily))),
                      ]),
                      const SizedBox(height: 6),
                      Row(children: [
                        Expanded(child: Text(keys[i][4] as bool ? '${keys[i][1]}_4d9e1c7b22f0' : '${keys[i][1]}••••••••', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11.5, color: SuperMaterialThemeData.of(context).superTheme.fg2))),
                        GestureDetector(onTap: () => toggleReveal(i), child: Text(keys[i][4] as bool ? 'Hide' : 'Reveal', style: TextStyle(color: SuperMaterialThemeData.of(context).colorScheme.primary, fontSize: 11, fontWeight: FontWeight.w700, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily))),
                      ]),
                      const SizedBox(height: 4),
                      Text('${keys[i][2]} · used ${keys[i][3]}', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10.5, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                    ]),
                  ),
              ]),
            ),
          ]),
          const MBtn('Create Key', icon: 'plus', full: true),
        ]),
    );
      },
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  static const _cats = [('Postings & Ledger', 'Entries posted, reversed'), ('Approvals', 'Wires & adjustments'), ('Inventory', 'Low stock, transfers'), ('Security', 'Sign-ins, key changes'), ('Billing', 'Invoices & usage')];
  static const _chans = ['Email', 'In-app', 'SMS'];
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormCubit>(
      create: (_) => FormCubit(initial: const {
        'prefs': [[true, true, false], [true, true, true], [true, true, false], [true, true, true], [true, false, false]]
      }, onSubmit: (_) async {}),
      child: const _NotificationsView(),
    );
  }
}

class _NotificationsView extends StatelessWidget {
  const _NotificationsView();
  @override
  Widget build(BuildContext context) {
    final form = context.read<FormCubit>();
    return BlocBuilder<FormCubit, FormData>(
      builder: (context, fstate) {
        final prefs = [for (final r in (fstate.value<List>('prefs') ?? const [])) List<bool>.from(r as List)];
        void toggle(int ci, int chi) { final n = [for (final r in prefs) List<bool>.from(r)]; n[ci][chi] = !n[ci][chi]; form.setField('prefs', n); }
        return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, elevation: 0, title: const Text('Notifications')),
      body: MScroll([
          MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Preferences', subtitle: 'Toggle a channel per category', pad: 8, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
                  child: Row(children: [
                    const Spacer(),
                    for (final c in NotificationsScreen._chans) SizedBox(width: 50, child: Center(child: Text(c.toUpperCase(), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 9, letterSpacing: 0.4, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)))),
                  ]),
                ),
                for (int ci = 0; ci < NotificationsScreen._cats.length; ci++)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(border: ci < NotificationsScreen._cats.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                    child: Row(children: [
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(NotificationsScreen._cats[ci].$1, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                        const SizedBox(height: 1),
                        Text(NotificationsScreen._cats[ci].$2, style: TextStyle(fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                      ])),
                      for (int chi = 0; chi < NotificationsScreen._chans.length; chi++)
                        SizedBox(
                          width: 50,
                          child: Center(
                            child: GestureDetector(
                              onTap: () => toggle(ci, chi),
                              child: Container(
                                width: 26, height: 26, alignment: Alignment.center,
                                decoration: BoxDecoration(color: prefs[ci][chi] ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.inputBg, border: Border.all(color: prefs[ci][chi] ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.borderStrong), borderRadius: BorderRadius.circular(7)),
                                child: prefs[ci][chi] ? const Icon(Icons.check_rounded, size: 14, color: Colors.white) : null,
                              ),
                            ),
                          ),
                        ),
                    ]),
                  ),
              ]),
            ),
          ]),
          MBtn('Save Preferences', icon: 'check', full: true, onTap: form.submit),
        ]),
    );
      },
    );
  }
}

class BillingScreen extends StatelessWidget {
  const BillingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const usage = [('Users', 6.0, 25.0, ''), ('Transactions · MTD', 4120.0, 100000.0, ''), ('Storage', 2.4, 50.0, ' GB')];
    const plans = [('Starter', '0', 'free', ['1 workspace', '3 users', '500 entries/mo'], false), ('Business', '349', '/mo', ['Unlimited entries', '25 users', 'All integrations'], true), ('Enterprise', 'Custom', '', ['SSO & SAML', 'Dedicated support', 'Audit retention 10y'], false)];
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, elevation: 0, title: const Text('Billing')),
      body: MScroll([
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Current Plan', trailing: const Pill('Active'), children: [
        Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Text('Business', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.headlineMedium?.fontFamily, fontWeight: FontWeight.w700, fontSize: 22, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
          SizedBox(width: 10),
          Text.rich(TextSpan(children: [TextSpan(text: '349.00 SAR', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 14, color: SuperMaterialThemeData.of(context).superTheme.fg2)), TextSpan(text: '/mo', style: TextStyle(fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3))])),
        ]),
        Text('Renews Jan 1, 2026', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
        Column(children: [
          for (final u in usage) _UsageBar(label: u.$1, val: u.$2, max: u.$3, unit: u.$4),
        ]),
      ]),
      for (final p in plans)
        Container(
          decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.surface, border: Border.all(color: p.$5 ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(18),
          child: Stack(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Text(p.$1, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
              const SizedBox(height: 14),
              Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
                Text(p.$2, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 26, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).superTheme.fg1, letterSpacing: -0.5)),
                const SizedBox(width: 4),
                Text(p.$3, style: TextStyle(fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
              ]),
              const SizedBox(height: 14),
              for (final f in p.$4)
                Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(children: [Icon(MIcons.of('check'), size: 14, color: SuperMaterialThemeData.of(context).colorScheme.secondary), const SizedBox(width: 8), Text(f, style: TextStyle(fontSize: 12.5, color: SuperMaterialThemeData.of(context).superTheme.fg2, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily))])),
              const SizedBox(height: 14),
              MBtn(p.$5 ? 'Current Plan' : (p.$1 == 'Enterprise' ? 'Contact Sales' : 'Upgrade'), variant: p.$5 ? MBtnVariant.secondary : MBtnVariant.primary, full: true),
            ]),
            if (p.$5) PositionedDirectional(top: 0, end: 0, child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.primary, 0x24), borderRadius: BorderRadius.circular(4)), child: Text('CURRENT', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w700, letterSpacing: 0.6, color: SuperMaterialThemeData.of(context).colorScheme.primary, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)))),
          ]),
        ),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.tertiary, title: 'Recent Invoices', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (final inv in const [('INV-GL-2025-012', 'Dec 01', '349.00'), ('INV-GL-2025-011', 'Nov 01', '349.00'), ('INV-GL-2025-010', 'Oct 01', '349.00')])
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
                child: Row(children: [
                  Expanded(child: Text(inv.$1, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).colorScheme.primary))),
                  Text(inv.$2, style: TextStyle(fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                  const SizedBox(width: 12),
                  Text(inv.$3, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
                  const SizedBox(width: 10),
                  const Pill('Paid'),
                ]),
              ),
          ]),
        ),
      ]),
    ]),
    );
  }
}

class _UsageBar extends StatelessWidget {
  final String label;
  final double val, max;
  final String unit;
  const _UsageBar({required this.label, required this.val, required this.max, required this.unit});
  @override
  Widget build(BuildContext context) {
    final pct = math.min(100, ((val / max) * 100).round());
    final fmt = val > 100 ? val.toInt().toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]},') : val.toString();
    final maxFmt = max.toInt().toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]},');
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Eyebrow(label, color: SuperMaterialThemeData.of(context).superTheme.fg3, size: 10),
          Text('$fmt$unit / $maxFmt', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg2)),
        ]),
        const SizedBox(height: 5),
        ClipRRect(borderRadius: BorderRadius.circular(999), child: Stack(children: [Container(height: 6, color: SuperMaterialThemeData.of(context).superTheme.inputBg), FractionallySizedBox(widthFactor: pct / 100, child: Container(height: 6, color: pct > 85 ? SuperMaterialThemeData.of(context).colorScheme.tertiary : SuperMaterialThemeData.of(context).colorScheme.primary))])),
      ]),
    );
  }
}

class BackupScreen extends StatelessWidget {
  const BackupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormCubit>(
      create: (_) => FormCubit(initial: const {
        'auto': true,
        'scope': {'Ledger': true, 'Inventory': true, 'Contacts': true, 'Documents': false},
      }, onSubmit: (_) async {}),
      child: const _BackupView(),
    );
  }
}

class _BackupView extends StatelessWidget {
  const _BackupView();
  @override
  Widget build(BuildContext context) {
    final form = context.read<FormCubit>();
    return BlocBuilder<FormCubit, FormData>(
      builder: (context, fstate) {
        final auto = fstate.value<bool>('auto') ?? true;
        final scope = Map<String, bool>.from(fstate.value<Map>('scope') ?? const {});
        void toggleScope(String k) => form.setField('scope', {...scope, k: !(scope[k] ?? false)});
        return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, elevation: 0, title: const Text('Backup')),
      body: MScroll([
          MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Automatic Backups', trailing: const Pill('Healthy'), children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Daily encrypted snapshot', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                SizedBox(height: 3),
                Text('Last · Dec 19 03:00 · 248 MB', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
              ])),
              _PToggle(on: auto, onTap: () => form.setField('auto', !auto)),
            ]),
          ]),
          ISection(icon: 'download', title: 'Manual Export', sub: 'Download a portable copy', marker: SuperMaterialThemeData.of(context).colorScheme.primary, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(padding: EdgeInsets.only(bottom: 7), child: Eyebrow('Data Scope')),
              GridView.count(
                crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 4.4,
                children: [
                  for (final k in scope.keys)
                    GestureDetector(
                      onTap: () => toggleScope(k),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                        decoration: BoxDecoration(color: scope[k]! ? superCoreTint(SuperMaterialThemeData.of(context).colorScheme.primary, 0x1F) : SuperMaterialThemeData.of(context).superTheme.inputBg, border: Border.all(color: scope[k]! ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(8)),
                        child: Row(children: [
                          Container(width: 18, height: 18, alignment: Alignment.center, decoration: BoxDecoration(color: scope[k]! ? SuperMaterialThemeData.of(context).colorScheme.primary : Colors.transparent, border: Border.all(color: scope[k]! ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.borderStrong), borderRadius: BorderRadius.circular(4)), child: scope[k]! ? const Icon(Icons.check_rounded, size: 12, color: Colors.white) : null),
                          const SizedBox(width: 9),
                          Text(k, style: TextStyle(fontSize: 13, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                        ]),
                      ),
                    ),
                ],
              ),
            ]),
            const TSelect(label: 'Format', value: 'CSV (zipped)', options: ['CSV (zipped)', 'JSON', 'Excel (XLSX)']),
            const MBtn('Generate Export', icon: 'download', full: true),
          ]),
          MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.tertiary, title: 'Export History', pad: 8, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(children: [
                for (final f in const [('full-export-2025-12-15.zip', '248 MB · Dec 15'), ('ledger-q4-2025.csv', '12 MB · Dec 02'), ('contacts-2025-11.json', '1.1 MB · Nov 20')])
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
                    child: Row(children: [
                      Icon(MIcons.of('doc'), size: 16, color: SuperMaterialThemeData.of(context).colorScheme.primary),
                      const SizedBox(width: 10),
                      Expanded(child: Text(f.$1, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11.5, color: SuperMaterialThemeData.of(context).superTheme.fg1))),
                      Text(f.$2, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10.5, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                      const SizedBox(width: 10),
                      Icon(MIcons.of('download'), size: 15, color: SuperMaterialThemeData.of(context).superTheme.fg3),
                    ]),
                  ),
              ]),
            ),
          ]),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.error, 0x0F), border: Border.all(color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.error, 0x4D)), borderRadius: BorderRadius.circular(10)),
            child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Delete workspace', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                SizedBox(height: 2),
                Text('30-day grace period.', style: TextStyle(fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
              ])),
              MBtn('Delete', variant: MBtnVariant.danger, icon: 'trash'),
            ]),
          ),
        ]),
    );
      },
    );
  }
}
