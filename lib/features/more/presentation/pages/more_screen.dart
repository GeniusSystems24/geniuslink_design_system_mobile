// ============================================================
// VIEW — More menu (ports MMore) with live search
// ============================================================

import 'package:flutter/material.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';

class _Group {
  final String title;
  final List<(String, String)> items; // (label, id)
  const _Group(this.title, this.items);
}

final _menu = <_Group>[
  _Group('Workspace',
      [('Mobile Dashboard', 'mobileDashboard'), ('Settings', 'settingsHub')]),
  _Group('Accounts', [
    ('Account Tree', 'accountTree'),
    ('Create Account Group', 'createGroup')
  ]),
  _Group('Products',
      [('Products List', 'productsList'), ('Create Product', 'createProduct')]),
  _Group('Inventory', [
    ('Inventory Dashboard', 'invDashboard'),
    ('Warehouses', 'warehousesList'),
    ('Stock Transfers', 'transferList'),
    ('Issue — Details', 'issueDetail'),
    ('Receive Inventory', 'receiveCreate'),
    ('Receive — Details', 'receiveDetail'),
    ('Transfer Inventory', 'transferCreate'),
    ('Transfer — Details', 'transferDetail'),
    ('Inventory Adjustment', 'adjustment'),
    ('Stock Take', 'stockTake'),
    ('Categories', 'categories'),
    ('Units of Measure', 'uom'),
    ('Price Lists', 'priceLists'),
    ('Barcode Print', 'barcodePrint'),
  ]),
  _Group('Ledger', [
    ('Journal Entries', 'journalList'),
    ('Create Journal Entry', 'createJournalEntry'),
    ('Journal Entry Details', 'journalEntryDetail'),
    ('Opening Journal Entry', 'journal'),
    ('Financial Operation', 'opDetail'),
  ]),
  _Group('Sales · Customers',
      [('Customers', 'customersList'), ('Add Customer', 'createCustomer')]),
  _Group('Procurement · Suppliers',
      [('Suppliers', 'suppliersList'), ('Add Supplier', 'createSupplier')]),
  _Group('Configuration', [
    ('Currencies', 'currenciesList'),
    ('Add Currency', 'createCurrency'),
    ('Exchange Rates', 'exchangeRateSetup'),
    ('Fiscal Year', 'fiscalYearSetup'),
  ]),
  _Group('Banking · Cash', [
    ('Create Deposit', 'createDeposit'),
    ('Deposit Receipt', 'depositDetail'),
    ('Create Withdrawal', 'createWithdrawal'),
    ('Withdrawal Voucher', 'withdrawalDetail'),
  ]),
  _Group('Banking · Transfers', [
    ('Create Local Transfer', 'createLocalTransfer'),
    ('Local Transfer Details', 'localTransferDetail'),
    ('Create External Transfer', 'createExternalTransfer'),
    ('External Wire Details', 'externalTransferDetail'),
  ]),
  _Group('Reports', [
    ('Trial Balance', 'trialBalance'),
    ('Income Statement', 'incomeStatement'),
    ('Balance Sheet', 'balanceSheet'),
    ('Inventory Valuation', 'inventoryValuation'),
    ('Audit Log', 'auditLog'),
  ]),
  _Group('Administration', [
    ('Users', 'usersList'),
    ('Invite User', 'createUser'),
    ('Roles & Permissions', 'rolesPermissions')
  ]),
];

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});
  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  // Every menu item, grouped for the AutoSuggestionsBox spotlight search.
  late final List<AutoSuggestion<String>> _spotlight = [
    for (final group in _menu)
      for (final item in group.items)
        AutoSuggestion<String>(
          value: item.$2,
          label: item.$1,
          group: group.title,
        ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'More'),
      body: MScroll([
      MSuggest(
        items: _spotlight,
        placeholder: 'Search every screen…',
        onSelected: context.goTo,
      ),
      for (final g in _menu)
        MCard(title: g.title, accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, pad: 8, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(children: [
              for (int i = 0; i < g.items.length; i++)
                GestureDetector(
                  onTap: () => context.goTo(g.items[i].$2),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    decoration: BoxDecoration(
                        border: i == g.items.length - 1
                            ? null
                            : Border(
                                bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(g.items[i].$1,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: SuperMaterialThemeData.of(context).superTheme.fg1,
                                  fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                          Icon(MIcons.of('chevR'), size: 16, color: SuperMaterialThemeData.of(context).superTheme.fg4),
                        ]),
                  ),
                ),
            ]),
          ),
        ]),
      ]),
    );
  }
}
