// ============================================================
// VIEW — Dashboard tab (ports MDashboard)
// KPI row · cash-flow bars · balances · recent ops · alerts
// ============================================================

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';
import '../../../../workspace/presentation/controllers/nav_controller.dart';

class _Flow {
  final String m;
  final double inV, outV;
  const _Flow(this.m, this.inV, this.outV);
}

const _cashflow = <_Flow>[
  _Flow('Jan', 62, 48), _Flow('Feb', 71, 52), _Flow('Mar', 58, 61), _Flow('Apr', 80, 55),
  _Flow('May', 74, 58), _Flow('Jun', 92, 63), _Flow('Jul', 88, 70), _Flow('Aug', 79, 66),
  _Flow('Sep', 96, 72), _Flow('Oct', 104, 78), _Flow('Nov', 98, 81), _Flow('Dec', 112, 74),
];

const _balances = [
  ('1100', 'Bank · NCB Main', '186,420.00', 64),
  ('1001', 'Cash Box', '42,500.00', 15),
  ('1200', 'Inventory (WIP)', '54,890.00', 19),
  ('1101', 'Bank · Al Rajhi', '6,240.00', 2),
];

const _recent = [
  ('JV-2024-0226', 'Mixed sale & revenue', '+3,400.00', true, '10:14'),
  ('EXT-2024-0311', 'Wire · Global Steel', '−12,045.00', false, '11:02'),
  ('DEP-2024-0182', 'Deposit · Customer 102', '+5,000.00', true, '09:42'),
  ('INV-ISS-0089', 'Issue · Project A-92', '−6,600.00', false, '08:30'),
];

const _alerts = [
  (M.orange, 'info', '1 entry out of balance', 'JV-2024-0225 · draft'),
  (M.red, 'info', '2 SKUs out of stock', 'Downtown Central Store'),
  (M.blue, 'lock', '3 wires await approval', 'External transfers · 41,200 SAR'),
  (M.green, 'check', 'Period Nov 2024 closed', 'Locked Dec 01'),
];

class DashboardScreen extends StatelessWidget {
  final NavController nav;
  const DashboardScreen({super.key, required this.nav});

  @override
  Widget build(BuildContext context) {
    return MScroll([
      const Padding(
        padding: EdgeInsets.only(top: 0),
        child: Text('Fiscal 2024 · as of Dec 19, 2025', style: TextStyle(fontFamily: M.mono, fontSize: 11.5, color: M.fg3)),
      ),
      // KPI grid
      GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.55,
        children: const [
          _Kpi(label: 'Total Assets', value: '289,050', delta: '+4.2%', up: true),
          _Kpi(label: 'Cash Position', value: '235,160', delta: '+1.8%', up: true),
          _Kpi(label: 'Revenue · MTD', value: '89,200', delta: '+12.4%', up: true, accent: M.green),
          _Kpi(label: 'Net Income · MTD', value: '34,120', delta: '−2.1%', up: false),
        ],
      ),
      // Cash flow
      MCard(
        marker: M.green,
        title: 'Cash Flow',
        sub: 'Inflow vs outflow · SAR thousands · 12 months',
        right: const Row(mainAxisSize: MainAxisSize.min, children: [
          _Legend(color: M.blue, label: 'In'), SizedBox(width: 12), _Legend(color: M.fg4, label: 'Out'),
        ]),
        children: const [_CashFlowBars()],
      ),
      // Balances
      MCard(
        marker: M.blue,
        title: 'Cash & Asset Accounts',
        sub: 'Top balances',
        children: [
          for (final b in _balances) _BalanceRow(code: b.$1, name: b.$2, value: b.$3, pct: b.$4),
        ],
      ),
      // Recent ops
      MCard(
        marker: M.green,
        title: 'Recent Operations',
        pad: 8,
        right: GestureDetector(onTap: () => nav.go('journalList'),
            child: const Text('View All', style: TextStyle(color: M.blue, fontSize: 12, fontWeight: FontWeight.w600))),
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
        marker: M.orange,
        title: 'Needs Attention',
        children: [
          for (final a in _alerts) _AlertRow(tone: a.$1, icon: a.$2, title: a.$3, sub: a.$4),
        ],
      ),
    ]);
  }
}

class _Kpi extends StatelessWidget {
  final String label, value, delta;
  final bool up;
  final Color? accent;
  const _Kpi({required this.label, required this.value, required this.delta, required this.up, this.accent});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: M.surface, border: Border.all(color: M.border), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Eyebrow(label, color: M.fg3, size: 9.5),
          const SizedBox(height: 8),
          Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
            Text(value, style: TextStyle(fontFamily: M.mono, fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: -0.4, color: accent ?? M.fg1)),
            const SizedBox(width: 5),
            const Text('SAR', style: TextStyle(fontFamily: M.mono, fontSize: 10, color: M.fg3)),
          ]),
          const SizedBox(height: 4),
          Text('${up ? '▲' : '▼'} $delta', style: TextStyle(fontFamily: M.mono, fontSize: 11, color: up ? M.green : M.red)),
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
        Text(label, style: const TextStyle(fontSize: 10.5, color: M.fg3, fontWeight: FontWeight.w600, fontFamily: M.body)),
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
                          _bar(d.inV / maxV, M.blue),
                          const SizedBox(width: 2),
                          _bar(d.outV / maxV, M.fg4),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(d.m, style: const TextStyle(fontFamily: M.mono, fontSize: 8.5, color: M.fg3)),
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
                  TextSpan(text: '$code  ', style: const TextStyle(fontFamily: M.mono, color: M.fg3)),
                  TextSpan(text: name),
                ]),
                maxLines: 1, overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12.5, color: M.fg1, fontFamily: M.body),
              ),
            ),
            const SizedBox(width: 10),
            Text(value, style: const TextStyle(fontFamily: M.mono, fontSize: 12.5, fontWeight: FontWeight.w600, color: M.fg1)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: Stack(children: [
            Container(height: 6, color: M.input),
            FractionallySizedBox(widthFactor: pct / 100, child: Container(height: 6, color: M.blue)),
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
      decoration: BoxDecoration(border: last ? null : const Border(bottom: BorderSide(color: M.border))),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(r.$1, style: const TextStyle(fontFamily: M.mono, fontSize: 12, color: M.blue)),
                const SizedBox(height: 2),
                Text(r.$2, style: const TextStyle(fontSize: 12, color: M.fg3, fontFamily: M.body)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(r.$3, style: TextStyle(fontFamily: M.mono, fontSize: 13, fontWeight: FontWeight.w600, color: r.$4 ? M.green : M.red)),
              const SizedBox(height: 2),
              Text(r.$5, style: const TextStyle(fontFamily: M.mono, fontSize: 10.5, color: M.fg3)),
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
      decoration: BoxDecoration(color: tint(tone, 0x14), border: Border.all(color: tint(tone, 0x40)), borderRadius: BorderRadius.circular(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(MIcons.of(icon), size: 15, color: tone),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
                const SizedBox(height: 2),
                Text(sub, style: const TextStyle(fontSize: 11, color: M.fg3, fontFamily: M.body)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
