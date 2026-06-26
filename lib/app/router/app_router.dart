import 'package:flutter/material.dart';
import '../../workspace/presentation/bloc/nav_cubit.dart';
import '../../design_system/kit.dart';

// ============================================================
// VIEW — Screen registry (ports SUB_TITLES + screen routing)
// ------------------------------------------------------------
// Single source mapping a screen id → its app-bar title/back target
// and → its widget. Screens not yet ported render a PendingScreen
// placeholder so the whole navigator stays runnable across batches.
// ============================================================

import 'package:flutter/material.dart';
import '../../features/dashboard/presentation/pages/dashboard_screen.dart';
import '../../features/accounts/presentation/pages/accounts_screens.dart';
import '../../features/stores/presentation/pages/stores_screens.dart';
import '../../features/more/presentation/pages/more_screen.dart';
import '../../features/ledger/presentation/pages/ledger_screens.dart';
import '../../features/ledger/presentation/pages/journal_screens.dart';
import '../../features/banking/presentation/pages/banking_cash_screens.dart';
import '../../features/banking/presentation/pages/banking_transfer_screens.dart';
import '../../features/inventory/presentation/pages/inventory_screens.dart';
import '../../features/inventory/presentation/pages/inventory_extras_screens.dart';
import '../../features/accounts/presentation/pages/accounts_extra_screens.dart';
import '../../features/config/presentation/pages/currencies_screens.dart';
import '../../features/contacts/presentation/pages/contacts_screens.dart';
import '../../features/reports/presentation/pages/reports_screens.dart';
import '../../features/admin/presentation/pages/users_screens.dart';
import '../../features/settings/presentation/pages/settings_org_screens.dart';
import '../../features/settings/presentation/pages/settings_team_screens.dart';
import '../../features/settings/presentation/pages/settings_platform_screens.dart';
import '../../features/mobile_dashboard/presentation/pages/mobile_dashboard_screen.dart';

class ScreenMeta {
  final String title;
  final String? ar;
  final String back;
  const ScreenMeta(this.title, {this.ar, this.back = 'more'});
}

const Map<String, ScreenMeta> subTitles = {
  'accountDetail': ScreenMeta('Cash Box', ar: 'الصندوق', back: 'accounts'),
  'createAccount': ScreenMeta('Create Account', back: 'accounts'),
  'groupDetail': ScreenMeta('Current Assets', ar: 'الأصول المتداولة', back: 'accounts'),
  'createStore': ScreenMeta('Create Store', back: 'stores'),
  'storeDetail': ScreenMeta('Downtown Central', ar: 'متجر وسط المدينة', back: 'stores'),
  'issue': ScreenMeta('Issue Inventory', back: 'stores'),
  'createGroup': ScreenMeta('Create Account Group'),
  'journal': ScreenMeta('Opening Journal', ar: 'قيد افتتاحي'),
  'opDetail': ScreenMeta('Material Issuance', ar: 'عملية صرف مواد'),
  'createDeposit': ScreenMeta('Create Deposit', ar: 'إيداع نقدي'),
  'depositDetail': ScreenMeta('Deposit Receipt', ar: 'سند قبض'),
  'createWithdrawal': ScreenMeta('Create Withdrawal', ar: 'سحب نقدي'),
  'withdrawalDetail': ScreenMeta('Withdrawal Voucher', ar: 'سند صرف'),
  'createLocalTransfer': ScreenMeta('Local Transfer', ar: 'تحويل محلي'),
  'localTransferDetail': ScreenMeta('Inter-Account Settlement', ar: 'تسوية بين الحسابات'),
  'createExternalTransfer': ScreenMeta('External Transfer', ar: 'تحويل خارجي'),
  'externalTransferDetail': ScreenMeta('External Wire', ar: 'تحويل خارجي'),
  'productsList': ScreenMeta('Products', ar: 'المنتجات'),
  'invDashboard': ScreenMeta('Inventory Dashboard', ar: 'لوحة المخزون'),
  'warehousesList': ScreenMeta('Warehouses', ar: 'المستودعات'),
  'transferList': ScreenMeta('Stock Transfers', ar: 'التحويلات'),
  'stockTake': ScreenMeta('Stock Take', ar: 'جرد فعلي'),
  'categories': ScreenMeta('Categories', ar: 'التصنيفات'),
  'uom': ScreenMeta('Units of Measure', ar: 'وحدات القياس'),
  'priceLists': ScreenMeta('Price Lists', ar: 'قوائم الأسعار'),
  'barcodePrint': ScreenMeta('Barcode Print', ar: 'طباعة باركود'),
  'productDetail': ScreenMeta('Structural Steel I-Beam', ar: 'كمرة فولاذية', back: 'productsList'),
  'createProduct': ScreenMeta('Create Product', ar: 'منتج جديد'),
  'issueDetail': ScreenMeta('Issue Details', ar: 'تفاصيل الصرف'),
  'receiveCreate': ScreenMeta('Receive Inventory', ar: 'استلام مخزون'),
  'receiveDetail': ScreenMeta('Receive Details', ar: 'تفاصيل الاستلام'),
  'transferCreate': ScreenMeta('New Transfer', ar: 'تحويل مخزون'),
  'transferDetail': ScreenMeta('Transfer Details', ar: 'تفاصيل التحويل'),
  'adjustment': ScreenMeta('Inventory Adjustment', ar: 'تسوية مخزون'),
  'journalList': ScreenMeta('Journal Entries', ar: 'القيود'),
  'createJournalEntry': ScreenMeta('Create Journal Entry', ar: 'قيد جديد'),
  'journalEntryDetail': ScreenMeta('Journal Entry', ar: 'قيد محاسبي', back: 'journalList'),
  'currenciesList': ScreenMeta('Currencies', ar: 'العملات'),
  'createCurrency': ScreenMeta('Add Currency', ar: 'إضافة عملة'),
  'currencyDetail': ScreenMeta('US Dollar', ar: 'دولار أمريكي', back: 'currenciesList'),
  'exchangeRateSetup': ScreenMeta('Exchange Rates', ar: 'أسعار الصرف'),
  'fiscalYearSetup': ScreenMeta('Fiscal Year', ar: 'السنة المالية'),
  'usersList': ScreenMeta('Users', ar: 'المستخدمون'),
  'userDetail': ScreenMeta('Layla Ahmed', ar: 'ليلى أحمد', back: 'usersList'),
  'createUser': ScreenMeta('Invite User', ar: 'دعوة مستخدم'),
  'rolesPermissions': ScreenMeta('Roles & Permissions', ar: 'الأدوار والصلاحيات'),
  'trialBalance': ScreenMeta('Trial Balance', ar: 'ميزان المراجعة'),
  'incomeStatement': ScreenMeta('Income Statement', ar: 'قائمة الدخل'),
  'balanceSheet': ScreenMeta('Balance Sheet', ar: 'الميزانية العمومية'),
  'inventoryValuation': ScreenMeta('Inventory Valuation', ar: 'تقييم المخزون'),
  'auditLog': ScreenMeta('Audit Log', ar: 'سجل التدقيق'),
  'customersList': ScreenMeta('Customers', ar: 'العملاء'),
  'customerDetail': ScreenMeta('Riyadh Construction Co.', ar: 'شركة الرياض للإنشاءات', back: 'customersList'),
  'createCustomer': ScreenMeta('Add Customer', ar: 'إضافة عميل'),
  'suppliersList': ScreenMeta('Suppliers', ar: 'الموردون'),
  'supplierDetail': ScreenMeta('Global Steel Imports', ar: 'الاستيراد العالمي للصلب', back: 'suppliersList'),
  'createSupplier': ScreenMeta('Add Supplier', ar: 'إضافة مورد'),
  'accountTree': ScreenMeta('Account Tree', ar: 'شجرة الحسابات'),
  'settingsHub': ScreenMeta('Settings', ar: 'الإعدادات'),
  'mobileDashboard': ScreenMeta('Mobile Dashboard', ar: 'لوحة الموبايل'),
  'setCompany': ScreenMeta('Company Profile', ar: 'ملف الشركة', back: 'settingsHub'),
  'setFinancial': ScreenMeta('Financial Settings', ar: 'الإعدادات المالية', back: 'settingsHub'),
  'setTaxes': ScreenMeta('Taxes', ar: 'الضرائب', back: 'settingsHub'),
  'setCurrencies': ScreenMeta('Currencies', ar: 'العملات', back: 'settingsHub'),
  'setNumbering': ScreenMeta('Numbering', ar: 'الترقيم', back: 'settingsHub'),
  'setBranches': ScreenMeta('Branches & Stores', ar: 'الفروع والمتاجر', back: 'settingsHub'),
  'tenants': ScreenMeta('Workspaces', ar: 'مساحات العمل', back: 'settingsHub'),
  'rolesList': ScreenMeta('Roles & Permissions', ar: 'الأدوار والصلاحيات', back: 'settingsHub'),
  'roleEditor': ScreenMeta('Edit Role · Accountant', ar: 'تعديل دور', back: 'rolesList'),
  'setIntegrations': ScreenMeta('Integrations', ar: 'التكاملات', back: 'settingsHub'),
  'setWebhooks': ScreenMeta('Webhooks', back: 'settingsHub'),
  'setApiKeys': ScreenMeta('API Keys', ar: 'مفاتيح API', back: 'settingsHub'),
  'setNotifications': ScreenMeta('Notifications', ar: 'الإشعارات', back: 'settingsHub'),
  'setBilling': ScreenMeta('Billing & Plan', ar: 'الفوترة والخطة', back: 'settingsHub'),
  'setBackup': ScreenMeta('Backup & Export', ar: 'النسخ والتصدير', back: 'settingsHub'),
};

/// Every sub-screen id is now ported. nav.back() uses this to decide jump targets.
final Set<String> portedScreens = subTitles.keys.toSet();

/// Screens that render their own chrome (no standard MAppBar wrapper).
const Set<String> fullBleedScreens = {'mobileDashboard'};

/// Build a sub-screen widget. Falls back to [PendingScreen] for ids
/// scheduled in a later batch.
Widget buildSubScreen(String id, NavCubit nav) {
  switch (id) {
    // Full-bleed (own chrome)
    case 'mobileDashboard': return const MobileDashboardScreen();
    // Accounts
    case 'createAccount': return const CreateAccountScreen();
    case 'accountDetail': return AccountDetailFullScreen(nav: nav);
    case 'createGroup': return const CreateGroupScreen();
    case 'groupDetail': return GroupDetailScreen(nav: nav);
    // Stores
    case 'createStore': return const CreateStoreScreen();
    case 'storeDetail': return StoreDetailScreen(nav: nav);
    case 'issue': return const IssueInventoryScreen();
    // Batch 2 — Ledger
    case 'journal': return const OpeningJournalScreen();
    case 'opDetail': return OpDetailScreen(nav: nav);
    // Batch 2 — Journal
    case 'journalList': return JournalListScreen(nav: nav);
    case 'createJournalEntry': return const CreateJournalEntryScreen();
    case 'journalEntryDetail': return JournalEntryDetailScreen(nav: nav);
    // Batch 2 — Banking · Cash
    case 'createDeposit': return const CreateDepositScreen();
    case 'depositDetail': return DepositDetailScreen(nav: nav);
    case 'createWithdrawal': return const CreateWithdrawalScreen();
    case 'withdrawalDetail': return WithdrawalDetailScreen(nav: nav);
    // Batch 2 — Banking · Transfers
    case 'createLocalTransfer': return const CreateLocalTransferScreen();
    case 'localTransferDetail': return LocalTransferDetailScreen(nav: nav);
    case 'createExternalTransfer': return const CreateExternalTransferScreen();
    case 'externalTransferDetail': return ExternalTransferDetailScreen(nav: nav);
    // Batch 3 — Products & inventory ops
    case 'productsList': return ProductsListScreen(nav: nav);
    case 'productDetail': return ProductDetailScreen(nav: nav);
    case 'createProduct': return const CreateProductScreen();
    case 'issueDetail': return IssueDetailScreen(nav: nav);
    case 'receiveCreate': return const ReceiveCreateScreen();
    case 'receiveDetail': return ReceiveDetailScreen(nav: nav);
    case 'transferCreate': return const TransferCreateScreen();
    case 'transferDetail': return TransferDetailScreen(nav: nav);
    case 'adjustment': return const AdjustmentScreen();
    // Batch 3 — Inventory extras
    case 'invDashboard': return const InvDashboardScreen();
    case 'stockTake': return const StockTakeScreen();
    case 'categories': return const CategoriesScreen();
    case 'uom': return const UomScreen();
    case 'priceLists': return const PriceListsScreen();
    case 'barcodePrint': return const BarcodePrintScreen();
    case 'warehousesList': return const WarehousesListScreen();
    case 'transferList': return TransferListScreen(nav: nav);
    // Batch 3 — Accounts parity (full detail overrides simple one + tree)
    case 'accountTree': return AccountTreeScreen(nav: nav);
    // Batch 4 — Currencies
    case 'currenciesList': return CurrenciesListScreen(nav: nav);
    case 'createCurrency': return const CreateCurrencyScreen();
    case 'currencyDetail': return CurrencyDetailScreen(nav: nav);
    case 'exchangeRateSetup': return const ExchangeRateSetupScreen();
    case 'fiscalYearSetup': return const FiscalYearSetupScreen();
    // Batch 4 — Contacts
    case 'customersList': return ContactListScreen.customers(nav);
    case 'customerDetail': return ContactDetailScreen.customer();
    case 'createCustomer': return CreateContactScreen.customer();
    case 'suppliersList': return ContactListScreen.suppliers(nav);
    case 'supplierDetail': return ContactDetailScreen.supplier();
    case 'createSupplier': return CreateContactScreen.supplier();
    // Batch 4 — Reports
    case 'trialBalance': return const TrialBalanceScreen();
    case 'incomeStatement': return const IncomeStatementScreen();
    case 'balanceSheet': return const BalanceSheetScreen();
    case 'inventoryValuation': return const InventoryValuationScreen();
    case 'auditLog': return const AuditLogScreen();
    // Batch 4 — Users
    case 'usersList': return UsersListScreen(nav: nav);
    case 'userDetail': return const UserDetailScreen();
    case 'createUser': return const CreateUserScreen();
    case 'rolesPermissions': return const RolesPermissionsScreen();
    // Batch 5 — Settings · Organization
    case 'settingsHub': return SettingsHubScreen(nav: nav);
    case 'setCompany': return const CompanyProfileScreen();
    case 'setFinancial': return const FinancialSettingsScreen();
    case 'setTaxes': return const TaxesSettingsScreen();
    case 'setCurrencies': return const CurrenciesSettingsScreen();
    case 'setNumbering': return const NumberingScreen();
    case 'setBranches': return const BranchesStoresScreen();
    // Batch 5 — Settings · Team & Security
    case 'rolesList': return RolesListScreen(nav: nav);
    case 'roleEditor': return const RoleEditorScreen();
    case 'tenants': return const TenantsScreen();
    // Batch 5 — Settings · Platform
    case 'setIntegrations': return const IntegrationsScreen();
    case 'setWebhooks': return const WebhooksScreen();
    case 'setApiKeys': return const ApiKeysScreen();
    case 'setNotifications': return const NotificationsScreen();
    case 'setBilling': return const BillingScreen();
    case 'setBackup': return const BackupScreen();
    default:
      return PendingScreen(id: id, title: subTitles[id]?.title ?? id);
  }
}

/// Build a bottom-tab screen.
Widget buildTabScreen(String tab, NavCubit nav) {
  switch (tab) {
    case 'accounts': return AccountsScreen(nav: nav);
    case 'stores': return StoresScreen(nav: nav);
    case 'more': return MoreScreen(nav: nav);
    case 'dashboard':
    default:
      return DashboardScreen(nav: nav);
  }
}

/// Placeholder for screens arriving in a later porting batch.
class PendingScreen extends StatelessWidget {
  final String id;
  final String title;
  const PendingScreen({super.key, required this.id, required this.title});
  @override
  Widget build(BuildContext context) {
    return MScroll([
      const SizedBox(height: 40),
      Center(
        child: Column(
          children: [
            Container(
              width: 56, height: 56,
              decoration: BoxDecoration(color: M.input, borderRadius: BorderRadius.circular(16), border: Border.all(color: M.border)),
              child: const Icon(Icons.construction_rounded, color: M.fg3, size: 26),
            ),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontFamily: M.display, fontWeight: FontWeight.w700, fontSize: 18, color: M.fg1)),
            const SizedBox(height: 6),
            const Text('This screen is scheduled in an upcoming porting batch.',
                textAlign: TextAlign.center, style: TextStyle(fontFamily: M.body, fontSize: 13, color: M.fg3, height: 1.5)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: M.input, borderRadius: BorderRadius.circular(6)),
              child: Text(id, style: const TextStyle(fontFamily: M.mono, fontSize: 12, color: M.fg2)),
            ),
          ],
        ),
      ),
    ]);
  }
}
