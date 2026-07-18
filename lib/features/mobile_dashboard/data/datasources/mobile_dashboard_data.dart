// ============================================================
// DATA — Mobile Dashboard v2 (ports mobile-dashboard/data.jsx)
// The three domain tabs, attention items, workspaces, currencies
// and the deterministic chart series. English strings only (the
// geniuslink_design_system_mobile app is dark + EN, matching the .html default).
// ============================================================

import 'dart:math' as math;
import '../../domain/domain.dart';
MdTrend _u(double p) => MdTrend(true, p);
MdTrend _d(double p) => MdTrend(false, p);
Map<String, double> _v(double s, double u, double a) => {'SAR': s, 'USD': u, 'AED': a};

// ── chart series (mirrors data.jsx _genSeries) ──
final _pts = {'day': 12, 'week': 7, 'month': 8};
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

MdCard _card(int ti, int ci, String id, String label, MdMarker marker, Map<String, double> val, Map<String, MdTrend?> trend) =>
    MdCard(id: id, label: label, marker: marker, values: val, trends: trend, series: _series(trend, ti, ci));

// ── currencies / workspaces / attention ──
const mdCurrencies = [MdCurrency('SAR', 'Saudi Riyal'), MdCurrency('USD', 'US Dollar'), MdCurrency('AED', 'UAE Dirham')];

final mdWorkspaces = [
  const MdWorkspace('rashid', '9', 'Al-Rashid Trading Co.', 'Tenant 9', 1),
  const MdWorkspace('najd', '14', 'Najd Holdings', 'Tenant 14', 1.46),
  const MdWorkspace('coastal', '22', 'Coastal Logistics', 'Tenant 22', 0.83),
];

final mdAttention = [
  const MdAttention('oob', MdTone.danger, 2, 'Out-of-balance entries', "Debits and credits don't match"),
  const MdAttention('approvals', MdTone.warning, 5, 'Pending approvals', 'Vouchers awaiting your sign-off'),
  const MdAttention('sync', MdTone.information, 1, 'Sync conflict', 'A draft edited on two devices'),
];

// ── the three tabs (display order Banking → Accounting → Commercial) ──
final List<MdTab> mdTabs = [
  // Banking (source index 1 in data.jsx, used for series seed)
  MdTab(
    id: 'banking', label: 'Banking',
    cards: [
      _card(1, 0, 'balance', 'Total Balance', MdMarker.positive, _v(2680900, 715000, 2625000), {'day': _u(0.7), 'week': _u(2.4), 'month': _u(6.1)}),
      _card(1, 1, 'available', 'Available Cash', MdMarker.primary, _v(1942300, 517950, 1901500), {'day': _d(0.3), 'week': _u(1.1), 'month': _u(3.8)}),
      _card(1, 2, 'inflow', 'Inflow', MdMarker.positive, _v(512400, 136640, 501800), {'day': _u(4.9), 'week': _u(9.2), 'month': _u(14.0)}),
      _card(1, 3, 'outflow', 'Outflow', MdMarker.warning, _v(318750, 85000, 312100), {'day': null, 'week': _d(2.7), 'month': _u(1.6)}),
    ],
    actions: const [
      MdAction('deposit', 'Deposit', 'create'), MdAction('withdraw', 'Withdrawal', 'create'),
      MdAction('transfer', 'Transfer', 'create'), MdAction('statement', 'Statement', 'create'),
      MdAction('beneficiaries', 'Beneficiaries', 'manage'), MdAction('reconcile', 'Reconcile', 'manage'),
      MdAction('cards', 'Cards', 'manage'), MdAction('cheques', 'Cheques', 'manage'),
      MdAction('reports', 'Reports', 'manage'), MdAction('accounts', 'Bank Accounts', 'manage'),
    ],
    operations: const [
      MdOperation(reference: 'DEP-7741', type: 'Deposit', tone: MdTone.success, description: 'Cash deposit — Main', amounts: {'SAR': 120000, 'USD': 32000, 'AED': 117500}, direction: MdDirection.credit, timeLabel: '1h ago'),
      MdOperation(reference: 'WTH-3320', type: 'Withdrawal', tone: MdTone.danger, description: 'Payroll release', amounts: {'SAR': 215600, 'USD': 57500, 'AED': 211200}, direction: MdDirection.debit, timeLabel: '4h ago'),
      MdOperation(reference: 'TRF-1185', type: 'Transfer', tone: MdTone.information, description: 'Riyad Bank → Main', amounts: {'SAR': 80000, 'USD': 21330, 'AED': 78300}, direction: MdDirection.credit, timeLabel: 'Yesterday'),
      MdOperation(reference: 'WTH-3319', type: 'Withdrawal', tone: MdTone.danger, description: 'Supplier wire', amounts: {'SAR': 64250, 'USD': 17130, 'AED': 62900}, direction: MdDirection.debit, timeLabel: 'Yesterday'),
      MdOperation(reference: 'DEP-7738', type: 'Deposit', tone: MdTone.success, description: 'Customer settlement', amounts: {'SAR': 38900, 'USD': 10370, 'AED': 38080}, direction: MdDirection.credit, timeLabel: '2 days ago'),
    ],
  ),
  // Accounting (source index 0)
  MdTab(
    id: 'accounting', label: 'Accounting',
    cards: [
      _card(0, 0, 'assets', 'Total Assets', MdMarker.positive, _v(4820400, 1285440, 4719600), {'day': _u(0.4), 'week': _u(3.1), 'month': _u(8.6)}),
      _card(0, 1, 'cash', 'Cash', MdMarker.primary, _v(962150, 256570, 942100), {'day': null, 'week': _d(1.2), 'month': _u(4.0)}),
      _card(0, 2, 'revenue', 'Revenue MTD', MdMarker.primary, _v(1340800, 357550, 1313000), {'day': _u(2.6), 'week': _u(6.4), 'month': _u(11.2)}),
      _card(0, 3, 'net', 'Net Income', MdMarker.positive, _v(388200, 103520, 380100), {'day': _d(0.9), 'week': _u(2.2), 'month': _u(5.5)}),
    ],
    actions: const [
      MdAction('journal', 'Journal Entry', 'create'), MdAction('voucher', 'Voucher', 'create'),
      MdAction('receipt', 'Receipt', 'create'), MdAction('invoice', 'Invoice', 'create'),
      MdAction('reconcile', 'Reconcile', 'manage'), MdAction('reports', 'Reports', 'manage'),
      MdAction('customers', 'Customers', 'manage'), MdAction('suppliers', 'Suppliers', 'manage'),
      MdAction('fixed', 'Fixed Assets', 'manage'), MdAction('coa', 'Chart of Accounts', 'manage'),
    ],
    operations: const [
      MdOperation(reference: 'JV-2024-0412', type: 'Journal', tone: MdTone.information, description: 'Depreciation — Q4', amounts: {'SAR': 18400, 'USD': 4905, 'AED': 18020}, direction: MdDirection.debit, timeLabel: '2h ago'),
      MdOperation(reference: 'VCH-0188', type: 'Voucher', tone: MdTone.neutral, description: 'Office rent payment', amounts: {'SAR': 45000, 'USD': 12000, 'AED': 44070}, direction: MdDirection.debit, timeLabel: '5h ago'),
      MdOperation(reference: 'JV-2024-0411', type: 'Journal', tone: MdTone.information, description: 'Revenue accrual', amounts: {'SAR': 126500, 'USD': 33730, 'AED': 123880}, direction: MdDirection.credit, timeLabel: 'Yesterday'),
      MdOperation(reference: 'VCH-0187', type: 'Voucher', tone: MdTone.neutral, description: 'Utilities — Nov', amounts: {'SAR': 9320, 'USD': 2485, 'AED': 9130}, direction: MdDirection.debit, timeLabel: 'Yesterday'),
      MdOperation(reference: 'JV-2024-0410', type: 'Journal', tone: MdTone.information, description: 'FX revaluation', amounts: {'SAR': 4110, 'USD': 1095, 'AED': 4025}, direction: MdDirection.credit, timeLabel: '2 days ago'),
    ],
  ),
  // Commercial (source index 2)
  MdTab(
    id: 'commercial', label: 'Commercial',
    cards: [
      _card(2, 0, 'sales', 'Sales MTD', MdMarker.positive, _v(1875300, 500000, 1836000), {'day': _u(3.4), 'week': _u(7.8), 'month': _u(12.5)}),
      _card(2, 1, 'purchases', 'Purchases MTD', MdMarker.primary, _v(1124600, 299900, 1101000), {'day': _u(1.0), 'week': _u(4.2), 'month': _u(9.0)}),
      _card(2, 2, 'receivables', 'Receivables', MdMarker.warning, _v(642800, 171410, 629400), {'day': _d(0.6), 'week': _d(2.1), 'month': _u(2.9)}),
      _card(2, 3, 'payables', 'Payables', MdMarker.primary, _v(489050, 130410, 478800), {'day': null, 'week': _u(1.8), 'month': _u(4.6)}),
    ],
    actions: const [
      MdAction('sale', 'Sale', 'create'), MdAction('purchase', 'Purchase', 'create'),
      MdAction('quotation', 'Quotation', 'create'), MdAction('return', 'Return', 'create'),
      MdAction('customers', 'Customers', 'manage'), MdAction('suppliers', 'Suppliers', 'manage'),
      MdAction('inventory', 'Inventory', 'manage'), MdAction('pricelist', 'Price Lists', 'manage'),
      MdAction('reports', 'Reports', 'manage'), MdAction('items', 'Items', 'manage'),
    ],
    operations: const [
      MdOperation(reference: 'INV-S-2291', type: 'Sale', tone: MdTone.success, description: 'Gulf Contracting Ltd', amounts: {'SAR': 96400, 'USD': 25700, 'AED': 94380}, direction: MdDirection.credit, timeLabel: '30m ago'),
      MdOperation(reference: 'INV-P-0884', type: 'Purchase', tone: MdTone.information, description: 'Saudi Steel Co', amounts: {'SAR': 142800, 'USD': 38080, 'AED': 139800}, direction: MdDirection.debit, timeLabel: '3h ago'),
      MdOperation(reference: 'INV-S-2290', type: 'Sale', tone: MdTone.success, description: 'Najd Builders', amounts: {'SAR': 53200, 'USD': 14190, 'AED': 52080}, direction: MdDirection.credit, timeLabel: 'Yesterday'),
      MdOperation(reference: 'INV-S-2289', type: 'Sale', tone: MdTone.success, description: 'Coastal Cement', amounts: {'SAR': 31750, 'USD': 8470, 'AED': 31080}, direction: MdDirection.credit, timeLabel: 'Yesterday'),
      MdOperation(reference: 'INV-P-0883', type: 'Purchase', tone: MdTone.information, description: 'Eastern Timber', amounts: {'SAR': 27400, 'USD': 7300, 'AED': 26820}, direction: MdDirection.debit, timeLabel: '2 days ago'),
    ],
  ),
];

final mdAxis = {
  'day': ['9a', '12p', '3p', '6p', 'now'],
  'week': ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
  'month': ['W1', 'W2', 'W3', 'W4', 'W5', 'W6', 'W7', 'W8'],
};

final mobileDashboardCatalog = MobileDashboardCatalog(
  tabs: mdTabs,
  workspaces: mdWorkspaces,
  attention: mdAttention,
  currencies: mdCurrencies,
  axisLabels: mdAxis,
);
