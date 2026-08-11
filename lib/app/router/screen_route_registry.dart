/// Maps legacy screen IDs (from the legacy screen registry) to GoRouter
/// route paths.  This adapter lets us migrate `nav.go('screenId')` →
/// `context.go(routePath)` one screen at a time.
///
/// USAGE
/// ```dart
/// ScreenRouteRegistry.path('accountDetail')       // → '/accounts/detail'
/// ScreenRouteRegistry.path('currenciesList')       // → '/currencies'
/// ScreenRouteRegistry.hasRoute('unknown')          // → false
/// ```
class ScreenRouteRegistry {
  ScreenRouteRegistry._();

  static const Map<String, String> _screenToPath = {
    // ── Tabs ──
    'dashboard': '/dashboard',
    'accounts': '/accounts',
    'stores': '/stores',
    'more': '/more',

    // ── Mobile Dashboard ──
    'mobileDashboard': '/mobile-dashboard/banking',
    'mobileBankingDashboard': '/mobile-dashboard/banking',
    'mobileAccountingDashboard': '/mobile-dashboard/accounting',
    'mobileCommercialDashboard': '/mobile-dashboard/commercial',

    // ── Accounts ──
    'accountDetail': '/accounts/detail',
    'createAccount': '/accounts/create',
    'groupDetail': '/accounts/group-detail',
    'createGroup': '/accounts/create-group',
    'accountTree': '/account-tree',

    // ── Stores ──
    'createStore': '/stores/create',
    'storeDetail': '/stores/detail',
    'issue': '/stores/issue',

    // ── Ledger ──
    'journal': '/ledger/opening',
    'opDetail': '/ledger/operation-detail',
    'journalList': '/journal-entries',
    'createJournalEntry': '/journal-entries/create',
    'journalEntryDetail': '/journal-entries/detail',

    // ── Banking · Cash ──
    'createDeposit': '/banking/deposits/create',
    'depositDetail': '/banking/deposits/detail',
    'createWithdrawal': '/banking/withdrawals/create',
    'withdrawalDetail': '/banking/withdrawals/detail',

    // ── Banking · Transfers ──
    'createLocalTransfer': '/banking/transfers/local/create',
    'localTransferDetail': '/banking/transfers/local/detail',
    'createExternalTransfer': '/banking/transfers/external/create',
    'externalTransferDetail': '/banking/transfers/external/detail',

    // ── Products & Inventory ──
    'productsList': '/products',
    'productDetail': '/products/detail',
    'createProduct': '/products/create',
    'invDashboard': '/inventory',
    'warehousesList': '/warehouses',
    'transferList': '/stock-transfers',
    'transferCreate': '/inventory/transfers/create',
    'transferDetail': '/inventory/transfers/detail',
    'issueDetail': '/inventory/issue-detail',
    'receiveCreate': '/inventory/receive',
    'receiveDetail': '/inventory/receive-detail',
    'adjustment': '/inventory/adjustment',
    'stockTake': '/inventory/stocktake',
    'categories': '/inventory/categories',
    'uom': '/inventory/uom',
    'priceLists': '/price-lists',
    'barcodePrint': '/barcode-print',

    // ── Currencies ──
    'currenciesList': '/currencies',
    'createCurrency': '/currencies/create',
    'currencyDetail': '/currencies/detail',
    'exchangeRateSetup': '/exchange-rates',
    'fiscalYearSetup': '/fiscal-year',

    // ── Contacts ──
    'customersList': '/customers',
    'customerDetail': '/customers/detail',
    'createCustomer': '/customers/create',
    'suppliersList': '/suppliers',
    'supplierDetail': '/suppliers/detail',
    'createSupplier': '/suppliers/create',

    // ── Reports ──
    'trialBalance': '/reports/trial-balance',
    'incomeStatement': '/reports/income-statement',
    'balanceSheet': '/reports/balance-sheet',
    'inventoryValuation': '/reports/inventory-valuation',
    'auditLog': '/reports/audit-log',

    // ── Administration ──
    'usersList': '/admin/users',
    'userDetail': '/admin/users/detail',
    'createUser': '/admin/users/create',
    'rolesPermissions': '/admin/roles',

    // ── Settings ──
    'settingsHub': '/settings',
    'setCompany': '/settings/company',
    'setFinancial': '/settings/financial',
    'setTaxes': '/settings/taxes',
    'setCurrencies': '/settings/currencies',
    'setNumbering': '/settings/numbering',
    'setBranches': '/settings/branches',
    'rolesList': '/admin/roles-list',
    'roleEditor': '/admin/roles/edit',
    'tenants': '/settings/workspaces',
    'setIntegrations': '/settings/integrations',
    'setWebhooks': '/settings/webhooks',
    'setApiKeys': '/settings/api-keys',
    'setNotifications': '/settings/notifications',
    'setBilling': '/settings/billing',
    'setBackup': '/settings/backup',
  };

  /// Returns the GoRouter path for [screenId], or `null` if unmapped.
  static String? path(String screenId) => _screenToPath[screenId];

  /// Returns true when [screenId] has a registered route.
  static bool hasRoute(String screenId) => _screenToPath.containsKey(screenId);
}
