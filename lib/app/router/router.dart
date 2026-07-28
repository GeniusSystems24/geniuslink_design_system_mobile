// ============================================================
// GeniusLink Mobile — GoRouter (manual configuration)
// Sub-screen routes are top-level with parentNavigatorKey:
// rootNavigatorKey so they push above the shell.  Navigation
// calls use push() (not go()) so the back stack is preserved.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_core/super_core.dart' as super_core;
import '../../features/auth/presentation/pages/auth_screen.dart';
import '../../features/dashboard/presentation/pages/dashboard_screen.dart';
import '../../features/accounts/data/data.dart';
import '../../features/admin/data/data.dart';
import '../../features/contacts/data/data.dart';
import '../../features/dashboard/data/data.dart';
import '../../features/mobile_dashboard/data/data.dart';
import '../../features/config/data/data.dart';
import '../../features/inventory/data/data.dart';
import '../../features/ledger/data/data.dart';
import '../../features/settings/data/data.dart';
import '../../features/stores/data/data.dart';
import '../../features/accounts/presentation/pages/accounts_screens.dart';
import '../../features/stores/presentation/pages/stores_screens.dart';
import '../../features/more/presentation/pages/more_screen.dart';
import '../../features/ledger/presentation/pages/ledger_screens.dart';
import '../../features/ledger/presentation/pages/journal_screens.dart';
import '../../features/banking/presentation/pages/banking_cash_screens.dart';
import '../../features/banking/presentation/pages/banking_transfer_screens.dart';
import '../../features/inventory/presentation/pages/products_list_screen.dart';
import '../../features/inventory/presentation/pages/create_product_screen.dart';
import '../../features/inventory/presentation/pages/product_detail_screen.dart';
import '../../features/inventory/presentation/pages/issue_detail_screen.dart';
import '../../features/inventory/presentation/pages/receive_create_screen.dart';
import '../../features/inventory/presentation/pages/receive_detail_screen.dart';
import '../../features/inventory/presentation/pages/transfer_create_screen.dart';
import '../../features/inventory/presentation/pages/transfer_detail_screen.dart';
import '../../features/inventory/presentation/pages/adjustment_screen.dart';
import '../../features/inventory/presentation/pages/inv_dashboard_screen.dart';
import '../../features/inventory/presentation/pages/stock_take_screen.dart';
import '../../features/inventory/presentation/pages/categories_screen.dart';
import '../../features/inventory/presentation/pages/uom_screen.dart';
import '../../features/inventory/presentation/pages/price_lists_screen.dart';
import '../../features/inventory/presentation/pages/barcode_print_screen.dart';
import '../../features/inventory/presentation/pages/warehouses_list_screen.dart';
import '../../features/inventory/presentation/pages/transfer_list_screen.dart';
import '../../features/accounts/presentation/pages/create_account_screen.dart';
import '../../features/accounts/presentation/pages/group_detail_screen.dart';
import '../../features/accounts/presentation/pages/create_group_screen.dart';
import '../../features/accounts/presentation/pages/accounts_extra_screens.dart';
import '../../features/config/presentation/pages/currencies_screens.dart';
import '../../features/contacts/presentation/pages/contacts_screens.dart';
import '../../features/reports/presentation/pages/reports_screens.dart';
import '../../features/admin/presentation/pages/users_screens.dart';
import '../../features/settings/presentation/pages/settings_org_screens.dart';
import '../../features/settings/presentation/pages/settings_team_screens.dart';
import '../../features/settings/presentation/pages/settings_platform_screens.dart';
import '../../features/mobile_dashboard/presentation/pages/pages.dart';
import '../../workspace/presentation/bloc/nav_cubit.dart';
import 'workspace_shell.dart';

// ════════════════════════════════════════════════════════════
// Root navigator key
// ════════════════════════════════════════════════════════════

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

// ════════════════════════════════════════════════════════════
// Auth redirect
// ════════════════════════════════════════════════════════════

class AuthNotifier extends ChangeNotifier {
  bool _authed = false;
  bool get authed => _authed;
  void setAuthed(bool v) {
    if (_authed == v) return;
    _authed = v;
    notifyListeners();
  }
}

final authNotifier = AuthNotifier();

String? _authRedirect(BuildContext context, GoRouterState state) {
  final authed = authNotifier.authed;
  final location = state.matchedLocation;
  if (!authed &&
      location != '/login' &&
      location != '/signup' &&
      location != '/forgot') {
    return '/login';
  }
  if (authed &&
      (location == '/login' ||
          location == '/signup' ||
          location == '/forgot')) {
    return '/dashboard';
  }
  return null;
}

// ════════════════════════════════════════════════════════════
// Helper — top-level sub-route pushed above the shell.
// GoRouter v17 requires routes with parentNavigatorKey:
// rootNavigatorKey to be at the top level of routes (not inside
// a StatefulShellBranch). They push full-screen above the shell;
// the back stack is maintained via goTo() using push().
// ════════════════════════════════════════════════════════════

GoRoute _sub(String path, Widget Function(BuildContext, GoRouterState) builder) {
  return GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: path,
    builder: builder,
  );
}

// ════════════════════════════════════════════════════════════
// Router
// ════════════════════════════════════════════════════════════

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/login',
  refreshListenable: authNotifier,
  redirect: _authRedirect,
  routes: [
    // ── Auth (top-level, no shell) ────────────────────────
    GoRoute(
      path: '/login',
      builder: (ctx, state) => LoginScreen(nav: ctx.read<NavCubit>()),
    ),
    GoRoute(
      path: '/signup',
      builder: (ctx, state) => SignUpScreen(nav: ctx.read<NavCubit>()),
    ),
    GoRoute(
      path: '/forgot',
      builder: (ctx, state) => ForgotScreen(nav: ctx.read<NavCubit>()),
    ),

    // ── Sub-screens (top-level, pushed above the shell) ───
    // GoRouter v17 requires parentNavigatorKey: rootNavigatorKey
    // routes to be top-level siblings of the StatefulShellRoute,
    // not nested inside a branch. Navigation uses push() so the
    // back stack always contains the shell as the previous entry.

    // Mobile dashboards
    _sub(
      '/mobile-dashboard',
      (ctx, state) => const MobileDashboardScreen(repository: BankingRepository()),
    ),
    _sub(
      '/mobile-dashboard/banking',
      (ctx, state) => const MobileDashboardScreen(repository: BankingRepository()),
    ),
    _sub(
      '/mobile-dashboard/accounting',
      (ctx, state) => const MobileDashboardScreen(repository: AccountingRepository()),
    ),
    _sub(
      '/mobile-dashboard/commercial',
      (ctx, state) => const MobileDashboardScreen(repository: CommercialRepository()),
    ),

    // Accounts
    _sub('/accounts/create',      (ctx, state) => const CreateAccountScreen()),
    _sub('/accounts/detail',      (ctx, state) => const AccountDetailFullScreen()),
    _sub('/accounts/create-group', (ctx, state) => const CreateGroupScreen()),
    _sub('/accounts/group-detail', (ctx, state) => const GroupDetailScreen()),
    _sub('/account-tree',          (ctx, state) => const AccountTreeScreen(roots: MockAccountsDataSource.chart)),

    // Stores
    _sub('/stores/create', (ctx, state) => const CreateStoreScreen()),
    _sub('/stores/detail', (ctx, state) => StoreDetailScreen(store: MockStoresDataSource.stores.first)),
    _sub('/stores/issue',  (ctx, state) => const IssueInventoryScreen()),

    // Ledger
    _sub('/ledger/opening',          (ctx, state) => const OpeningJournalScreen()),
    _sub('/ledger/operation-detail', (ctx, state) => const OpDetailScreen()),
    _sub('/journal-entries',         (ctx, state) => JournalListScreen(entries: MockLedgerDataSource.entries)),
    _sub('/journal/create',          (ctx, state) => const CreateJournalEntryScreen(accounts: MockLedgerDataSource.accounts)),
    _sub('/journal/detail',          (ctx, state) => JournalEntryDetailScreen(entry: MockLedgerDataSource.entries.first)),

    // Banking · Cash
    _sub('/banking/deposits/create',    (ctx, state) => const CreateDepositScreen()),
    _sub('/banking/deposits/detail',    (ctx, state) => const DepositDetailScreen()),
    _sub('/banking/withdrawals/create', (ctx, state) => const CreateWithdrawalScreen()),
    _sub('/banking/withdrawals/detail', (ctx, state) => const WithdrawalDetailScreen()),

    // Banking · Transfers
    _sub('/banking/transfers/local/create',    (ctx, state) => const CreateLocalTransferScreen()),
    _sub('/banking/transfers/local/detail',    (ctx, state) => const LocalTransferDetailScreen()),
    _sub('/banking/transfers/external/create', (ctx, state) => const CreateExternalTransferScreen()),
    _sub('/banking/transfers/external/detail', (ctx, state) => const ExternalTransferDetailScreen()),

    // Products
    _sub('/products',        (ctx, state) => const ProductsListScreen(products: MockInventoryDataSource.products)),
    _sub('/products/detail', (ctx, state) => ProductDetailScreen(detail: MockInventoryDataSource.productDetail)),
    _sub('/products/create', (ctx, state) => const CreateProductScreen()),

    // Inventory
    _sub('/inventory',                    (ctx, state) => const InvDashboardScreen()),
    _sub('/warehouses',                   (ctx, state) => const WarehousesListScreen()),
    _sub('/stock-transfers',              (ctx, state) => const TransferListScreen()),
    _sub('/inventory/issue-detail',       (ctx, state) => const IssueDetailScreen()),
    _sub('/inventory/receive',            (ctx, state) => const ReceiveCreateScreen()),
    _sub('/inventory/receive-detail',     (ctx, state) => const ReceiveDetailScreen()),
    _sub('/inventory/transfers/create',   (ctx, state) => const TransferCreateScreen()),
    _sub('/inventory/transfers/detail',   (ctx, state) => const TransferDetailScreen()),
    _sub('/inventory/adjustment',         (ctx, state) => const AdjustmentScreen()),
    _sub('/inventory/stocktake',          (ctx, state) => const StockTakeScreen()),
    _sub('/inventory/categories',         (ctx, state) => const CategoriesScreen()),
    _sub('/inventory/uom',                (ctx, state) => const UomScreen()),
    _sub('/price-lists',                  (ctx, state) => const PriceListsScreen()),
    _sub('/barcode-print',                (ctx, state) => const BarcodePrintScreen()),

    // Currencies / Config
    _sub('/currencies',        (ctx, state) => CurrenciesListScreen(currencies: MockConfigDataSource.currencies)),
    _sub('/currencies/create', (ctx, state) => const CreateCurrencyScreen()),
    _sub('/currencies/detail', (ctx, state) => CurrencyDetailScreen(currency: MockConfigDataSource.currencies[1])),
    _sub('/exchange-rates',    (ctx, state) => const ExchangeRateSetupScreen()),
    _sub('/fiscal-year',       (ctx, state) => const FiscalYearSetupScreen()),

    // Contacts — Customers
    _sub('/customers',        (ctx, state) => ContactListScreen(kind: MockContactsDataSource.customer, detailKey: 'customerDetail')),
    _sub('/customers/detail', (ctx, state) => ContactDetailScreen(kind: MockContactsDataSource.customer)),
    _sub('/customers/create', (ctx, state) => CreateContactScreen(kind: MockContactsDataSource.customer)),

    // Contacts — Suppliers
    _sub('/suppliers',        (ctx, state) => ContactListScreen(kind: MockContactsDataSource.supplier, detailKey: 'supplierDetail')),
    _sub('/suppliers/detail', (ctx, state) => ContactDetailScreen(kind: MockContactsDataSource.supplier)),
    _sub('/suppliers/create', (ctx, state) => CreateContactScreen(kind: MockContactsDataSource.supplier)),

    // Reports
    _sub('/reports/trial-balance',       (ctx, state) => const TrialBalanceScreen()),
    _sub('/reports/income-statement',    (ctx, state) => const IncomeStatementScreen()),
    _sub('/reports/balance-sheet',       (ctx, state) => const BalanceSheetScreen()),
    _sub('/reports/inventory-valuation', (ctx, state) => const InventoryValuationScreen()),
    _sub('/reports/audit-log',           (ctx, state) => const AuditLogScreen()),

    // Administration
    _sub('/admin/users',        (ctx, state) => const UsersListScreen(users: MockAdminDataSource.users)),
    _sub('/admin/users/detail', (ctx, state) => const UserDetailScreen()),
    _sub('/admin/users/create', (ctx, state) => const CreateUserScreen()),
    _sub('/admin/roles',        (ctx, state) => const RolesPermissionsScreen()),
    _sub('/admin/roles-list',   (ctx, state) => const RolesListScreen()),
    _sub('/admin/roles/edit',   (ctx, state) => const RoleEditorScreen(modules: MockSettingsDataSource.roleModules, initialAccess: MockSettingsDataSource.roleAccess)),

    // Settings — Organisation
    _sub('/settings',              (ctx, state) => const SettingsHubScreen()),
    _sub('/settings/company',      (ctx, state) => const CompanyProfileScreen()),
    _sub('/settings/financial',    (ctx, state) => const FinancialSettingsScreen()),
    _sub('/settings/taxes',        (ctx, state) => const TaxesSettingsScreen()),
    _sub('/settings/currencies',   (ctx, state) => const CurrenciesSettingsScreen()),
    _sub('/settings/numbering',    (ctx, state) => const NumberingScreen()),
    _sub('/settings/branches',     (ctx, state) => const BranchesStoresScreen()),
    _sub('/settings/workspaces',   (ctx, state) => const TenantsScreen()),

    // Settings — Platform
    _sub('/settings/integrations',  (ctx, state) => const IntegrationsScreen(integrations: MockSettingsDataSource.integrations)),
    _sub('/settings/webhooks',      (ctx, state) => const WebhooksScreen()),
    _sub('/settings/api-keys',      (ctx, state) => const ApiKeysScreen()),
    _sub('/settings/notifications', (ctx, state) => const NotificationsScreen(categories: MockSettingsDataSource.notificationCategories, channels: MockSettingsDataSource.notificationChannels)),
    _sub('/settings/billing',       (ctx, state) => const BillingScreen()),
    _sub('/settings/backup',        (ctx, state) => const BackupScreen()),

    // ── Shell with four tab branches ─────────────────────
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => Scaffold(
        backgroundColor: super_core.SuperMaterialThemeData.of(context).colorScheme.surface,
        body: WorkspaceShell(navigationShell: shell),
      ),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/dashboard',
            builder: (ctx, state) => const DashboardScreen(snapshot: MockDashboardDataSource.snapshot),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/accounts',
            builder: (ctx, state) => const AccountsScreen(accounts: MockAccountsDataSource.list),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/stores',
            builder: (ctx, state) => const StoresScreen(stores: MockStoresDataSource.stores),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/more',
            builder: (ctx, state) => const MoreScreen(),
          ),
        ]),
      ],
    ),
  ],
);
