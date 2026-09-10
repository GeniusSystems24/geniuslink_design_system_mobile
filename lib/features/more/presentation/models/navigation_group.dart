import '../../../../localization/generated/l10n.dart';

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

List<NavigationGroup> buildDefaultMoreNavigationGroups(
  GeniusLinkLocalization l10n,
) => <NavigationGroup>[
  NavigationGroup(
    title: l10n.mobileDashboardWorkspace,
    items: [
      NavigationItem(
        label: l10n.bankingDashboard,
        routeId: 'mobileBankingDashboard',
      ),
      NavigationItem(
        label: l10n.accountingDashboard,
        routeId: 'mobileAccountingDashboard',
      ),
      NavigationItem(
        label: l10n.commercialDashboard,
        routeId: 'mobileCommercialDashboard',
      ),
      NavigationItem(label: l10n.settings, routeId: 'settingsHub'),
    ],
  ),
  NavigationGroup(
    title: l10n.accounts,
    items: [
      NavigationItem(label: l10n.accountTree, routeId: 'accountTree'),
      NavigationItem(label: l10n.createAccountGroup, routeId: 'createGroup'),
    ],
  ),
  NavigationGroup(
    title: l10n.products,
    items: [
      NavigationItem(label: l10n.productsList, routeId: 'productsList'),
      NavigationItem(label: l10n.createProduct, routeId: 'createProduct'),
    ],
  ),
  NavigationGroup(
    title: l10n.inventory,
    items: [
      NavigationItem(label: l10n.inventoryDashboard, routeId: 'invDashboard'),
      NavigationItem(label: l10n.warehouses, routeId: 'warehousesList'),
      NavigationItem(label: l10n.stockTransfers, routeId: 'transferList'),
      NavigationItem(label: l10n.issueDetailsMore, routeId: 'issueDetail'),
      NavigationItem(label: l10n.receiveInventory, routeId: 'receiveCreate'),
      NavigationItem(label: l10n.receiveDetailsMore, routeId: 'receiveDetail'),
      NavigationItem(label: l10n.transferInventory, routeId: 'transferCreate'),
      NavigationItem(label: l10n.transferDetailsMore, routeId: 'transferDetail'),
      NavigationItem(label: l10n.inventoryAdjustment, routeId: 'adjustment'),
      NavigationItem(label: l10n.stockTake, routeId: 'stockTake'),
      NavigationItem(label: l10n.categories, routeId: 'categories'),
      NavigationItem(label: l10n.unitsOfMeasure, routeId: 'uom'),
      NavigationItem(label: l10n.priceLists, routeId: 'priceLists'),
      NavigationItem(label: l10n.barcodePrint, routeId: 'barcodePrint'),
    ],
  ),
  NavigationGroup(
    title: l10n.mobileDashboardLedger,
    items: [
      NavigationItem(label: l10n.journalEntries, routeId: 'journalList'),
      NavigationItem(
        label: l10n.createJournalEntry,
        routeId: 'createJournalEntry',
      ),
      NavigationItem(
        label: l10n.journalEntryDetails,
        routeId: 'journalEntryDetail',
      ),
      NavigationItem(label: l10n.openingJournalEntry, routeId: 'journal'),
      NavigationItem(label: l10n.financialOperation, routeId: 'opDetail'),
    ],
  ),
  NavigationGroup(
    title: l10n.salesCustomers,
    items: [
      NavigationItem(label: l10n.mobileDashboardCustomers, routeId: 'customersList'),
      NavigationItem(label: l10n.addCustomer, routeId: 'createCustomer'),
    ],
  ),
  NavigationGroup(
    title: l10n.procurementSuppliers,
    items: [
      NavigationItem(label: l10n.mobileDashboardSuppliers, routeId: 'suppliersList'),
      NavigationItem(label: l10n.addSupplier, routeId: 'createSupplier'),
    ],
  ),
  NavigationGroup(
    title: l10n.configuration,
    items: [
      NavigationItem(label: l10n.currencies, routeId: 'currenciesList'),
      NavigationItem(label: l10n.addCurrency, routeId: 'createCurrency'),
      NavigationItem(label: l10n.exchangeRates, routeId: 'exchangeRateSetup'),
      NavigationItem(label: l10n.fiscalYear, routeId: 'fiscalYearSetup'),
    ],
  ),
  NavigationGroup(
    title: l10n.bankingCash,
    items: [
      NavigationItem(label: l10n.createDeposit, routeId: 'createDeposit'),
      NavigationItem(label: l10n.depositReceipt, routeId: 'depositDetail'),
      NavigationItem(label: l10n.createWithdrawal, routeId: 'createWithdrawal'),
      NavigationItem(label: l10n.withdrawalVoucher, routeId: 'withdrawalDetail'),
    ],
  ),
  NavigationGroup(
    title: l10n.bankingTransfers,
    items: [
      NavigationItem(
        label: l10n.createLocalTransfer,
        routeId: 'createLocalTransfer',
      ),
      NavigationItem(
        label: l10n.localTransferDetails,
        routeId: 'localTransferDetail',
      ),
      NavigationItem(
        label: l10n.createExternalTransfer,
        routeId: 'createExternalTransfer',
      ),
      NavigationItem(
        label: l10n.externalWireDetails,
        routeId: 'externalTransferDetail',
      ),
    ],
  ),
  NavigationGroup(
    title: l10n.mobileDashboardReports,
    items: [
      NavigationItem(label: l10n.trialBalance, routeId: 'trialBalance'),
      NavigationItem(label: l10n.incomeStatement, routeId: 'incomeStatement'),
      NavigationItem(label: l10n.balanceSheet, routeId: 'balanceSheet'),
      NavigationItem(
        label: l10n.inventoryValuation,
        routeId: 'inventoryValuation',
      ),
      NavigationItem(label: l10n.auditLog, routeId: 'auditLog'),
    ],
  ),
  NavigationGroup(
    title: l10n.administration,
    items: [
      NavigationItem(label: l10n.users, routeId: 'usersList'),
      NavigationItem(label: l10n.inviteUser, routeId: 'createUser'),
      NavigationItem(label: l10n.rolesPermissions, routeId: 'rolesPermissions'),
    ],
  ),
];
