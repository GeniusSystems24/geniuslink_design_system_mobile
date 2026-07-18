class NavigationItem {
  final String label;
  final String routeId;
  const NavigationItem({required this.label, required this.routeId});
}

class NavigationGroup {
  final String title;
  final List<NavigationItem> items;
  const NavigationGroup({required this.title, required this.items});
}

const defaultMoreNavigationGroups = <NavigationGroup>[
  NavigationGroup(
    title: 'Workspace',
    items: [
      NavigationItem(
        label: 'Banking Dashboard',
        routeId: 'mobileBankingDashboard',
      ),
      NavigationItem(
        label: 'Accounting Dashboard',
        routeId: 'mobileAccountingDashboard',
      ),
      NavigationItem(
        label: 'Commercial Dashboard',
        routeId: 'mobileCommercialDashboard',
      ),
      NavigationItem(label: 'Settings', routeId: 'settingsHub'),
    ],
  ),
  NavigationGroup(title: 'Accounts', items: [NavigationItem(label: 'Account Tree', routeId: 'accountTree'), NavigationItem(label: 'Create Account Group', routeId: 'createGroup')]),
  NavigationGroup(title: 'Products', items: [NavigationItem(label: 'Products List', routeId: 'productsList'), NavigationItem(label: 'Create Product', routeId: 'createProduct')]),
  NavigationGroup(title: 'Inventory', items: [
    NavigationItem(label: 'Inventory Dashboard', routeId: 'invDashboard'), NavigationItem(label: 'Warehouses', routeId: 'warehousesList'), NavigationItem(label: 'Stock Transfers', routeId: 'transferList'), NavigationItem(label: 'Issue — Details', routeId: 'issueDetail'), NavigationItem(label: 'Receive Inventory', routeId: 'receiveCreate'), NavigationItem(label: 'Receive — Details', routeId: 'receiveDetail'), NavigationItem(label: 'Transfer Inventory', routeId: 'transferCreate'), NavigationItem(label: 'Transfer — Details', routeId: 'transferDetail'), NavigationItem(label: 'Inventory Adjustment', routeId: 'adjustment'), NavigationItem(label: 'Stock Take', routeId: 'stockTake'), NavigationItem(label: 'Categories', routeId: 'categories'), NavigationItem(label: 'Units of Measure', routeId: 'uom'), NavigationItem(label: 'Price Lists', routeId: 'priceLists'), NavigationItem(label: 'Barcode Print', routeId: 'barcodePrint'),
  ]),
  NavigationGroup(title: 'Ledger', items: [NavigationItem(label: 'Journal Entries', routeId: 'journalList'), NavigationItem(label: 'Create Journal Entry', routeId: 'createJournalEntry'), NavigationItem(label: 'Journal Entry Details', routeId: 'journalEntryDetail'), NavigationItem(label: 'Opening Journal Entry', routeId: 'journal'), NavigationItem(label: 'Financial Operation', routeId: 'opDetail')]),
  NavigationGroup(title: 'Sales · Customers', items: [NavigationItem(label: 'Customers', routeId: 'customersList'), NavigationItem(label: 'Add Customer', routeId: 'createCustomer')]),
  NavigationGroup(title: 'Procurement · Suppliers', items: [NavigationItem(label: 'Suppliers', routeId: 'suppliersList'), NavigationItem(label: 'Add Supplier', routeId: 'createSupplier')]),
  NavigationGroup(title: 'Configuration', items: [NavigationItem(label: 'Currencies', routeId: 'currenciesList'), NavigationItem(label: 'Add Currency', routeId: 'createCurrency'), NavigationItem(label: 'Exchange Rates', routeId: 'exchangeRateSetup'), NavigationItem(label: 'Fiscal Year', routeId: 'fiscalYearSetup')]),
  NavigationGroup(title: 'Banking · Cash', items: [NavigationItem(label: 'Create Deposit', routeId: 'createDeposit'), NavigationItem(label: 'Deposit Receipt', routeId: 'depositDetail'), NavigationItem(label: 'Create Withdrawal', routeId: 'createWithdrawal'), NavigationItem(label: 'Withdrawal Voucher', routeId: 'withdrawalDetail')]),
  NavigationGroup(title: 'Banking · Transfers', items: [NavigationItem(label: 'Create Local Transfer', routeId: 'createLocalTransfer'), NavigationItem(label: 'Local Transfer Details', routeId: 'localTransferDetail'), NavigationItem(label: 'Create External Transfer', routeId: 'createExternalTransfer'), NavigationItem(label: 'External Wire Details', routeId: 'externalTransferDetail')]),
  NavigationGroup(title: 'Reports', items: [NavigationItem(label: 'Trial Balance', routeId: 'trialBalance'), NavigationItem(label: 'Income Statement', routeId: 'incomeStatement'), NavigationItem(label: 'Balance Sheet', routeId: 'balanceSheet'), NavigationItem(label: 'Inventory Valuation', routeId: 'inventoryValuation'), NavigationItem(label: 'Audit Log', routeId: 'auditLog')]),
  NavigationGroup(title: 'Administration', items: [NavigationItem(label: 'Users', routeId: 'usersList'), NavigationItem(label: 'Invite User', routeId: 'createUser'), NavigationItem(label: 'Roles & Permissions', routeId: 'rolesPermissions')]),
];
