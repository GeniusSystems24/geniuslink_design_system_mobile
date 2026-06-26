// ============================================================
// DATA — Mobile Dashboard v2 (ports mobile-dashboard/data.jsx)
// The three domain tabs, attention items, workspaces, currencies
// and the deterministic chart series. English strings only (the
// geniuslink_design_system_mobile app is dark + EN, matching the .html default).
// ============================================================

import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../design_system/tokens/m_colors.dart';

class MdTrend {
  final bool up;
  final double pct;
  const MdTrend(this.up, this.pct);
}

class MdCard {
  final String id, label, marker;
  final Map<String, double> val;
  final Map<String, MdTrend?> trend;
  final Map<String, List<double>> series;
  const MdCard({required this.id, required this.label, required this.marker, required this.val, required this.trend, required this.series});
}

class MdAction {
  final String id, label, icon, group;
  const MdAction(this.id, this.label, this.icon, this.group);
}

class MdOp {
  final String ref, type, tone, desc, dir, time;
  final Map<String, double> amt;
  const MdOp({required this.ref, required this.type, required this.tone, required this.desc, required this.amt, required this.dir, required this.time});
  bool get isCredit => dir == 'credit';
}

class MdAttention {
  final String id, tone, icon, label, desc;
  final int count;
  const MdAttention(this.id, this.tone, this.icon, this.count, this.label, this.desc);
}

class MdTab {
  final String id, label;
  final List<MdCard> cards;
  final List<MdAction> actions;
  final List<MdOp> ops;
  const MdTab({required this.id, required this.label, required this.cards, required this.actions, required this.ops});
}

class MdWorkspace {
  final String id, name, tag;
  final double factor;
  const MdWorkspace(this.id, this.name, this.tag, this.factor);
}

Color mdMarker(String m) => m == 'green' ? M.green : (m == 'orange' ? M.orange : M.blue);
Color mdTone(String t) => switch (t) { 'success' => M.green, 'info' => M.blue, 'warning' => M.orange, 'danger' => M.red, _ => M.fg3 };

MdTrend _u(double p) => MdTrend(true, p);
MdTrend _d(double p) => MdTrend(false, p);
Map<String, double> _v(double s, double u, double a) => {'SAR': s, 'USD': u, 'AED': a};

// ── chart series (mirrors data.jsx _genSeries) ──
const _pts = {'day': 12, 'week': 7, 'month': 8};
double _wob(int i, double seed) => math.sin(i * 1.73 + seed) * 0.5 + math.sin(i * 0.61 + seed * 2.1) * 0.5;
List<double> _gen(double pct, int n, double seed) {
  final start = 1 / (1 + (pct == 0 ? 2 : pct) / 100);
  final out = <double>[];
  for (int i = 0; i < n; i++) {
    final t = n == 1 ? 1.0 : i / (n - 1);
    final base = start + (1 - start) * t;
    out.add(math.max(0.02, base * (1 + _wob(i, seed) * 0.022)));
  }
  out[n - 1] = 1;
  return out;
}
double _signed(MdTrend? tr, double fb) => tr == null ? fb : tr.pct * (tr.up ? 1 : -1);
Map<String, List<double>> _series(Map<String, MdTrend?> tr, int ti, int ci) {
  final seed = ti * 7 + ci * 3 + 1.0;
  return {
    'day': _gen(_signed(tr['day'], 1.5), _pts['day']!, seed),
    'week': _gen(_signed(tr['week'], 2.0), _pts['week']!, seed + 11),
    'month': _gen(_signed(tr['month'], 4.0), _pts['month']!, seed + 23),
  };
}

MdCard _card(int ti, int ci, String id, String label, String marker, Map<String, double> val, Map<String, MdTrend?> trend) =>
    MdCard(id: id, label: label, marker: marker, val: val, trend: trend, series: _series(trend, ti, ci));

// ── currencies / workspaces / attention ──
const mdCurrencies = [('SAR', 'Saudi Riyal'), ('USD', 'US Dollar'), ('AED', 'UAE Dirham')];

const mdWorkspaces = [
  MdWorkspace('rashid', 'Al-Rashid Trading Co.', 'Tenant 9', 1),
  MdWorkspace('najd', 'Najd Holdings', 'Tenant 14', 1.46),
  MdWorkspace('coastal', 'Coastal Logistics', 'Tenant 22', 0.83),
];

const mdAttention = [
  MdAttention('oob', 'danger', 'alert', 2, 'Out-of-balance entries', "Debits and credits don't match"),
  MdAttention('approvals', 'warning', 'inbox', 5, 'Pending approvals', 'Vouchers awaiting your sign-off'),
  MdAttention('sync', 'info', 'alert', 1, 'Sync conflict', 'A draft edited on two devices'),
];

// ── the three tabs (display order Banking → Accounting → Commercial) ──
final List<MdTab> mdTabs = [
  // Banking (source index 1 in data.jsx, used for series seed)
  MdTab(
    id: 'banking', label: 'Banking',
    cards: [
      _card(1, 0, 'balance', 'Total Balance', 'green', _v(2680900, 715000, 2625000), {'day': _u(0.7), 'week': _u(2.4), 'month': _u(6.1)}),
      _card(1, 1, 'available', 'Available Cash', 'blue', _v(1942300, 517950, 1901500), {'day': _d(0.3), 'week': _u(1.1), 'month': _u(3.8)}),
      _card(1, 2, 'inflow', 'Inflow', 'green', _v(512400, 136640, 501800), {'day': _u(4.9), 'week': _u(9.2), 'month': _u(14.0)}),
      _card(1, 3, 'outflow', 'Outflow', 'orange', _v(318750, 85000, 312100), {'day': null, 'week': _d(2.7), 'month': _u(1.6)}),
    ],
    actions: const [
      MdAction('deposit', 'Deposit', 'plus', 'create'), MdAction('withdraw', 'Withdrawal', 'back', 'create'),
      MdAction('transfer', 'Transfer', 'send', 'create'), MdAction('statement', 'Statement', 'doc', 'create'),
      MdAction('beneficiaries', 'Beneficiaries', 'user', 'manage'), MdAction('reconcile', 'Reconcile', 'check', 'manage'),
      MdAction('cards', 'Cards', 'grid', 'manage'), MdAction('cheques', 'Cheques', 'doc', 'manage'),
      MdAction('reports', 'Reports', 'poll', 'manage'), MdAction('accounts', 'Bank Accounts', 'lock', 'manage'),
    ],
    ops: const [
      MdOp(ref: 'DEP-7741', type: 'Deposit', tone: 'success', desc: 'Cash deposit — Main', amt: {'SAR': 120000, 'USD': 32000, 'AED': 117500}, dir: 'credit', time: '1h ago'),
      MdOp(ref: 'WTH-3320', type: 'Withdrawal', tone: 'danger', desc: 'Payroll release', amt: {'SAR': 215600, 'USD': 57500, 'AED': 211200}, dir: 'debit', time: '4h ago'),
      MdOp(ref: 'TRF-1185', type: 'Transfer', tone: 'info', desc: 'Riyad Bank → Main', amt: {'SAR': 80000, 'USD': 21330, 'AED': 78300}, dir: 'credit', time: 'Yesterday'),
      MdOp(ref: 'WTH-3319', type: 'Withdrawal', tone: 'danger', desc: 'Supplier wire', amt: {'SAR': 64250, 'USD': 17130, 'AED': 62900}, dir: 'debit', time: 'Yesterday'),
      MdOp(ref: 'DEP-7738', type: 'Deposit', tone: 'success', desc: 'Customer settlement', amt: {'SAR': 38900, 'USD': 10370, 'AED': 38080}, dir: 'credit', time: '2 days ago'),
    ],
  ),
  // Accounting (source index 0)
  MdTab(
    id: 'accounting', label: 'Accounting',
    cards: [
      _card(0, 0, 'assets', 'Total Assets', 'green', _v(4820400, 1285440, 4719600), {'day': _u(0.4), 'week': _u(3.1), 'month': _u(8.6)}),
      _card(0, 1, 'cash', 'Cash', 'blue', _v(962150, 256570, 942100), {'day': null, 'week': _d(1.2), 'month': _u(4.0)}),
      _card(0, 2, 'revenue', 'Revenue MTD', 'blue', _v(1340800, 357550, 1313000), {'day': _u(2.6), 'week': _u(6.4), 'month': _u(11.2)}),
      _card(0, 3, 'net', 'Net Income', 'green', _v(388200, 103520, 380100), {'day': _d(0.9), 'week': _u(2.2), 'month': _u(5.5)}),
    ],
    actions: const [
      MdAction('journal', 'Journal Entry', 'edit', 'create'), MdAction('voucher', 'Voucher', 'doc', 'create'),
      MdAction('receipt', 'Receipt', 'inbox', 'create'), MdAction('invoice', 'Invoice', 'doc', 'create'),
      MdAction('reconcile', 'Reconcile', 'check', 'manage'), MdAction('reports', 'Reports', 'poll', 'manage'),
      MdAction('customers', 'Customers', 'user', 'manage'), MdAction('suppliers', 'Suppliers', 'grid', 'manage'),
      MdAction('fixed', 'Fixed Assets', 'lock', 'manage'), MdAction('coa', 'Chart of Accounts', 'dots', 'manage'),
    ],
    ops: const [
      MdOp(ref: 'JV-2024-0412', type: 'Journal', tone: 'info', desc: 'Depreciation — Q4', amt: {'SAR': 18400, 'USD': 4905, 'AED': 18020}, dir: 'debit', time: '2h ago'),
      MdOp(ref: 'VCH-0188', type: 'Voucher', tone: 'neutral', desc: 'Office rent payment', amt: {'SAR': 45000, 'USD': 12000, 'AED': 44070}, dir: 'debit', time: '5h ago'),
      MdOp(ref: 'JV-2024-0411', type: 'Journal', tone: 'info', desc: 'Revenue accrual', amt: {'SAR': 126500, 'USD': 33730, 'AED': 123880}, dir: 'credit', time: 'Yesterday'),
      MdOp(ref: 'VCH-0187', type: 'Voucher', tone: 'neutral', desc: 'Utilities — Nov', amt: {'SAR': 9320, 'USD': 2485, 'AED': 9130}, dir: 'debit', time: 'Yesterday'),
      MdOp(ref: 'JV-2024-0410', type: 'Journal', tone: 'info', desc: 'FX revaluation', amt: {'SAR': 4110, 'USD': 1095, 'AED': 4025}, dir: 'credit', time: '2 days ago'),
    ],
  ),
  // Commercial (source index 2)
  MdTab(
    id: 'commercial', label: 'Commercial',
    cards: [
      _card(2, 0, 'sales', 'Sales MTD', 'green', _v(1875300, 500000, 1836000), {'day': _u(3.4), 'week': _u(7.8), 'month': _u(12.5)}),
      _card(2, 1, 'purchases', 'Purchases MTD', 'blue', _v(1124600, 299900, 1101000), {'day': _u(1.0), 'week': _u(4.2), 'month': _u(9.0)}),
      _card(2, 2, 'receivables', 'Receivables', 'orange', _v(642800, 171410, 629400), {'day': _d(0.6), 'week': _d(2.1), 'month': _u(2.9)}),
      _card(2, 3, 'payables', 'Payables', 'blue', _v(489050, 130410, 478800), {'day': null, 'week': _u(1.8), 'month': _u(4.6)}),
    ],
    actions: const [
      MdAction('sale', 'Sale', 'plus', 'create'), MdAction('purchase', 'Purchase', 'inbox', 'create'),
      MdAction('quotation', 'Quotation', 'doc', 'create'), MdAction('return', 'Return', 'back', 'create'),
      MdAction('customers', 'Customers', 'user', 'manage'), MdAction('suppliers', 'Suppliers', 'grid', 'manage'),
      MdAction('inventory', 'Inventory', 'inbox', 'manage'), MdAction('pricelist', 'Price Lists', 'doc', 'manage'),
      MdAction('reports', 'Reports', 'poll', 'manage'), MdAction('items', 'Items', 'lock', 'manage'),
    ],
    ops: const [
      MdOp(ref: 'INV-S-2291', type: 'Sale', tone: 'success', desc: 'Gulf Contracting Ltd', amt: {'SAR': 96400, 'USD': 25700, 'AED': 94380}, dir: 'credit', time: '30m ago'),
      MdOp(ref: 'INV-P-0884', type: 'Purchase', tone: 'info', desc: 'Saudi Steel Co', amt: {'SAR': 142800, 'USD': 38080, 'AED': 139800}, dir: 'debit', time: '3h ago'),
      MdOp(ref: 'INV-S-2290', type: 'Sale', tone: 'success', desc: 'Najd Builders', amt: {'SAR': 53200, 'USD': 14190, 'AED': 52080}, dir: 'credit', time: 'Yesterday'),
      MdOp(ref: 'INV-S-2289', type: 'Sale', tone: 'success', desc: 'Coastal Cement', amt: {'SAR': 31750, 'USD': 8470, 'AED': 31080}, dir: 'credit', time: 'Yesterday'),
      MdOp(ref: 'INV-P-0883', type: 'Purchase', tone: 'info', desc: 'Eastern Timber', amt: {'SAR': 27400, 'USD': 7300, 'AED': 26820}, dir: 'debit', time: '2 days ago'),
    ],
  ),
];

const mdAxis = {
  'day': ['9a', '12p', '3p', '6p', 'now'],
  'week': ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
  'month': ['W1', 'W2', 'W3', 'W4', 'W5', 'W6', 'W7', 'W8'],
};

// ── number formatting (en-US grouping) ──
String mdNum(num v, {int decimals = 0}) {
  final fixed = v.toStringAsFixed(decimals);
  final parts = fixed.split('.');
  final neg = parts[0].startsWith('-');
  final digits = neg ? parts[0].substring(1) : parts[0];
  final buf = StringBuffer();
  for (int i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buf.write(',');
    buf.write(digits[i]);
  }
  var out = buf.toString();
  if (parts.length > 1) out = '$out.${parts[1]}';
  return neg ? '-$out' : out;
}
