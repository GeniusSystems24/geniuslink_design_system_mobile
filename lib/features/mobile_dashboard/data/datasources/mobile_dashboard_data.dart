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
Map<String, double> _v(double s, double u, double a) => {
  'SAR': s,
  'USD': u,
  'AED': a,
};

// ── chart series (mirrors data.jsx _genSeries) ──
final _pts = {'day': 12, 'week': 7, 'month': 8};
double _wob(int i, double seed) =>
    math.sin(i * 1.73 + seed) * 0.5 + math.sin(i * 0.61 + seed * 2.1) * 0.5;
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

double _signed(MdTrend? tr, double fb) =>
    tr == null ? fb : tr.pct * (tr.up ? 1 : -1);
Map<String, List<double>> _series(Map<String, MdTrend?> tr, int ti, int ci) {
  final seed = ti * 7 + ci * 3 + 1.0;
  return {
    'day': _gen(_signed(tr['day'], 1.5), _pts['day']!, seed),
    'week': _gen(_signed(tr['week'], 2.0), _pts['week']!, seed + 11),
    'month': _gen(_signed(tr['month'], 4.0), _pts['month']!, seed + 23),
  };
}

MdCard _card(
  int ti,
  int ci,
  String id,
  String label,
  MdMarker marker,
  Map<String, double> val,
  Map<String, MdTrend?> trend,
) => MdCard(
  id: id,
  label: label,
  marker: marker,
  values: val,
  trends: trend,
  series: _series(trend, ti, ci),
);

// ── currencies / workspaces / attention ──
const mdCurrencies = [
  MdCurrency('SAR', 'Saudi Riyal'),
  MdCurrency('USD', 'US Dollar'),
  MdCurrency('AED', 'UAE Dirham'),
];

final mdWorkspaces = [
  const MdWorkspace('rashid', '9', 'Al-Rashid Trading Co.', 'Tenant 9', 1),
  const MdWorkspace('najd', '14', 'Najd Holdings', 'Tenant 14', 1.46),
  const MdWorkspace('coastal', '22', 'Coastal Logistics', 'Tenant 22', 0.83),
];

final mdAttention = [
  const MdAttention(
    'oob',
    MdTone.danger,
    2,
    'Out-of-balance entries',
    "Debits and credits don't match",
  ),
  const MdAttention(
    'approvals',
    MdTone.warning,
    5,
    'Pending approvals',
    'Vouchers awaiting your sign-off',
  ),
  const MdAttention(
    'sync',
    MdTone.information,
    1,
    'Sync conflict',
    'A draft edited on two devices',
  ),
];

// ── the three tabs (display order Banking → Accounting → Commercial) ──
final List<MdTab> mdTabs = [
  // Banking (source index 1 in data.jsx, used for series seed)
  MdTab(
    id: 'banking',
    label: 'Banking',
    cards: [
      _card(
        1,
        0,
        'balance',
        'Total Balance',
        MdMarker.positive,
        _v(2680900, 715000, 2625000),
        {'day': _u(0.7), 'week': _u(2.4), 'month': _u(6.1)},
      ),
      _card(
        1,
        1,
        'available',
        'Available Cash',
        MdMarker.primary,
        _v(1942300, 517950, 1901500),
        {'day': _d(0.3), 'week': _u(1.1), 'month': _u(3.8)},
      ),
      _card(
        1,
        2,
        'inflow',
        'Inflow',
        MdMarker.positive,
        _v(512400, 136640, 501800),
        {'day': _u(4.9), 'week': _u(9.2), 'month': _u(14.0)},
      ),
      _card(
        1,
        3,
        'outflow',
        'Outflow',
        MdMarker.warning,
        _v(318750, 85000, 312100),
        {'day': null, 'week': _d(2.7), 'month': _u(1.6)},
      ),
    ],
    actions: const [
      MdAction('deposit', 'Deposit', 'create'),
      MdAction('withdraw', 'Withdrawal', 'create'),
      MdAction('transfer', 'Transfer', 'create'),
      MdAction('statement', 'Statement', 'create'),
      MdAction('beneficiaries', 'Beneficiaries', 'manage'),
      MdAction('reconcile', 'Reconcile', 'manage'),
      MdAction('cards', 'Cards', 'manage'),
      MdAction('cheques', 'Cheques', 'manage'),
      MdAction('reports', 'Reports', 'manage'),
      MdAction('accounts', 'Bank Accounts', 'manage'),
    ],
    operations: const [
      MdOperation(
        reference: 'DEP-7741',
        type: 'Deposit',
        tone: MdTone.success,
        description: 'Cash deposit — Main',
        amounts: {'SAR': 120000, 'USD': 32000, 'AED': 117500},
        direction: MdDirection.credit,
        timeLabel: '1h ago',
      ),
      MdOperation(
        reference: 'WTH-3320',
        type: 'Withdrawal',
        tone: MdTone.danger,
        description: 'Payroll release',
        amounts: {'SAR': 215600, 'USD': 57500, 'AED': 211200},
        direction: MdDirection.debit,
        timeLabel: '4h ago',
      ),
      MdOperation(
        reference: 'TRF-1185',
        type: 'Transfer',
        tone: MdTone.information,
        description: 'Riyad Bank → Main',
        amounts: {'SAR': 80000, 'USD': 21330, 'AED': 78300},
        direction: MdDirection.credit,
        timeLabel: 'Yesterday',
      ),
      MdOperation(
        reference: 'WTH-3319',
        type: 'Withdrawal',
        tone: MdTone.danger,
        description: 'Supplier wire',
        amounts: {'SAR': 64250, 'USD': 17130, 'AED': 62900},
        direction: MdDirection.debit,
        timeLabel: 'Yesterday',
      ),
      MdOperation(
        reference: 'DEP-7738',
        type: 'Deposit',
        tone: MdTone.success,
        description: 'Customer settlement',
        amounts: {'SAR': 38900, 'USD': 10370, 'AED': 38080},
        direction: MdDirection.credit,
        timeLabel: '2 days ago',
      ),
    ],
  ),
  // Accounting (source index 0)
  MdTab(
    id: 'accounting',
    label: 'Accounting',
    cards: [
      _card(
        0,
        0,
        'assets',
        'Total Assets',
        MdMarker.positive,
        _v(4820400, 1285440, 4719600),
        {'day': _u(0.4), 'week': _u(3.1), 'month': _u(8.6)},
      ),
      _card(
        0,
        1,
        'cash',
        'Cash',
        MdMarker.primary,
        _v(962150, 256570, 942100),
        {'day': null, 'week': _d(1.2), 'month': _u(4.0)},
      ),
      _card(
        0,
        2,
        'revenue',
        'Revenue MTD',
        MdMarker.primary,
        _v(1340800, 357550, 1313000),
        {'day': _u(2.6), 'week': _u(6.4), 'month': _u(11.2)},
      ),
      _card(
        0,
        3,
        'net',
        'Net Income',
        MdMarker.positive,
        _v(388200, 103520, 380100),
        {'day': _d(0.9), 'week': _u(2.2), 'month': _u(5.5)},
      ),
    ],
    actions: const [
      MdAction('journal', 'Journal Entry', 'create'),
      MdAction('voucher', 'Voucher', 'create'),
      MdAction('receipt', 'Receipt', 'create'),
      MdAction('invoice', 'Invoice', 'create'),
      MdAction('reconcile', 'Reconcile', 'manage'),
      MdAction('reports', 'Reports', 'manage'),
      MdAction('customers', 'Customers', 'manage'),
      MdAction('suppliers', 'Suppliers', 'manage'),
      MdAction('fixed', 'Fixed Assets', 'manage'),
      MdAction('coa', 'Chart of Accounts', 'manage'),
    ],
    operations: const [
      MdOperation(
        reference: 'JV-2024-0412',
        type: 'Journal',
        tone: MdTone.information,
        description: 'Depreciation — Q4',
        amounts: {'SAR': 18400, 'USD': 4905, 'AED': 18020},
        direction: MdDirection.debit,
        timeLabel: '2h ago',
      ),
      MdOperation(
        reference: 'VCH-0188',
        type: 'Voucher',
        tone: MdTone.neutral,
        description: 'Office rent payment',
        amounts: {'SAR': 45000, 'USD': 12000, 'AED': 44070},
        direction: MdDirection.debit,
        timeLabel: '5h ago',
      ),
      MdOperation(
        reference: 'JV-2024-0411',
        type: 'Journal',
        tone: MdTone.information,
        description: 'Revenue accrual',
        amounts: {'SAR': 126500, 'USD': 33730, 'AED': 123880},
        direction: MdDirection.credit,
        timeLabel: 'Yesterday',
      ),
      MdOperation(
        reference: 'VCH-0187',
        type: 'Voucher',
        tone: MdTone.neutral,
        description: 'Utilities — Nov',
        amounts: {'SAR': 9320, 'USD': 2485, 'AED': 9130},
        direction: MdDirection.debit,
        timeLabel: 'Yesterday',
      ),
      MdOperation(
        reference: 'JV-2024-0410',
        type: 'Journal',
        tone: MdTone.information,
        description: 'FX revaluation',
        amounts: {'SAR': 4110, 'USD': 1095, 'AED': 4025},
        direction: MdDirection.credit,
        timeLabel: '2 days ago',
      ),
    ],
  ),
  // Commercial (source index 2)
  MdTab(
    id: 'commercial',
    label: 'Commercial',
    cards: [
      _card(
        2,
        0,
        'sales',
        'Sales MTD',
        MdMarker.positive,
        _v(1875300, 500000, 1836000),
        {'day': _u(3.4), 'week': _u(7.8), 'month': _u(12.5)},
      ),
      _card(
        2,
        1,
        'purchases',
        'Purchases MTD',
        MdMarker.primary,
        _v(1124600, 299900, 1101000),
        {'day': _u(1.0), 'week': _u(4.2), 'month': _u(9.0)},
      ),
      _card(
        2,
        2,
        'receivables',
        'Receivables',
        MdMarker.warning,
        _v(642800, 171410, 629400),
        {'day': _d(0.6), 'week': _d(2.1), 'month': _u(2.9)},
      ),
      _card(
        2,
        3,
        'payables',
        'Payables',
        MdMarker.primary,
        _v(489050, 130410, 478800),
        {'day': null, 'week': _u(1.8), 'month': _u(4.6)},
      ),
    ],
    actions: const [
      MdAction('sale', 'Sale', 'create'),
      MdAction('purchase', 'Purchase', 'create'),
      MdAction('quotation', 'Quotation', 'create'),
      MdAction('return', 'Return', 'create'),
      MdAction('customers', 'Customers', 'manage'),
      MdAction('suppliers', 'Suppliers', 'manage'),
      MdAction('inventory', 'Inventory', 'manage'),
      MdAction('pricelist', 'Price Lists', 'manage'),
      MdAction('reports', 'Reports', 'manage'),
      MdAction('items', 'Items', 'manage'),
    ],
    operations: const [
      MdOperation(
        reference: 'INV-S-2291',
        type: 'Sale',
        tone: MdTone.success,
        description: 'Gulf Contracting Ltd',
        amounts: {'SAR': 96400, 'USD': 25700, 'AED': 94380},
        direction: MdDirection.credit,
        timeLabel: '30m ago',
      ),
      MdOperation(
        reference: 'INV-P-0884',
        type: 'Purchase',
        tone: MdTone.information,
        description: 'Saudi Steel Co',
        amounts: {'SAR': 142800, 'USD': 38080, 'AED': 139800},
        direction: MdDirection.debit,
        timeLabel: '3h ago',
      ),
      MdOperation(
        reference: 'INV-S-2290',
        type: 'Sale',
        tone: MdTone.success,
        description: 'Najd Builders',
        amounts: {'SAR': 53200, 'USD': 14190, 'AED': 52080},
        direction: MdDirection.credit,
        timeLabel: 'Yesterday',
      ),
      MdOperation(
        reference: 'INV-S-2289',
        type: 'Sale',
        tone: MdTone.success,
        description: 'Coastal Cement',
        amounts: {'SAR': 31750, 'USD': 8470, 'AED': 31080},
        direction: MdDirection.credit,
        timeLabel: 'Yesterday',
      ),
      MdOperation(
        reference: 'INV-P-0883',
        type: 'Purchase',
        tone: MdTone.information,
        description: 'Eastern Timber',
        amounts: {'SAR': 27400, 'USD': 7300, 'AED': 26820},
        direction: MdDirection.debit,
        timeLabel: '2 days ago',
      ),
    ],
  ),
];

final mdAxis = {
  'day': ['9a', '12p', '3p', '6p', 'now'],
  'week': ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
  'month': ['W1', 'W2', 'W3', 'W4', 'W5', 'W6', 'W7', 'W8'],
};

const Map<String, MdDashboardProfile> mdProfiles = {
  'banking': MdDashboardProfile(
    sectionId: 'banking',
    eyebrow: 'TREASURY & CASH MANAGEMENT',
    title: 'Banking control center',
    subtitle:
        'Monitor liquidity, bank positions, transfers, and reconciliation activity across every legal entity.',
    primaryActionId: 'transfer',
    primaryActionLabel: 'New transfer',
    statusTitle: 'Treasury status',
    workflowTitle: 'Treasury workflow',
    workflowSubtitle: 'Items that require action before the next cut-off.',
    operationsTitle: 'Latest bank movements',
    attentionTitle: 'Treasury exceptions',
    statusItems: [
      MdStatusItem(
        id: 'bank-accounts',
        label: 'Connected accounts',
        value: '8',
        description: 'Across 3 banks',
        tone: MdTone.information,
      ),
      MdStatusItem(
        id: 'reconciliation',
        label: 'Reconciliation',
        value: '96%',
        description: '3 statements pending',
        tone: MdTone.success,
      ),
      MdStatusItem(
        id: 'approvals',
        label: 'Payment approvals',
        value: '5',
        description: 'SAR 284K awaiting release',
        tone: MdTone.warning,
      ),
    ],
    workflowItems: [
      MdWorkflowItem(
        id: 'approve-payments',
        title: 'Approve payment batch',
        description: 'Payroll and supplier wires',
        value: '5 items',
        tone: MdTone.warning,
      ),
      MdWorkflowItem(
        id: 'reconcile-statements',
        title: 'Reconcile bank statements',
        description: 'Riyad Bank and SNB',
        value: '3 open',
        tone: MdTone.information,
      ),
      MdWorkflowItem(
        id: 'cash-forecast',
        title: 'Review 13-week cash forecast',
        description: 'Updated with current commitments',
        value: 'Today',
        tone: MdTone.success,
      ),
    ],
    attentionItems: [
      MdAttention(
        'bank-reconciliation',
        MdTone.warning,
        3,
        'Unreconciled statements',
        'Bank statement lines remain unmatched',
      ),
      MdAttention(
        'payment-approvals',
        MdTone.danger,
        5,
        'Payments awaiting approval',
        'Transfers are approaching the bank cut-off',
      ),
      MdAttention(
        'bank-sync',
        MdTone.information,
        1,
        'Bank feed delayed',
        'One account has not synchronized today',
      ),
    ],
  ),
  'accounting': MdDashboardProfile(
    sectionId: 'accounting',
    eyebrow: 'GENERAL LEDGER & FINANCIAL CONTROL',
    title: 'Accounting command center',
    subtitle:
        'Track close readiness, posting health, balances, and control exceptions from one operational workspace.',
    primaryActionId: 'journal',
    primaryActionLabel: 'Post journal',
    statusTitle: 'Close readiness',
    workflowTitle: 'Period-close workflow',
    workflowSubtitle: 'Priority tasks for an accurate and controlled close.',
    operationsTitle: 'Recent postings',
    attentionTitle: 'Accounting exceptions',
    statusItems: [
      MdStatusItem(
        id: 'period',
        label: 'Open period',
        value: 'DEC 2024',
        description: 'Closes in 4 days',
        tone: MdTone.information,
      ),
      MdStatusItem(
        id: 'trial-balance',
        label: 'Trial balance',
        value: 'Balanced',
        description: 'No variance detected',
        tone: MdTone.success,
      ),
      MdStatusItem(
        id: 'unposted',
        label: 'Unposted journals',
        value: '7',
        description: '2 require approval',
        tone: MdTone.warning,
      ),
    ],
    workflowItems: [
      MdWorkflowItem(
        id: 'post-recurring',
        title: 'Post recurring journals',
        description: 'Rent, payroll, and depreciation',
        value: '4 batches',
        tone: MdTone.warning,
      ),
      MdWorkflowItem(
        id: 'review-control',
        title: 'Review control accounts',
        description: 'AR, AP, inventory, and tax',
        value: '2 variances',
        tone: MdTone.danger,
      ),
      MdWorkflowItem(
        id: 'lock-subledgers',
        title: 'Lock operational subledgers',
        description: 'After final posting review',
        value: 'Pending',
        tone: MdTone.information,
      ),
    ],
    attentionItems: [
      MdAttention(
        'oob',
        MdTone.danger,
        2,
        'Out-of-balance entries',
        'Debits and credits do not match',
      ),
      MdAttention(
        'unposted-journals',
        MdTone.warning,
        7,
        'Unposted journals',
        'Draft and approval queues remain open',
      ),
      MdAttention(
        'control-variance',
        MdTone.information,
        2,
        'Control account variances',
        'AR and inventory require investigation',
      ),
    ],
  ),
  'commercial': MdDashboardProfile(
    sectionId: 'commercial',
    eyebrow: 'SALES, PURCHASING & ORDER FULFILMENT',
    title: 'Commercial operations center',
    subtitle:
        'Manage revenue execution, procurement commitments, receivables, and fulfilment risks across the business.',
    primaryActionId: 'sale',
    primaryActionLabel: 'Create sales order',
    statusTitle: 'Commercial pulse',
    workflowTitle: 'Order-to-cash workflow',
    workflowSubtitle:
        'Operational work that can affect revenue and customer service.',
    operationsTitle: 'Latest commercial documents',
    attentionTitle: 'Commercial exceptions',
    statusItems: [
      MdStatusItem(
        id: 'orders',
        label: 'Open sales orders',
        value: '26',
        description: 'SAR 1.14M pipeline',
        tone: MdTone.information,
      ),
      MdStatusItem(
        id: 'fulfilment',
        label: 'On-time fulfilment',
        value: '93%',
        description: '4 orders at risk',
        tone: MdTone.success,
      ),
      MdStatusItem(
        id: 'overdue',
        label: 'Overdue receivables',
        value: '8',
        description: 'SAR 176K overdue',
        tone: MdTone.warning,
      ),
    ],
    workflowItems: [
      MdWorkflowItem(
        id: 'release-orders',
        title: 'Release blocked sales orders',
        description: 'Credit and margin checks',
        value: '4 orders',
        tone: MdTone.warning,
      ),
      MdWorkflowItem(
        id: 'confirm-purchases',
        title: 'Confirm purchase commitments',
        description: 'Lead-time changes from suppliers',
        value: '6 lines',
        tone: MdTone.information,
      ),
      MdWorkflowItem(
        id: 'collect-overdue',
        title: 'Follow up overdue invoices',
        description: 'Top customer balances',
        value: '8 accounts',
        tone: MdTone.danger,
      ),
    ],
    attentionItems: [
      MdAttention(
        'credit-holds',
        MdTone.danger,
        4,
        'Orders on credit hold',
        'Customer limits or overdue balances exceeded',
      ),
      MdAttention(
        'stock-shortage',
        MdTone.warning,
        6,
        'Fulfilment shortages',
        'Committed quantities exceed available stock',
      ),
      MdAttention(
        'supplier-delay',
        MdTone.information,
        3,
        'Supplier delivery changes',
        'Expected dates were updated by vendors',
      ),
    ],
  ),
};

final mobileDashboardCatalog = MobileDashboardCatalog(
  tabs: mdTabs,
  workspaces: mdWorkspaces,
  attention: mdAttention,
  currencies: mdCurrencies,
  axisLabels: mdAxis,
  profiles: mdProfiles,
);
