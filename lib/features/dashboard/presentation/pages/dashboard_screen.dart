// ============================================================
// VIEW — Dashboard tab (ports MDashboard)
// KPI row · cash-flow bars · balances · recent ops · alerts
// Wraps a responsive NavigationSidebar with all nav items
// from the More menu, plus a built-in search bar.
// ============================================================

import 'package:flutter/material.dart';
import 'package:super_navigation_sidebar/super_navigation_sidebar.dart';
import '../../../../design_system/kit.dart';
import '../../../../workspace/presentation/bloc/nav_cubit.dart';

// ── Navigation sections (mirrors the data in more_screen.dart) ──
const _navSections = <NavSection<String>>[
  NavSection(title: 'Workspace', items: [
    NavNode(id: 'mobileDashboard', label: 'Mobile Dashboard', value: 'mobileDashboard'),
    NavNode(id: 'settingsHub', label: 'Settings', value: 'settingsHub'),
  ]),
  NavSection(title: 'Accounts', items: [
    NavNode(id: 'accountTree', label: 'Account Tree', value: 'accountTree'),
    NavNode(id: 'createGroup', label: 'Create Account Group', value: 'createGroup'),
  ]),
  NavSection(title: 'Products', items: [
    NavNode(id: 'productsList', label: 'Products List', value: 'productsList'),
    NavNode(id: 'createProduct', label: 'Create Product', value: 'createProduct'),
  ]),
  NavSection(title: 'Inventory', items: [
    NavNode(id: 'invDashboard', label: 'Inventory Dashboard', value: 'invDashboard'),
    NavNode(id: 'warehousesList', label: 'Warehouses', value: 'warehousesList'),
    NavNode(id: 'transferList', label: 'Stock Transfers', value: 'transferList'),
    NavNode(id: 'issueDetail', label: 'Issue — Details', value: 'issueDetail'),
    NavNode(id: 'receiveCreate', label: 'Receive Inventory', value: 'receiveCreate'),
    NavNode(id: 'receiveDetail', label: 'Receive — Details', value: 'receiveDetail'),
    NavNode(id: 'transferCreate', label: 'Transfer Inventory', value: 'transferCreate'),
    NavNode(id: 'transferDetail', label: 'Transfer — Details', value: 'transferDetail'),
    NavNode(id: 'adjustment', label: 'Inventory Adjustment', value: 'adjustment'),
    NavNode(id: 'stockTake', label: 'Stock Take', value: 'stockTake'),
    NavNode(id: 'categories', label: 'Categories', value: 'categories'),
    NavNode(id: 'uom', label: 'Units of Measure', value: 'uom'),
    NavNode(id: 'priceLists', label: 'Price Lists', value: 'priceLists'),
    NavNode(id: 'barcodePrint', label: 'Barcode Print', value: 'barcodePrint'),
  ]),
  NavSection(title: 'Ledger', items: [
    NavNode(id: 'journalList', label: 'Journal Entries', value: 'journalList'),
    NavNode(id: 'createJournalEntry', label: 'Create Journal Entry', value: 'createJournalEntry'),
    NavNode(id: 'journalEntryDetail', label: 'Journal Entry Details', value: 'journalEntryDetail'),
    NavNode(id: 'journal', label: 'Opening Journal Entry', value: 'journal'),
    NavNode(id: 'opDetail', label: 'Financial Operation', value: 'opDetail'),
  ]),
  NavSection(title: 'Sales · Customers', items: [
    NavNode(id: 'customersList', label: 'Customers', value: 'customersList'),
    NavNode(id: 'createCustomer', label: 'Add Customer', value: 'createCustomer'),
  ]),
  NavSection(title: 'Procurement · Suppliers', items: [
    NavNode(id: 'suppliersList', label: 'Suppliers', value: 'suppliersList'),
    NavNode(id: 'createSupplier', label: 'Add Supplier', value: 'createSupplier'),
  ]),
  NavSection(title: 'Configuration', items: [
    NavNode(id: 'currenciesList', label: 'Currencies', value: 'currenciesList'),
    NavNode(id: 'createCurrency', label: 'Add Currency', value: 'createCurrency'),
    NavNode(id: 'exchangeRateSetup', label: 'Exchange Rates', value: 'exchangeRateSetup'),
    NavNode(id: 'fiscalYearSetup', label: 'Fiscal Year', value: 'fiscalYearSetup'),
  ]),
  NavSection(title: 'Banking · Cash', items: [
    NavNode(id: 'createDeposit', label: 'Create Deposit', value: 'createDeposit'),
    NavNode(id: 'depositDetail', label: 'Deposit Receipt', value: 'depositDetail'),
    NavNode(id: 'createWithdrawal', label: 'Create Withdrawal', value: 'createWithdrawal'),
    NavNode(id: 'withdrawalDetail', label: 'Withdrawal Voucher', value: 'withdrawalDetail'),
  ]),
  NavSection(title: 'Banking · Transfers', items: [
    NavNode(id: 'createLocalTransfer', label: 'Create Local Transfer', value: 'createLocalTransfer'),
    NavNode(id: 'localTransferDetail', label: 'Local Transfer Details', value: 'localTransferDetail'),
    NavNode(id: 'createExternalTransfer', label: 'Create External Transfer', value: 'createExternalTransfer'),
    NavNode(id: 'externalTransferDetail', label: 'External Wire Details', value: 'externalTransferDetail'),
  ]),
  NavSection(title: 'Reports', items: [
    NavNode(id: 'trialBalance', label: 'Trial Balance', value: 'trialBalance'),
    NavNode(id: 'incomeStatement', label: 'Income Statement', value: 'incomeStatement'),
    NavNode(id: 'balanceSheet', label: 'Balance Sheet', value: 'balanceSheet'),
    NavNode(id: 'inventoryValuation', label: 'Inventory Valuation', value: 'inventoryValuation'),
    NavNode(id: 'auditLog', label: 'Audit Log', value: 'auditLog'),
  ]),
  NavSection(title: 'Administration', items: [
    NavNode(id: 'usersList', label: 'Users', value: 'usersList'),
    NavNode(id: 'createUser', label: 'Invite User', value: 'createUser'),
    NavNode(id: 'rolesPermissions', label: 'Roles & Permissions', value: 'rolesPermissions'),
  ]),
];

// ── Dashboard content data ───────────────────────────────────
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

// ── DashboardScreen with sidebar ────────────────────────────
class DashboardScreen extends StatefulWidget {
  final NavCubit nav;
  const DashboardScreen({super.key, required this.nav});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final NavigationSidebarController<String> _sidebarController;
  NavSidebarMode? _prevMode;

  @override
  void initState() {
    super.initState();
    _sidebarController = NavigationSidebarController<String>(
      sections: _navSections,
    );
  }

  void _syncMode(NavSidebarMode mode) {
    if (mode == _prevMode) return;
    _prevMode = mode;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (mode == NavSidebarMode.expanded) { _sidebarController.collapsed = false; }
      else if (mode == NavSidebarMode.rail) { _sidebarController.collapsed = true; }
      else { _sidebarController.closeDrawer(); }
    });
  }

  @override
  void dispose() {
    _sidebarController.dispose();
    super.dispose();
  }

  Widget _buildNavSidebar(NavSidebarMode mode) {
    return NavigationSidebar<String>(
      controller: _sidebarController,
      mode: mode,
      searchable: true,
      searchHint: 'Search every screen…',
      drawerTitle: 'Navigation',
      showGuides: true,
      railFlyouts: true,
      onNavigate: (node) {
        final v = node.value;
        if (v != null) widget.nav.go(v);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final mode = const NavSidebarBreakpoints().modeFor(c.maxWidth);
      _syncMode(mode);

      final body = MScroll([
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
        const MCard(
          marker: M.green,
          title: 'Cash Flow',
          sub: 'Inflow vs outflow · SAR thousands · 12 months',
          right: Row(mainAxisSize: MainAxisSize.min, children: [
            _Legend(color: M.blue, label: 'In'), SizedBox(width: 12), _Legend(color: M.fg4, label: 'Out'),
          ]),
          children: [_CashFlowBars()],
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
          right: GestureDetector(onTap: () => widget.nav.go('journalList'),
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

      if (mode == NavSidebarMode.drawer) {
        return Stack(children: [
          Positioned.fill(child: body),
          Positioned.fill(child: _buildNavSidebar(mode)),
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _sidebarController.openDrawer,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: M.surface.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: M.border),
                    ),
                    child: Icon(MIcons.of('menu'), size: 20, color: M.blue),
                  ),
                ),
              ),
            ),
          ),
        ]);
      }
      return Row(children: [
        _buildNavSidebar(mode),
        Expanded(child: body),
      ]);
    });
  }
}

// ── Presentational widgets (unchanged) ──────────────────────
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
