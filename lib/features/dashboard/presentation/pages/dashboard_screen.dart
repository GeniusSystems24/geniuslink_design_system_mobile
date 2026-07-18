// ============================================================
// VIEW — Dashboard tab
// KPI row · cash-flow bars · balances · recent ops · alerts
// ============================================================

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';

// ── Dashboard content data ───────────────────────────────────
class _Flow {
  final String m;
  final double inV, outV;
  const _Flow(this.m, this.inV, this.outV);
}

final _cashflow = <_Flow>[
  _Flow('Jan', 62, 48), _Flow('Feb', 71, 52), _Flow('Mar', 58, 61), _Flow('Apr', 80, 55),
  _Flow('May', 74, 58), _Flow('Jun', 92, 63), _Flow('Jul', 88, 70), _Flow('Aug', 79, 66),
  _Flow('Sep', 96, 72), _Flow('Oct', 104, 78), _Flow('Nov', 98, 81), _Flow('Dec', 112, 74),
];

final _balances = [
  ('1100', 'Bank · NCB Main', '186,420.00', 64),
  ('1001', 'Cash Box', '42,500.00', 15),
  ('1200', 'Inventory (WIP)', '54,890.00', 19),
  ('1101', 'Bank · Al Rajhi', '6,240.00', 2),
];

final _recent = [
  ('JV-2024-0226', 'Mixed sale & revenue', '+3,400.00', true, '10:14'),
  ('EXT-2024-0311', 'Wire · Global Steel', '−12,045.00', false, '11:02'),
  ('DEP-2024-0182', 'Deposit · Customer 102', '+5,000.00', true, '09:42'),
  ('INV-ISS-0089', 'Issue · Project A-92', '−6,600.00', false, '08:30'),
];

List<(Color, String, String, String)> _alerts(BuildContext context) {
  final colors = SuperMaterialThemeData.of(context).colorScheme;
  return [
    (colors.tertiary, 'info', '1 entry out of balance', 'JV-2024-0225 · draft'),
    (colors.error, 'info', '2 SKUs out of stock', 'Downtown Central Store'),
    (colors.primary, 'lock', '3 wires await approval', 'External transfers · 41,200 SAR'),
    (colors.secondary, 'check', 'Period Nov 2024 closed', 'Locked Dec 01'),
  ];
}

// ── DashboardScreen ─────────────────────────────────────────
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(
        backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
        elevation: 0,
        title: const Text('Dashboard'),
      ),
      body: _buildDashboardContent(context),
    );
  }

  Widget _buildDashboardContent(BuildContext context) {
    return MScroll([
      Padding(
        padding: EdgeInsets.only(top: 0),
        child: Text('Fiscal 2024 · as of Dec 19, 2025', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11.5, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
      ),
      // KPI grid
      GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.55,
        children: [
          _Kpi(label: 'Total Assets', value: '289,050', delta: '+4.2%', up: true),
          _Kpi(label: 'Cash Position', value: '235,160', delta: '+1.8%', up: true),
          _Kpi(label: 'Revenue · MTD', value: '89,200', delta: '+12.4%', up: true, accent: SuperMaterialThemeData.of(context).colorScheme.secondary),
          _Kpi(label: 'Net Income · MTD', value: '34,120', delta: '−2.1%', up: false),
        ],
      ),
      // Cash flow
      MCard(
        accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary,
        title: 'Cash Flow',
        subtitle: 'Inflow vs outflow · SAR thousands · 12 months',
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          _Legend(color: SuperMaterialThemeData.of(context).colorScheme.primary, label: 'In'), SizedBox(width: 12), _Legend(color: SuperMaterialThemeData.of(context).superTheme.fg4, label: 'Out'),
        ]),
        children: [_CashFlowBars()],
      ),
      // Balances
      MCard(
        accentColor: SuperMaterialThemeData.of(context).colorScheme.primary,
        title: 'Cash & Asset Accounts',
        subtitle: 'Top balances',
        children: [
          for (final b in _balances) _BalanceRow(code: b.$1, name: b.$2, value: b.$3, pct: b.$4),
        ],
      ),
      // Recent ops
      MCard(
        accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary,
        title: 'Recent Operations',
        pad: 8,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(children: [
              for (int i = 0; i < _recent.length; i++)
                _RecentRow(r: _recent[i], last: i == _recent.length - 1),
            ]),
          ),
        ],
      ),
      // Alerts
      MCard(
        accentColor: SuperMaterialThemeData.of(context).colorScheme.tertiary,
        title: 'Needs Attention',
        children: [
          for (final a in _alerts(context)) _AlertRow(tone: a.$1, icon: a.$2, title: a.$3, sub: a.$4),
        ],
      ),
    ]);
  }
}

// ── Presentational widgets ───────────────────────────────────
class _Kpi extends StatelessWidget {
  final String label, value, delta;
  final bool up;
  final Color? accent;
  const _Kpi({required this.label, required this.value, required this.delta, required this.up, this.accent});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.surface, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Eyebrow(label, color: SuperMaterialThemeData.of(context).superTheme.fg3, size: 9.5),
          const SizedBox(height: 8),
          Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
            Text(value, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: -0.4, color: accent ?? SuperMaterialThemeData.of(context).superTheme.fg1)),
            const SizedBox(width: 5),
            Text('SAR', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
          ]),
          const SizedBox(height: 4),
          Text('${up ? '▲' : '▼'} $delta', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: up ? SuperMaterialThemeData.of(context).colorScheme.secondary : SuperMaterialThemeData.of(context).colorScheme.error)),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  const _Legend({required this.color, required this.label});
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 9, height: 9, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 5),
        Text(label, style: TextStyle(fontSize: 10.5, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontWeight: FontWeight.w600, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
      ]);
}

class _CashFlowBars extends StatelessWidget {
  const _CashFlowBars();
  @override
  Widget build(BuildContext context) {
    final maxV = _cashflow.expand((d) => [d.inV, d.outV]).reduce((a, b) => a > b ? a : b);
    return SizedBox(
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final d in _cashflow)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _bar(d.inV / maxV, SuperMaterialThemeData.of(context).colorScheme.primary),
                          const SizedBox(width: 2),
                          _bar(d.outV / maxV, SuperMaterialThemeData.of(context).superTheme.fg4),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(d.m, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 8.5, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _bar(double frac, Color c) => Expanded(
        child: FractionallySizedBox(
          heightFactor: frac.clamp(0.0, 1.0),
          alignment: Alignment.bottomCenter,
          child: Container(decoration: BoxDecoration(color: c, borderRadius: const BorderRadius.vertical(top: Radius.circular(2)))),
        ),
      );
}

class _BalanceRow extends StatelessWidget {
  final String code, name, value;
  final int pct;
  const _BalanceRow({required this.code, required this.name, required this.value, required this.pct});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(text: '$code  ', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                  TextSpan(text: name),
                ]),
                maxLines: 1, overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12.5, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily),
              ),
            ),
            const SizedBox(width: 10),
            Text(value, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: Stack(children: [
            Container(height: 6, color: SuperMaterialThemeData.of(context).superTheme.inputBg),
            FractionallySizedBox(widthFactor: pct / 100, child: Container(height: 6, color: SuperMaterialThemeData.of(context).colorScheme.primary)),
          ]),
        ),
      ],
    );
  }
}

class _RecentRow extends StatelessWidget {
  final (String, String, String, bool, String) r;
  final bool last;
  const _RecentRow({required this.r, required this.last});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(border: last ? null : Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(r.$1, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).colorScheme.primary)),
                const SizedBox(height: 2),
                Text(r.$2, style: TextStyle(fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(r.$3, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, fontWeight: FontWeight.w600, color: r.$4 ? SuperMaterialThemeData.of(context).colorScheme.secondary : SuperMaterialThemeData.of(context).colorScheme.error)),
              const SizedBox(height: 2),
              Text(r.$5, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10.5, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
            ],
          ),
        ],
      ),
    );
  }
}

class _AlertRow extends StatelessWidget {
  final Color tone;
  final String icon, title, sub;
  const _AlertRow({required this.tone, required this.icon, required this.title, required this.sub});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      decoration: BoxDecoration(color: superCoreTint(tone, 0x14), border: Border.all(color: superCoreTint(tone, 0x40)), borderRadius: BorderRadius.circular(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(MIcons.of(icon), size: 15, color: tone),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                const SizedBox(height: 2),
                Text(sub, style: TextStyle(fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
