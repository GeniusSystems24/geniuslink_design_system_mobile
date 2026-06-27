// ============================================================
// GeniusLink Mobile — GoRouter with typed routes
// ------------------------------------------------------------
// All route definitions live here. build_runner generates
// router.g.dart from @TypedGoRoute annotations.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/auth_screen.dart';
import '../../features/dashboard/presentation/pages/dashboard_screen.dart';
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
import '../../features/mobile_dashboard/presentation/pages/mobile_dashboard_screen.dart';
import '../../workspace/presentation/bloc/nav_cubit.dart';
import 'workspace_shell.dart';

part 'router.g.dart';

// ════════════════════════════════════════════════════════════
// Navigators
// ════════════════════════════════════════════════════════════

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();


// ════════════════════════════════════════════════════════════
// Auth routes (no shell)
// ════════════════════════════════════════════════════════════

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute({this.from});
  final String? from;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(body: LoginScreen(nav: context.read<NavCubit>()));
  }
}

@TypedGoRoute<SignUpRoute>(path: '/signup')
class SignUpRoute extends GoRouteData with $SignUpRoute {
  const SignUpRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(body: SignUpScreen(nav: context.read<NavCubit>()));
  }
}

@TypedGoRoute<ForgotRoute>(path: '/forgot')
class ForgotRoute extends GoRouteData with $ForgotRoute {
  const ForgotRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(body: ForgotScreen(nav: context.read<NavCubit>()));
  }
}

// ════════════════════════════════════════════════════════════
// Tab routes — rendered inside StatefulShellRoute (manual)
// (no @TypedGoRoute annotations — they conflict with the
//  manual StatefulShellRoute branches in goRouterConfig)
// ════════════════════════════════════════════════════════════

// ════════════════════════════════════════════════════════════
// Sub-screen routes (above shell, via $parentNavigatorKey)
// ════════════════════════════════════════════════════════════

// ── Mobile Dashboard (full bleed) ──────────────────────────
@TypedGoRoute<MobileDashboardRoute>(path: '/mobile-dashboard')
class MobileDashboardRoute extends GoRouteData with $MobileDashboardRoute {
  const MobileDashboardRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: MobileDashboardScreen());
}

// ── Accounts ────────────────────────────────────────────────
@TypedGoRoute<CreateAccountRoute>(path: '/accounts/create')
class CreateAccountRoute extends GoRouteData with $CreateAccountRoute {
  const CreateAccountRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: CreateAccountScreen());
}

@TypedGoRoute<AccountDetailRoute>(path: '/accounts/detail')
class AccountDetailRoute extends GoRouteData with $AccountDetailRoute {
  const AccountDetailRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AccountDetailFullScreen(nav: context.read<NavCubit>());
  }
}

@TypedGoRoute<CreateGroupRoute>(path: '/accounts/create-group')
class CreateGroupRoute extends GoRouteData with $CreateGroupRoute {
  const CreateGroupRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: CreateGroupScreen());
}

@TypedGoRoute<GroupDetailRoute>(path: '/accounts/group-detail')
class GroupDetailRoute extends GoRouteData with $GroupDetailRoute {
  const GroupDetailRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return GroupDetailScreen(nav: context.read<NavCubit>());
  }
}

@TypedGoRoute<AccountTreeRoute>(path: '/account-tree')
class AccountTreeRoute extends GoRouteData with $AccountTreeRoute {
  const AccountTreeRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AccountTreeScreen(nav: context.read<NavCubit>());
  }
}

// ── Stores ──────────────────────────────────────────────────
@TypedGoRoute<CreateStoreRoute>(path: '/stores/create')
class CreateStoreRoute extends GoRouteData with $CreateStoreRoute {
  const CreateStoreRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: CreateStoreScreen());
}

@TypedGoRoute<StoreDetailRoute>(path: '/stores/detail')
class StoreDetailRoute extends GoRouteData with $StoreDetailRoute {
  const StoreDetailRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return StoreDetailScreen(nav: context.read<NavCubit>());
  }
}

@TypedGoRoute<IssueInventoryRoute>(path: '/stores/issue')
class IssueInventoryRoute extends GoRouteData with $IssueInventoryRoute {
  const IssueInventoryRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: IssueInventoryScreen());
}

// ── Ledger ──────────────────────────────────────────────────
@TypedGoRoute<OpeningJournalRoute>(path: '/ledger/opening')
class OpeningJournalRoute extends GoRouteData with $OpeningJournalRoute {
  const OpeningJournalRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: OpeningJournalScreen());
}

@TypedGoRoute<OpDetailRoute>(path: '/ledger/operation-detail')
class OpDetailRoute extends GoRouteData with $OpDetailRoute {
  const OpDetailRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OpDetailScreen(nav: context.read<NavCubit>());
  }
}

@TypedGoRoute<JournalListRoute>(path: '/journal-entries')
class JournalListRoute extends GoRouteData with $JournalListRoute {
  const JournalListRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return JournalListScreen(nav: context.read<NavCubit>());
  }
}

@TypedGoRoute<CreateJournalEntryRoute>(path: '/journal-entries/create')
class CreateJournalEntryRoute extends GoRouteData with $CreateJournalEntryRoute {
  const CreateJournalEntryRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: CreateJournalEntryScreen());
}

@TypedGoRoute<JournalEntryDetailRoute>(path: '/journal-entries/detail')
class JournalEntryDetailRoute extends GoRouteData with $JournalEntryDetailRoute {
  const JournalEntryDetailRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return JournalEntryDetailScreen(nav: context.read<NavCubit>());
  }
}

// ── Banking · Cash ──────────────────────────────────────────
@TypedGoRoute<CreateDepositRoute>(path: '/banking/deposits/create')
class CreateDepositRoute extends GoRouteData with $CreateDepositRoute {
  const CreateDepositRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: CreateDepositScreen());
}

@TypedGoRoute<DepositDetailRoute>(path: '/banking/deposits/detail')
class DepositDetailRoute extends GoRouteData with $DepositDetailRoute {
  const DepositDetailRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DepositDetailScreen(nav: context.read<NavCubit>());
  }
}

@TypedGoRoute<CreateWithdrawalRoute>(path: '/banking/withdrawals/create')
class CreateWithdrawalRoute extends GoRouteData with $CreateWithdrawalRoute {
  const CreateWithdrawalRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: CreateWithdrawalScreen());
}

@TypedGoRoute<WithdrawalDetailRoute>(path: '/banking/withdrawals/detail')
class WithdrawalDetailRoute extends GoRouteData with $WithdrawalDetailRoute {
  const WithdrawalDetailRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return WithdrawalDetailScreen(nav: context.read<NavCubit>());
  }
}

// ── Banking · Transfers ─────────────────────────────────────
@TypedGoRoute<CreateLocalTransferRoute>(path: '/banking/transfers/local/create')
class CreateLocalTransferRoute extends GoRouteData with $CreateLocalTransferRoute {
  const CreateLocalTransferRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: CreateLocalTransferScreen());
}

@TypedGoRoute<LocalTransferDetailRoute>(path: '/banking/transfers/local/detail')
class LocalTransferDetailRoute extends GoRouteData with $LocalTransferDetailRoute {
  const LocalTransferDetailRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return LocalTransferDetailScreen(nav: context.read<NavCubit>());
  }
}

@TypedGoRoute<CreateExternalTransferRoute>(path: '/banking/transfers/external/create')
class CreateExternalTransferRoute extends GoRouteData with $CreateExternalTransferRoute {
  const CreateExternalTransferRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: CreateExternalTransferScreen());
}

@TypedGoRoute<ExternalTransferDetailRoute>(path: '/banking/transfers/external/detail')
class ExternalTransferDetailRoute extends GoRouteData with $ExternalTransferDetailRoute {
  const ExternalTransferDetailRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ExternalTransferDetailScreen(nav: context.read<NavCubit>());
  }
}

// ── Products ────────────────────────────────────────────────
@TypedGoRoute<ProductsListRoute>(path: '/products')
class ProductsListRoute extends GoRouteData with $ProductsListRoute {
  const ProductsListRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductsListScreen(nav: context.read<NavCubit>());
  }
}

@TypedGoRoute<ProductDetailRoute>(path: '/products/detail')
class ProductDetailRoute extends GoRouteData with $ProductDetailRoute {
  const ProductDetailRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductDetailScreen(nav: context.read<NavCubit>());
  }
}

@TypedGoRoute<CreateProductRoute>(path: '/products/create')
class CreateProductRoute extends GoRouteData with $CreateProductRoute {
  const CreateProductRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: CreateProductScreen());
}

// ── Inventory ───────────────────────────────────────────────
@TypedGoRoute<InvDashboardRoute>(path: '/inventory')
class InvDashboardRoute extends GoRouteData with $InvDashboardRoute {
  const InvDashboardRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: InvDashboardScreen());
}

@TypedGoRoute<WarehousesListRoute>(path: '/warehouses')
class WarehousesListRoute extends GoRouteData with $WarehousesListRoute {
  const WarehousesListRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: WarehousesListScreen());
}

@TypedGoRoute<TransferListRoute>(path: '/stock-transfers')
class TransferListRoute extends GoRouteData with $TransferListRoute {
  const TransferListRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TransferListScreen(nav: context.read<NavCubit>());
  }
}

@TypedGoRoute<IssueDetailRoute>(path: '/inventory/issue-detail')
class IssueDetailRoute extends GoRouteData with $IssueDetailRoute {
  const IssueDetailRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return IssueDetailScreen(nav: context.read<NavCubit>());
  }
}

@TypedGoRoute<ReceiveCreateRoute>(path: '/inventory/receive')
class ReceiveCreateRoute extends GoRouteData with $ReceiveCreateRoute {
  const ReceiveCreateRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: ReceiveCreateScreen());
}

@TypedGoRoute<ReceiveDetailRoute>(path: '/inventory/receive-detail')
class ReceiveDetailRoute extends GoRouteData with $ReceiveDetailRoute {
  const ReceiveDetailRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ReceiveDetailScreen(nav: context.read<NavCubit>());
  }
}

@TypedGoRoute<TransferCreateRoute>(path: '/inventory/transfers/create')
class TransferCreateRoute extends GoRouteData with $TransferCreateRoute {
  const TransferCreateRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: TransferCreateScreen());
}

@TypedGoRoute<TransferDetailRoute>(path: '/inventory/transfers/detail')
class TransferDetailRoute extends GoRouteData with $TransferDetailRoute {
  const TransferDetailRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TransferDetailScreen(nav: context.read<NavCubit>());
  }
}

@TypedGoRoute<AdjustmentRoute>(path: '/inventory/adjustment')
class AdjustmentRoute extends GoRouteData with $AdjustmentRoute {
  const AdjustmentRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: AdjustmentScreen());
}

@TypedGoRoute<StockTakeRoute>(path: '/inventory/stocktake')
class StockTakeRoute extends GoRouteData with $StockTakeRoute {
  const StockTakeRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: StockTakeScreen());
}

@TypedGoRoute<CategoriesRoute>(path: '/inventory/categories')
class CategoriesRoute extends GoRouteData with $CategoriesRoute {
  const CategoriesRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: CategoriesScreen());
}

@TypedGoRoute<UomRoute>(path: '/inventory/uom')
class UomRoute extends GoRouteData with $UomRoute {
  const UomRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: UomScreen());
}

@TypedGoRoute<PriceListsRoute>(path: '/price-lists')
class PriceListsRoute extends GoRouteData with $PriceListsRoute {
  const PriceListsRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: PriceListsScreen());
}

@TypedGoRoute<BarcodePrintRoute>(path: '/barcode-print')
class BarcodePrintRoute extends GoRouteData with $BarcodePrintRoute {
  const BarcodePrintRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: BarcodePrintScreen());
}

// ── Currencies ────────────────────────────────────────────────
@TypedGoRoute<CurrenciesListRoute>(path: '/currencies')
class CurrenciesListRoute extends GoRouteData with $CurrenciesListRoute {
  const CurrenciesListRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CurrenciesListScreen(nav: context.read<NavCubit>());
  }
}

@TypedGoRoute<CreateCurrencyRoute>(path: '/currencies/create')
class CreateCurrencyRoute extends GoRouteData with $CreateCurrencyRoute {
  const CreateCurrencyRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: CreateCurrencyScreen());
}

@TypedGoRoute<CurrencyDetailRoute>(path: '/currencies/detail')
class CurrencyDetailRoute extends GoRouteData with $CurrencyDetailRoute {
  const CurrencyDetailRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CurrencyDetailScreen(nav: context.read<NavCubit>());
  }
}

@TypedGoRoute<ExchangeRateSetupRoute>(path: '/exchange-rates')
class ExchangeRateSetupRoute extends GoRouteData with $ExchangeRateSetupRoute {
  const ExchangeRateSetupRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: ExchangeRateSetupScreen());
}

@TypedGoRoute<FiscalYearSetupRoute>(path: '/fiscal-year')
class FiscalYearSetupRoute extends GoRouteData with $FiscalYearSetupRoute {
  const FiscalYearSetupRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: FiscalYearSetupScreen());
}

// ── Customers ──────────────────────────────────────────────
@TypedGoRoute<CustomersListRoute>(path: '/customers')
class CustomersListRoute extends GoRouteData with $CustomersListRoute {
  const CustomersListRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ContactListScreen.customers(context.read<NavCubit>());
  }
}

@TypedGoRoute<CustomerDetailRoute>(path: '/customers/detail')
class CustomerDetailRoute extends GoRouteData with $CustomerDetailRoute {
  const CustomerDetailRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => Scaffold(body: ContactDetailScreen.customer());
}

@TypedGoRoute<CreateCustomerRoute>(path: '/customers/create')
class CreateCustomerRoute extends GoRouteData with $CreateCustomerRoute {
  const CreateCustomerRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => Scaffold(body: CreateContactScreen.customer());
}

// ── Suppliers ───────────────────────────────────────────────
@TypedGoRoute<SuppliersListRoute>(path: '/suppliers')
class SuppliersListRoute extends GoRouteData with $SuppliersListRoute {
  const SuppliersListRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ContactListScreen.suppliers(context.read<NavCubit>());
  }
}

@TypedGoRoute<SupplierDetailRoute>(path: '/suppliers/detail')
class SupplierDetailRoute extends GoRouteData with $SupplierDetailRoute {
  const SupplierDetailRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => Scaffold(body: ContactDetailScreen.supplier());
}

@TypedGoRoute<CreateSupplierRoute>(path: '/suppliers/create')
class CreateSupplierRoute extends GoRouteData with $CreateSupplierRoute {
  const CreateSupplierRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => Scaffold(body: CreateContactScreen.supplier());
}

// ── Reports ──────────────────────────────────────────────────
@TypedGoRoute<TrialBalanceRoute>(path: '/reports/trial-balance')
class TrialBalanceRoute extends GoRouteData with $TrialBalanceRoute {
  const TrialBalanceRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: TrialBalanceScreen());
}

@TypedGoRoute<IncomeStatementRoute>(path: '/reports/income-statement')
class IncomeStatementRoute extends GoRouteData with $IncomeStatementRoute {
  const IncomeStatementRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: IncomeStatementScreen());
}

@TypedGoRoute<BalanceSheetRoute>(path: '/reports/balance-sheet')
class BalanceSheetRoute extends GoRouteData with $BalanceSheetRoute {
  const BalanceSheetRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: BalanceSheetScreen());
}

@TypedGoRoute<InventoryValuationRoute>(path: '/reports/inventory-valuation')
class InventoryValuationRoute extends GoRouteData with $InventoryValuationRoute {
  const InventoryValuationRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: InventoryValuationScreen());
}

@TypedGoRoute<AuditLogRoute>(path: '/reports/audit-log')
class AuditLogRoute extends GoRouteData with $AuditLogRoute {
  const AuditLogRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: AuditLogScreen());
}

// ── Administration ──────────────────────────────────────────
@TypedGoRoute<UsersListRoute>(path: '/admin/users')
class UsersListRoute extends GoRouteData with $UsersListRoute {
  const UsersListRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return UsersListScreen(nav: context.read<NavCubit>());
  }
}

@TypedGoRoute<UserDetailRoute>(path: '/admin/users/detail')
class UserDetailRoute extends GoRouteData with $UserDetailRoute {
  const UserDetailRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: UserDetailScreen());
}

@TypedGoRoute<CreateUserRoute>(path: '/admin/users/create')
class CreateUserRoute extends GoRouteData with $CreateUserRoute {
  const CreateUserRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: CreateUserScreen());
}

@TypedGoRoute<RolesPermissionsRoute>(path: '/admin/roles')
class RolesPermissionsRoute extends GoRouteData with $RolesPermissionsRoute {
  const RolesPermissionsRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: RolesPermissionsScreen());
}

// ── Settings ────────────────────────────────────────────────
@TypedGoRoute<SettingsHubRoute>(path: '/settings')
class SettingsHubRoute extends GoRouteData with $SettingsHubRoute {
  const SettingsHubRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SettingsHubScreen(nav: context.read<NavCubit>());
  }
}

@TypedGoRoute<CompanyProfileRoute>(path: '/settings/company')
class CompanyProfileRoute extends GoRouteData with $CompanyProfileRoute {
  const CompanyProfileRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: CompanyProfileScreen());
}

@TypedGoRoute<FinancialSettingsRoute>(path: '/settings/financial')
class FinancialSettingsRoute extends GoRouteData with $FinancialSettingsRoute {
  const FinancialSettingsRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: FinancialSettingsScreen());
}

@TypedGoRoute<TaxesSettingsRoute>(path: '/settings/taxes')
class TaxesSettingsRoute extends GoRouteData with $TaxesSettingsRoute {
  const TaxesSettingsRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: TaxesSettingsScreen());
}

@TypedGoRoute<CurrenciesSettingsRoute>(path: '/settings/currencies')
class CurrenciesSettingsRoute extends GoRouteData with $CurrenciesSettingsRoute {
  const CurrenciesSettingsRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: CurrenciesSettingsScreen());
}

@TypedGoRoute<NumberingRoute>(path: '/settings/numbering')
class NumberingRoute extends GoRouteData with $NumberingRoute {
  const NumberingRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: NumberingScreen());
}

@TypedGoRoute<BranchesStoresRoute>(path: '/settings/branches')
class BranchesStoresRoute extends GoRouteData with $BranchesStoresRoute {
  const BranchesStoresRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: BranchesStoresScreen());
}

@TypedGoRoute<RolesListRoute>(path: '/admin/roles-list')
class RolesListRoute extends GoRouteData with $RolesListRoute {
  const RolesListRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return RolesListScreen(nav: context.read<NavCubit>());
  }
}

@TypedGoRoute<RoleEditorRoute>(path: '/admin/roles/edit')
class RoleEditorRoute extends GoRouteData with $RoleEditorRoute {
  const RoleEditorRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: RoleEditorScreen());
}

@TypedGoRoute<TenantsRoute>(path: '/settings/workspaces')
class TenantsRoute extends GoRouteData with $TenantsRoute {
  const TenantsRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: TenantsScreen());
}

@TypedGoRoute<IntegrationsRoute>(path: '/settings/integrations')
class IntegrationsRoute extends GoRouteData with $IntegrationsRoute {
  const IntegrationsRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: IntegrationsScreen());
}

@TypedGoRoute<WebhooksRoute>(path: '/settings/webhooks')
class WebhooksRoute extends GoRouteData with $WebhooksRoute {
  const WebhooksRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: WebhooksScreen());
}

@TypedGoRoute<ApiKeysRoute>(path: '/settings/api-keys')
class ApiKeysRoute extends GoRouteData with $ApiKeysRoute {
  const ApiKeysRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: ApiKeysScreen());
}

@TypedGoRoute<NotificationsRoute>(path: '/settings/notifications')
class NotificationsRoute extends GoRouteData with $NotificationsRoute {
  const NotificationsRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: NotificationsScreen());
}

@TypedGoRoute<BillingRoute>(path: '/settings/billing')
class BillingRoute extends GoRouteData with $BillingRoute {
  const BillingRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: BillingScreen());
}

@TypedGoRoute<BackupRoute>(path: '/settings/backup')
class BackupRoute extends GoRouteData with $BackupRoute {
  const BackupRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const Scaffold(body: BackupScreen());
}

// ════════════════════════════════════════════════════════════
// GoRouter configuration
// ════════════════════════════════════════════════════════════

/// Auth notifier — bridges AuthBloc/NavCubit state to go_router redirect.
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

  if (!authed && location != '/login' && location != '/signup' && location != '/forgot') {
    return '/login';
  }
  if (authed && (location == '/login' || location == '/signup' || location == '/forgot')) {
    return '/dashboard';
  }
  return null;
}

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/login',
  refreshListenable: authNotifier,
  redirect: _authRedirect,
  routes: [
    ...$appRoutes,
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(body: WorkspaceShell(navigationShell: navigationShell));
      },
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => Scaffold(body: DashboardScreen(nav: context.read<NavCubit>())),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/accounts',
            builder: (context, state) => Scaffold(body: AccountsScreen(nav: context.read<NavCubit>())),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/stores',
            builder: (context, state) => Scaffold(body: StoresScreen(nav: context.read<NavCubit>())),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/more',
            builder: (context, state) => Scaffold(body: MoreScreen(nav: context.read<NavCubit>())),
          ),
        ]),
      ],
    ),
  ],
);
