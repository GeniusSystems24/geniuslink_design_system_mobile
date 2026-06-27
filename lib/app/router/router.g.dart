// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $loginRoute,
      $signUpRoute,
      $forgotRoute,
      $mobileDashboardRoute,
      $createAccountRoute,
      $accountDetailRoute,
      $createGroupRoute,
      $groupDetailRoute,
      $accountTreeRoute,
      $createStoreRoute,
      $storeDetailRoute,
      $issueInventoryRoute,
      $openingJournalRoute,
      $opDetailRoute,
      $journalListRoute,
      $createJournalEntryRoute,
      $journalEntryDetailRoute,
      $createDepositRoute,
      $depositDetailRoute,
      $createWithdrawalRoute,
      $withdrawalDetailRoute,
      $createLocalTransferRoute,
      $localTransferDetailRoute,
      $createExternalTransferRoute,
      $externalTransferDetailRoute,
      $productsListRoute,
      $productDetailRoute,
      $createProductRoute,
      $invDashboardRoute,
      $warehousesListRoute,
      $transferListRoute,
      $issueDetailRoute,
      $receiveCreateRoute,
      $receiveDetailRoute,
      $transferCreateRoute,
      $transferDetailRoute,
      $adjustmentRoute,
      $stockTakeRoute,
      $categoriesRoute,
      $uomRoute,
      $priceListsRoute,
      $barcodePrintRoute,
      $currenciesListRoute,
      $createCurrencyRoute,
      $currencyDetailRoute,
      $exchangeRateSetupRoute,
      $fiscalYearSetupRoute,
      $customersListRoute,
      $customerDetailRoute,
      $createCustomerRoute,
      $suppliersListRoute,
      $supplierDetailRoute,
      $createSupplierRoute,
      $trialBalanceRoute,
      $incomeStatementRoute,
      $balanceSheetRoute,
      $inventoryValuationRoute,
      $auditLogRoute,
      $usersListRoute,
      $userDetailRoute,
      $createUserRoute,
      $rolesPermissionsRoute,
      $settingsHubRoute,
      $companyProfileRoute,
      $financialSettingsRoute,
      $taxesSettingsRoute,
      $currenciesSettingsRoute,
      $numberingRoute,
      $branchesStoresRoute,
      $rolesListRoute,
      $roleEditorRoute,
      $tenantsRoute,
      $integrationsRoute,
      $webhooksRoute,
      $apiKeysRoute,
      $notificationsRoute,
      $billingRoute,
      $backupRoute,
    ];

RouteBase get $loginRoute => GoRouteData.$route(
      path: '/login',
      factory: $LoginRoute._fromState,
    );

mixin $LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) => LoginRoute(
        from: state.uri.queryParameters['from'],
      );

  LoginRoute get _self => this as LoginRoute;

  @override
  String get location => GoRouteData.$location(
        '/login',
        queryParams: {
          if (_self.from != null) 'from': _self.from,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signUpRoute => GoRouteData.$route(
      path: '/signup',
      factory: $SignUpRoute._fromState,
    );

mixin $SignUpRoute on GoRouteData {
  static SignUpRoute _fromState(GoRouterState state) => const SignUpRoute();

  @override
  String get location => GoRouteData.$location(
        '/signup',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $forgotRoute => GoRouteData.$route(
      path: '/forgot',
      factory: $ForgotRoute._fromState,
    );

mixin $ForgotRoute on GoRouteData {
  static ForgotRoute _fromState(GoRouterState state) => const ForgotRoute();

  @override
  String get location => GoRouteData.$location(
        '/forgot',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mobileDashboardRoute => GoRouteData.$route(
      path: '/mobile-dashboard',
      parentNavigatorKey: MobileDashboardRoute.$parentNavigatorKey,
      factory: $MobileDashboardRoute._fromState,
    );

mixin $MobileDashboardRoute on GoRouteData {
  static MobileDashboardRoute _fromState(GoRouterState state) =>
      const MobileDashboardRoute();

  @override
  String get location => GoRouteData.$location(
        '/mobile-dashboard',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createAccountRoute => GoRouteData.$route(
      path: '/accounts/create',
      parentNavigatorKey: CreateAccountRoute.$parentNavigatorKey,
      factory: $CreateAccountRoute._fromState,
    );

mixin $CreateAccountRoute on GoRouteData {
  static CreateAccountRoute _fromState(GoRouterState state) =>
      const CreateAccountRoute();

  @override
  String get location => GoRouteData.$location(
        '/accounts/create',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $accountDetailRoute => GoRouteData.$route(
      path: '/accounts/detail',
      parentNavigatorKey: AccountDetailRoute.$parentNavigatorKey,
      factory: $AccountDetailRoute._fromState,
    );

mixin $AccountDetailRoute on GoRouteData {
  static AccountDetailRoute _fromState(GoRouterState state) =>
      const AccountDetailRoute();

  @override
  String get location => GoRouteData.$location(
        '/accounts/detail',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createGroupRoute => GoRouteData.$route(
      path: '/accounts/create-group',
      parentNavigatorKey: CreateGroupRoute.$parentNavigatorKey,
      factory: $CreateGroupRoute._fromState,
    );

mixin $CreateGroupRoute on GoRouteData {
  static CreateGroupRoute _fromState(GoRouterState state) =>
      const CreateGroupRoute();

  @override
  String get location => GoRouteData.$location(
        '/accounts/create-group',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $groupDetailRoute => GoRouteData.$route(
      path: '/accounts/group-detail',
      parentNavigatorKey: GroupDetailRoute.$parentNavigatorKey,
      factory: $GroupDetailRoute._fromState,
    );

mixin $GroupDetailRoute on GoRouteData {
  static GroupDetailRoute _fromState(GoRouterState state) =>
      const GroupDetailRoute();

  @override
  String get location => GoRouteData.$location(
        '/accounts/group-detail',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $accountTreeRoute => GoRouteData.$route(
      path: '/account-tree',
      parentNavigatorKey: AccountTreeRoute.$parentNavigatorKey,
      factory: $AccountTreeRoute._fromState,
    );

mixin $AccountTreeRoute on GoRouteData {
  static AccountTreeRoute _fromState(GoRouterState state) =>
      const AccountTreeRoute();

  @override
  String get location => GoRouteData.$location(
        '/account-tree',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createStoreRoute => GoRouteData.$route(
      path: '/stores/create',
      parentNavigatorKey: CreateStoreRoute.$parentNavigatorKey,
      factory: $CreateStoreRoute._fromState,
    );

mixin $CreateStoreRoute on GoRouteData {
  static CreateStoreRoute _fromState(GoRouterState state) =>
      const CreateStoreRoute();

  @override
  String get location => GoRouteData.$location(
        '/stores/create',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $storeDetailRoute => GoRouteData.$route(
      path: '/stores/detail',
      parentNavigatorKey: StoreDetailRoute.$parentNavigatorKey,
      factory: $StoreDetailRoute._fromState,
    );

mixin $StoreDetailRoute on GoRouteData {
  static StoreDetailRoute _fromState(GoRouterState state) =>
      const StoreDetailRoute();

  @override
  String get location => GoRouteData.$location(
        '/stores/detail',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $issueInventoryRoute => GoRouteData.$route(
      path: '/stores/issue',
      parentNavigatorKey: IssueInventoryRoute.$parentNavigatorKey,
      factory: $IssueInventoryRoute._fromState,
    );

mixin $IssueInventoryRoute on GoRouteData {
  static IssueInventoryRoute _fromState(GoRouterState state) =>
      const IssueInventoryRoute();

  @override
  String get location => GoRouteData.$location(
        '/stores/issue',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $openingJournalRoute => GoRouteData.$route(
      path: '/ledger/opening',
      parentNavigatorKey: OpeningJournalRoute.$parentNavigatorKey,
      factory: $OpeningJournalRoute._fromState,
    );

mixin $OpeningJournalRoute on GoRouteData {
  static OpeningJournalRoute _fromState(GoRouterState state) =>
      const OpeningJournalRoute();

  @override
  String get location => GoRouteData.$location(
        '/ledger/opening',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $opDetailRoute => GoRouteData.$route(
      path: '/ledger/operation-detail',
      parentNavigatorKey: OpDetailRoute.$parentNavigatorKey,
      factory: $OpDetailRoute._fromState,
    );

mixin $OpDetailRoute on GoRouteData {
  static OpDetailRoute _fromState(GoRouterState state) => const OpDetailRoute();

  @override
  String get location => GoRouteData.$location(
        '/ledger/operation-detail',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $journalListRoute => GoRouteData.$route(
      path: '/journal-entries',
      parentNavigatorKey: JournalListRoute.$parentNavigatorKey,
      factory: $JournalListRoute._fromState,
    );

mixin $JournalListRoute on GoRouteData {
  static JournalListRoute _fromState(GoRouterState state) =>
      const JournalListRoute();

  @override
  String get location => GoRouteData.$location(
        '/journal-entries',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createJournalEntryRoute => GoRouteData.$route(
      path: '/journal-entries/create',
      parentNavigatorKey: CreateJournalEntryRoute.$parentNavigatorKey,
      factory: $CreateJournalEntryRoute._fromState,
    );

mixin $CreateJournalEntryRoute on GoRouteData {
  static CreateJournalEntryRoute _fromState(GoRouterState state) =>
      const CreateJournalEntryRoute();

  @override
  String get location => GoRouteData.$location(
        '/journal-entries/create',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $journalEntryDetailRoute => GoRouteData.$route(
      path: '/journal-entries/detail',
      parentNavigatorKey: JournalEntryDetailRoute.$parentNavigatorKey,
      factory: $JournalEntryDetailRoute._fromState,
    );

mixin $JournalEntryDetailRoute on GoRouteData {
  static JournalEntryDetailRoute _fromState(GoRouterState state) =>
      const JournalEntryDetailRoute();

  @override
  String get location => GoRouteData.$location(
        '/journal-entries/detail',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createDepositRoute => GoRouteData.$route(
      path: '/banking/deposits/create',
      parentNavigatorKey: CreateDepositRoute.$parentNavigatorKey,
      factory: $CreateDepositRoute._fromState,
    );

mixin $CreateDepositRoute on GoRouteData {
  static CreateDepositRoute _fromState(GoRouterState state) =>
      const CreateDepositRoute();

  @override
  String get location => GoRouteData.$location(
        '/banking/deposits/create',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $depositDetailRoute => GoRouteData.$route(
      path: '/banking/deposits/detail',
      parentNavigatorKey: DepositDetailRoute.$parentNavigatorKey,
      factory: $DepositDetailRoute._fromState,
    );

mixin $DepositDetailRoute on GoRouteData {
  static DepositDetailRoute _fromState(GoRouterState state) =>
      const DepositDetailRoute();

  @override
  String get location => GoRouteData.$location(
        '/banking/deposits/detail',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createWithdrawalRoute => GoRouteData.$route(
      path: '/banking/withdrawals/create',
      parentNavigatorKey: CreateWithdrawalRoute.$parentNavigatorKey,
      factory: $CreateWithdrawalRoute._fromState,
    );

mixin $CreateWithdrawalRoute on GoRouteData {
  static CreateWithdrawalRoute _fromState(GoRouterState state) =>
      const CreateWithdrawalRoute();

  @override
  String get location => GoRouteData.$location(
        '/banking/withdrawals/create',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $withdrawalDetailRoute => GoRouteData.$route(
      path: '/banking/withdrawals/detail',
      parentNavigatorKey: WithdrawalDetailRoute.$parentNavigatorKey,
      factory: $WithdrawalDetailRoute._fromState,
    );

mixin $WithdrawalDetailRoute on GoRouteData {
  static WithdrawalDetailRoute _fromState(GoRouterState state) =>
      const WithdrawalDetailRoute();

  @override
  String get location => GoRouteData.$location(
        '/banking/withdrawals/detail',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createLocalTransferRoute => GoRouteData.$route(
      path: '/banking/transfers/local/create',
      parentNavigatorKey: CreateLocalTransferRoute.$parentNavigatorKey,
      factory: $CreateLocalTransferRoute._fromState,
    );

mixin $CreateLocalTransferRoute on GoRouteData {
  static CreateLocalTransferRoute _fromState(GoRouterState state) =>
      const CreateLocalTransferRoute();

  @override
  String get location => GoRouteData.$location(
        '/banking/transfers/local/create',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $localTransferDetailRoute => GoRouteData.$route(
      path: '/banking/transfers/local/detail',
      parentNavigatorKey: LocalTransferDetailRoute.$parentNavigatorKey,
      factory: $LocalTransferDetailRoute._fromState,
    );

mixin $LocalTransferDetailRoute on GoRouteData {
  static LocalTransferDetailRoute _fromState(GoRouterState state) =>
      const LocalTransferDetailRoute();

  @override
  String get location => GoRouteData.$location(
        '/banking/transfers/local/detail',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createExternalTransferRoute => GoRouteData.$route(
      path: '/banking/transfers/external/create',
      parentNavigatorKey: CreateExternalTransferRoute.$parentNavigatorKey,
      factory: $CreateExternalTransferRoute._fromState,
    );

mixin $CreateExternalTransferRoute on GoRouteData {
  static CreateExternalTransferRoute _fromState(GoRouterState state) =>
      const CreateExternalTransferRoute();

  @override
  String get location => GoRouteData.$location(
        '/banking/transfers/external/create',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $externalTransferDetailRoute => GoRouteData.$route(
      path: '/banking/transfers/external/detail',
      parentNavigatorKey: ExternalTransferDetailRoute.$parentNavigatorKey,
      factory: $ExternalTransferDetailRoute._fromState,
    );

mixin $ExternalTransferDetailRoute on GoRouteData {
  static ExternalTransferDetailRoute _fromState(GoRouterState state) =>
      const ExternalTransferDetailRoute();

  @override
  String get location => GoRouteData.$location(
        '/banking/transfers/external/detail',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $productsListRoute => GoRouteData.$route(
      path: '/products',
      parentNavigatorKey: ProductsListRoute.$parentNavigatorKey,
      factory: $ProductsListRoute._fromState,
    );

mixin $ProductsListRoute on GoRouteData {
  static ProductsListRoute _fromState(GoRouterState state) =>
      const ProductsListRoute();

  @override
  String get location => GoRouteData.$location(
        '/products',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $productDetailRoute => GoRouteData.$route(
      path: '/products/detail',
      parentNavigatorKey: ProductDetailRoute.$parentNavigatorKey,
      factory: $ProductDetailRoute._fromState,
    );

mixin $ProductDetailRoute on GoRouteData {
  static ProductDetailRoute _fromState(GoRouterState state) =>
      const ProductDetailRoute();

  @override
  String get location => GoRouteData.$location(
        '/products/detail',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createProductRoute => GoRouteData.$route(
      path: '/products/create',
      parentNavigatorKey: CreateProductRoute.$parentNavigatorKey,
      factory: $CreateProductRoute._fromState,
    );

mixin $CreateProductRoute on GoRouteData {
  static CreateProductRoute _fromState(GoRouterState state) =>
      const CreateProductRoute();

  @override
  String get location => GoRouteData.$location(
        '/products/create',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $invDashboardRoute => GoRouteData.$route(
      path: '/inventory',
      parentNavigatorKey: InvDashboardRoute.$parentNavigatorKey,
      factory: $InvDashboardRoute._fromState,
    );

mixin $InvDashboardRoute on GoRouteData {
  static InvDashboardRoute _fromState(GoRouterState state) =>
      const InvDashboardRoute();

  @override
  String get location => GoRouteData.$location(
        '/inventory',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $warehousesListRoute => GoRouteData.$route(
      path: '/warehouses',
      parentNavigatorKey: WarehousesListRoute.$parentNavigatorKey,
      factory: $WarehousesListRoute._fromState,
    );

mixin $WarehousesListRoute on GoRouteData {
  static WarehousesListRoute _fromState(GoRouterState state) =>
      const WarehousesListRoute();

  @override
  String get location => GoRouteData.$location(
        '/warehouses',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $transferListRoute => GoRouteData.$route(
      path: '/stock-transfers',
      parentNavigatorKey: TransferListRoute.$parentNavigatorKey,
      factory: $TransferListRoute._fromState,
    );

mixin $TransferListRoute on GoRouteData {
  static TransferListRoute _fromState(GoRouterState state) =>
      const TransferListRoute();

  @override
  String get location => GoRouteData.$location(
        '/stock-transfers',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $issueDetailRoute => GoRouteData.$route(
      path: '/inventory/issue-detail',
      parentNavigatorKey: IssueDetailRoute.$parentNavigatorKey,
      factory: $IssueDetailRoute._fromState,
    );

mixin $IssueDetailRoute on GoRouteData {
  static IssueDetailRoute _fromState(GoRouterState state) =>
      const IssueDetailRoute();

  @override
  String get location => GoRouteData.$location(
        '/inventory/issue-detail',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $receiveCreateRoute => GoRouteData.$route(
      path: '/inventory/receive',
      parentNavigatorKey: ReceiveCreateRoute.$parentNavigatorKey,
      factory: $ReceiveCreateRoute._fromState,
    );

mixin $ReceiveCreateRoute on GoRouteData {
  static ReceiveCreateRoute _fromState(GoRouterState state) =>
      const ReceiveCreateRoute();

  @override
  String get location => GoRouteData.$location(
        '/inventory/receive',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $receiveDetailRoute => GoRouteData.$route(
      path: '/inventory/receive-detail',
      parentNavigatorKey: ReceiveDetailRoute.$parentNavigatorKey,
      factory: $ReceiveDetailRoute._fromState,
    );

mixin $ReceiveDetailRoute on GoRouteData {
  static ReceiveDetailRoute _fromState(GoRouterState state) =>
      const ReceiveDetailRoute();

  @override
  String get location => GoRouteData.$location(
        '/inventory/receive-detail',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $transferCreateRoute => GoRouteData.$route(
      path: '/inventory/transfers/create',
      parentNavigatorKey: TransferCreateRoute.$parentNavigatorKey,
      factory: $TransferCreateRoute._fromState,
    );

mixin $TransferCreateRoute on GoRouteData {
  static TransferCreateRoute _fromState(GoRouterState state) =>
      const TransferCreateRoute();

  @override
  String get location => GoRouteData.$location(
        '/inventory/transfers/create',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $transferDetailRoute => GoRouteData.$route(
      path: '/inventory/transfers/detail',
      parentNavigatorKey: TransferDetailRoute.$parentNavigatorKey,
      factory: $TransferDetailRoute._fromState,
    );

mixin $TransferDetailRoute on GoRouteData {
  static TransferDetailRoute _fromState(GoRouterState state) =>
      const TransferDetailRoute();

  @override
  String get location => GoRouteData.$location(
        '/inventory/transfers/detail',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $adjustmentRoute => GoRouteData.$route(
      path: '/inventory/adjustment',
      parentNavigatorKey: AdjustmentRoute.$parentNavigatorKey,
      factory: $AdjustmentRoute._fromState,
    );

mixin $AdjustmentRoute on GoRouteData {
  static AdjustmentRoute _fromState(GoRouterState state) =>
      const AdjustmentRoute();

  @override
  String get location => GoRouteData.$location(
        '/inventory/adjustment',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $stockTakeRoute => GoRouteData.$route(
      path: '/inventory/stocktake',
      parentNavigatorKey: StockTakeRoute.$parentNavigatorKey,
      factory: $StockTakeRoute._fromState,
    );

mixin $StockTakeRoute on GoRouteData {
  static StockTakeRoute _fromState(GoRouterState state) =>
      const StockTakeRoute();

  @override
  String get location => GoRouteData.$location(
        '/inventory/stocktake',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $categoriesRoute => GoRouteData.$route(
      path: '/inventory/categories',
      parentNavigatorKey: CategoriesRoute.$parentNavigatorKey,
      factory: $CategoriesRoute._fromState,
    );

mixin $CategoriesRoute on GoRouteData {
  static CategoriesRoute _fromState(GoRouterState state) =>
      const CategoriesRoute();

  @override
  String get location => GoRouteData.$location(
        '/inventory/categories',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $uomRoute => GoRouteData.$route(
      path: '/inventory/uom',
      parentNavigatorKey: UomRoute.$parentNavigatorKey,
      factory: $UomRoute._fromState,
    );

mixin $UomRoute on GoRouteData {
  static UomRoute _fromState(GoRouterState state) => const UomRoute();

  @override
  String get location => GoRouteData.$location(
        '/inventory/uom',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $priceListsRoute => GoRouteData.$route(
      path: '/price-lists',
      parentNavigatorKey: PriceListsRoute.$parentNavigatorKey,
      factory: $PriceListsRoute._fromState,
    );

mixin $PriceListsRoute on GoRouteData {
  static PriceListsRoute _fromState(GoRouterState state) =>
      const PriceListsRoute();

  @override
  String get location => GoRouteData.$location(
        '/price-lists',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $barcodePrintRoute => GoRouteData.$route(
      path: '/barcode-print',
      parentNavigatorKey: BarcodePrintRoute.$parentNavigatorKey,
      factory: $BarcodePrintRoute._fromState,
    );

mixin $BarcodePrintRoute on GoRouteData {
  static BarcodePrintRoute _fromState(GoRouterState state) =>
      const BarcodePrintRoute();

  @override
  String get location => GoRouteData.$location(
        '/barcode-print',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $currenciesListRoute => GoRouteData.$route(
      path: '/currencies',
      parentNavigatorKey: CurrenciesListRoute.$parentNavigatorKey,
      factory: $CurrenciesListRoute._fromState,
    );

mixin $CurrenciesListRoute on GoRouteData {
  static CurrenciesListRoute _fromState(GoRouterState state) =>
      const CurrenciesListRoute();

  @override
  String get location => GoRouteData.$location(
        '/currencies',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createCurrencyRoute => GoRouteData.$route(
      path: '/currencies/create',
      parentNavigatorKey: CreateCurrencyRoute.$parentNavigatorKey,
      factory: $CreateCurrencyRoute._fromState,
    );

mixin $CreateCurrencyRoute on GoRouteData {
  static CreateCurrencyRoute _fromState(GoRouterState state) =>
      const CreateCurrencyRoute();

  @override
  String get location => GoRouteData.$location(
        '/currencies/create',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $currencyDetailRoute => GoRouteData.$route(
      path: '/currencies/detail',
      parentNavigatorKey: CurrencyDetailRoute.$parentNavigatorKey,
      factory: $CurrencyDetailRoute._fromState,
    );

mixin $CurrencyDetailRoute on GoRouteData {
  static CurrencyDetailRoute _fromState(GoRouterState state) =>
      const CurrencyDetailRoute();

  @override
  String get location => GoRouteData.$location(
        '/currencies/detail',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $exchangeRateSetupRoute => GoRouteData.$route(
      path: '/exchange-rates',
      parentNavigatorKey: ExchangeRateSetupRoute.$parentNavigatorKey,
      factory: $ExchangeRateSetupRoute._fromState,
    );

mixin $ExchangeRateSetupRoute on GoRouteData {
  static ExchangeRateSetupRoute _fromState(GoRouterState state) =>
      const ExchangeRateSetupRoute();

  @override
  String get location => GoRouteData.$location(
        '/exchange-rates',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $fiscalYearSetupRoute => GoRouteData.$route(
      path: '/fiscal-year',
      parentNavigatorKey: FiscalYearSetupRoute.$parentNavigatorKey,
      factory: $FiscalYearSetupRoute._fromState,
    );

mixin $FiscalYearSetupRoute on GoRouteData {
  static FiscalYearSetupRoute _fromState(GoRouterState state) =>
      const FiscalYearSetupRoute();

  @override
  String get location => GoRouteData.$location(
        '/fiscal-year',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $customersListRoute => GoRouteData.$route(
      path: '/customers',
      parentNavigatorKey: CustomersListRoute.$parentNavigatorKey,
      factory: $CustomersListRoute._fromState,
    );

mixin $CustomersListRoute on GoRouteData {
  static CustomersListRoute _fromState(GoRouterState state) =>
      const CustomersListRoute();

  @override
  String get location => GoRouteData.$location(
        '/customers',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $customerDetailRoute => GoRouteData.$route(
      path: '/customers/detail',
      parentNavigatorKey: CustomerDetailRoute.$parentNavigatorKey,
      factory: $CustomerDetailRoute._fromState,
    );

mixin $CustomerDetailRoute on GoRouteData {
  static CustomerDetailRoute _fromState(GoRouterState state) =>
      const CustomerDetailRoute();

  @override
  String get location => GoRouteData.$location(
        '/customers/detail',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createCustomerRoute => GoRouteData.$route(
      path: '/customers/create',
      parentNavigatorKey: CreateCustomerRoute.$parentNavigatorKey,
      factory: $CreateCustomerRoute._fromState,
    );

mixin $CreateCustomerRoute on GoRouteData {
  static CreateCustomerRoute _fromState(GoRouterState state) =>
      const CreateCustomerRoute();

  @override
  String get location => GoRouteData.$location(
        '/customers/create',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $suppliersListRoute => GoRouteData.$route(
      path: '/suppliers',
      parentNavigatorKey: SuppliersListRoute.$parentNavigatorKey,
      factory: $SuppliersListRoute._fromState,
    );

mixin $SuppliersListRoute on GoRouteData {
  static SuppliersListRoute _fromState(GoRouterState state) =>
      const SuppliersListRoute();

  @override
  String get location => GoRouteData.$location(
        '/suppliers',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $supplierDetailRoute => GoRouteData.$route(
      path: '/suppliers/detail',
      parentNavigatorKey: SupplierDetailRoute.$parentNavigatorKey,
      factory: $SupplierDetailRoute._fromState,
    );

mixin $SupplierDetailRoute on GoRouteData {
  static SupplierDetailRoute _fromState(GoRouterState state) =>
      const SupplierDetailRoute();

  @override
  String get location => GoRouteData.$location(
        '/suppliers/detail',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createSupplierRoute => GoRouteData.$route(
      path: '/suppliers/create',
      parentNavigatorKey: CreateSupplierRoute.$parentNavigatorKey,
      factory: $CreateSupplierRoute._fromState,
    );

mixin $CreateSupplierRoute on GoRouteData {
  static CreateSupplierRoute _fromState(GoRouterState state) =>
      const CreateSupplierRoute();

  @override
  String get location => GoRouteData.$location(
        '/suppliers/create',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $trialBalanceRoute => GoRouteData.$route(
      path: '/reports/trial-balance',
      parentNavigatorKey: TrialBalanceRoute.$parentNavigatorKey,
      factory: $TrialBalanceRoute._fromState,
    );

mixin $TrialBalanceRoute on GoRouteData {
  static TrialBalanceRoute _fromState(GoRouterState state) =>
      const TrialBalanceRoute();

  @override
  String get location => GoRouteData.$location(
        '/reports/trial-balance',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $incomeStatementRoute => GoRouteData.$route(
      path: '/reports/income-statement',
      parentNavigatorKey: IncomeStatementRoute.$parentNavigatorKey,
      factory: $IncomeStatementRoute._fromState,
    );

mixin $IncomeStatementRoute on GoRouteData {
  static IncomeStatementRoute _fromState(GoRouterState state) =>
      const IncomeStatementRoute();

  @override
  String get location => GoRouteData.$location(
        '/reports/income-statement',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $balanceSheetRoute => GoRouteData.$route(
      path: '/reports/balance-sheet',
      parentNavigatorKey: BalanceSheetRoute.$parentNavigatorKey,
      factory: $BalanceSheetRoute._fromState,
    );

mixin $BalanceSheetRoute on GoRouteData {
  static BalanceSheetRoute _fromState(GoRouterState state) =>
      const BalanceSheetRoute();

  @override
  String get location => GoRouteData.$location(
        '/reports/balance-sheet',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $inventoryValuationRoute => GoRouteData.$route(
      path: '/reports/inventory-valuation',
      parentNavigatorKey: InventoryValuationRoute.$parentNavigatorKey,
      factory: $InventoryValuationRoute._fromState,
    );

mixin $InventoryValuationRoute on GoRouteData {
  static InventoryValuationRoute _fromState(GoRouterState state) =>
      const InventoryValuationRoute();

  @override
  String get location => GoRouteData.$location(
        '/reports/inventory-valuation',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $auditLogRoute => GoRouteData.$route(
      path: '/reports/audit-log',
      parentNavigatorKey: AuditLogRoute.$parentNavigatorKey,
      factory: $AuditLogRoute._fromState,
    );

mixin $AuditLogRoute on GoRouteData {
  static AuditLogRoute _fromState(GoRouterState state) => const AuditLogRoute();

  @override
  String get location => GoRouteData.$location(
        '/reports/audit-log',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $usersListRoute => GoRouteData.$route(
      path: '/admin/users',
      parentNavigatorKey: UsersListRoute.$parentNavigatorKey,
      factory: $UsersListRoute._fromState,
    );

mixin $UsersListRoute on GoRouteData {
  static UsersListRoute _fromState(GoRouterState state) =>
      const UsersListRoute();

  @override
  String get location => GoRouteData.$location(
        '/admin/users',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $userDetailRoute => GoRouteData.$route(
      path: '/admin/users/detail',
      parentNavigatorKey: UserDetailRoute.$parentNavigatorKey,
      factory: $UserDetailRoute._fromState,
    );

mixin $UserDetailRoute on GoRouteData {
  static UserDetailRoute _fromState(GoRouterState state) =>
      const UserDetailRoute();

  @override
  String get location => GoRouteData.$location(
        '/admin/users/detail',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createUserRoute => GoRouteData.$route(
      path: '/admin/users/create',
      parentNavigatorKey: CreateUserRoute.$parentNavigatorKey,
      factory: $CreateUserRoute._fromState,
    );

mixin $CreateUserRoute on GoRouteData {
  static CreateUserRoute _fromState(GoRouterState state) =>
      const CreateUserRoute();

  @override
  String get location => GoRouteData.$location(
        '/admin/users/create',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $rolesPermissionsRoute => GoRouteData.$route(
      path: '/admin/roles',
      parentNavigatorKey: RolesPermissionsRoute.$parentNavigatorKey,
      factory: $RolesPermissionsRoute._fromState,
    );

mixin $RolesPermissionsRoute on GoRouteData {
  static RolesPermissionsRoute _fromState(GoRouterState state) =>
      const RolesPermissionsRoute();

  @override
  String get location => GoRouteData.$location(
        '/admin/roles',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $settingsHubRoute => GoRouteData.$route(
      path: '/settings',
      parentNavigatorKey: SettingsHubRoute.$parentNavigatorKey,
      factory: $SettingsHubRoute._fromState,
    );

mixin $SettingsHubRoute on GoRouteData {
  static SettingsHubRoute _fromState(GoRouterState state) =>
      const SettingsHubRoute();

  @override
  String get location => GoRouteData.$location(
        '/settings',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $companyProfileRoute => GoRouteData.$route(
      path: '/settings/company',
      parentNavigatorKey: CompanyProfileRoute.$parentNavigatorKey,
      factory: $CompanyProfileRoute._fromState,
    );

mixin $CompanyProfileRoute on GoRouteData {
  static CompanyProfileRoute _fromState(GoRouterState state) =>
      const CompanyProfileRoute();

  @override
  String get location => GoRouteData.$location(
        '/settings/company',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $financialSettingsRoute => GoRouteData.$route(
      path: '/settings/financial',
      parentNavigatorKey: FinancialSettingsRoute.$parentNavigatorKey,
      factory: $FinancialSettingsRoute._fromState,
    );

mixin $FinancialSettingsRoute on GoRouteData {
  static FinancialSettingsRoute _fromState(GoRouterState state) =>
      const FinancialSettingsRoute();

  @override
  String get location => GoRouteData.$location(
        '/settings/financial',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $taxesSettingsRoute => GoRouteData.$route(
      path: '/settings/taxes',
      parentNavigatorKey: TaxesSettingsRoute.$parentNavigatorKey,
      factory: $TaxesSettingsRoute._fromState,
    );

mixin $TaxesSettingsRoute on GoRouteData {
  static TaxesSettingsRoute _fromState(GoRouterState state) =>
      const TaxesSettingsRoute();

  @override
  String get location => GoRouteData.$location(
        '/settings/taxes',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $currenciesSettingsRoute => GoRouteData.$route(
      path: '/settings/currencies',
      parentNavigatorKey: CurrenciesSettingsRoute.$parentNavigatorKey,
      factory: $CurrenciesSettingsRoute._fromState,
    );

mixin $CurrenciesSettingsRoute on GoRouteData {
  static CurrenciesSettingsRoute _fromState(GoRouterState state) =>
      const CurrenciesSettingsRoute();

  @override
  String get location => GoRouteData.$location(
        '/settings/currencies',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $numberingRoute => GoRouteData.$route(
      path: '/settings/numbering',
      parentNavigatorKey: NumberingRoute.$parentNavigatorKey,
      factory: $NumberingRoute._fromState,
    );

mixin $NumberingRoute on GoRouteData {
  static NumberingRoute _fromState(GoRouterState state) =>
      const NumberingRoute();

  @override
  String get location => GoRouteData.$location(
        '/settings/numbering',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $branchesStoresRoute => GoRouteData.$route(
      path: '/settings/branches',
      parentNavigatorKey: BranchesStoresRoute.$parentNavigatorKey,
      factory: $BranchesStoresRoute._fromState,
    );

mixin $BranchesStoresRoute on GoRouteData {
  static BranchesStoresRoute _fromState(GoRouterState state) =>
      const BranchesStoresRoute();

  @override
  String get location => GoRouteData.$location(
        '/settings/branches',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $rolesListRoute => GoRouteData.$route(
      path: '/admin/roles-list',
      parentNavigatorKey: RolesListRoute.$parentNavigatorKey,
      factory: $RolesListRoute._fromState,
    );

mixin $RolesListRoute on GoRouteData {
  static RolesListRoute _fromState(GoRouterState state) =>
      const RolesListRoute();

  @override
  String get location => GoRouteData.$location(
        '/admin/roles-list',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $roleEditorRoute => GoRouteData.$route(
      path: '/admin/roles/edit',
      parentNavigatorKey: RoleEditorRoute.$parentNavigatorKey,
      factory: $RoleEditorRoute._fromState,
    );

mixin $RoleEditorRoute on GoRouteData {
  static RoleEditorRoute _fromState(GoRouterState state) =>
      const RoleEditorRoute();

  @override
  String get location => GoRouteData.$location(
        '/admin/roles/edit',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $tenantsRoute => GoRouteData.$route(
      path: '/settings/workspaces',
      parentNavigatorKey: TenantsRoute.$parentNavigatorKey,
      factory: $TenantsRoute._fromState,
    );

mixin $TenantsRoute on GoRouteData {
  static TenantsRoute _fromState(GoRouterState state) => const TenantsRoute();

  @override
  String get location => GoRouteData.$location(
        '/settings/workspaces',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $integrationsRoute => GoRouteData.$route(
      path: '/settings/integrations',
      parentNavigatorKey: IntegrationsRoute.$parentNavigatorKey,
      factory: $IntegrationsRoute._fromState,
    );

mixin $IntegrationsRoute on GoRouteData {
  static IntegrationsRoute _fromState(GoRouterState state) =>
      const IntegrationsRoute();

  @override
  String get location => GoRouteData.$location(
        '/settings/integrations',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $webhooksRoute => GoRouteData.$route(
      path: '/settings/webhooks',
      parentNavigatorKey: WebhooksRoute.$parentNavigatorKey,
      factory: $WebhooksRoute._fromState,
    );

mixin $WebhooksRoute on GoRouteData {
  static WebhooksRoute _fromState(GoRouterState state) => const WebhooksRoute();

  @override
  String get location => GoRouteData.$location(
        '/settings/webhooks',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $apiKeysRoute => GoRouteData.$route(
      path: '/settings/api-keys',
      parentNavigatorKey: ApiKeysRoute.$parentNavigatorKey,
      factory: $ApiKeysRoute._fromState,
    );

mixin $ApiKeysRoute on GoRouteData {
  static ApiKeysRoute _fromState(GoRouterState state) => const ApiKeysRoute();

  @override
  String get location => GoRouteData.$location(
        '/settings/api-keys',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $notificationsRoute => GoRouteData.$route(
      path: '/settings/notifications',
      parentNavigatorKey: NotificationsRoute.$parentNavigatorKey,
      factory: $NotificationsRoute._fromState,
    );

mixin $NotificationsRoute on GoRouteData {
  static NotificationsRoute _fromState(GoRouterState state) =>
      const NotificationsRoute();

  @override
  String get location => GoRouteData.$location(
        '/settings/notifications',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $billingRoute => GoRouteData.$route(
      path: '/settings/billing',
      parentNavigatorKey: BillingRoute.$parentNavigatorKey,
      factory: $BillingRoute._fromState,
    );

mixin $BillingRoute on GoRouteData {
  static BillingRoute _fromState(GoRouterState state) => const BillingRoute();

  @override
  String get location => GoRouteData.$location(
        '/settings/billing',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $backupRoute => GoRouteData.$route(
      path: '/settings/backup',
      parentNavigatorKey: BackupRoute.$parentNavigatorKey,
      factory: $BackupRoute._fromState,
    );

mixin $BackupRoute on GoRouteData {
  static BackupRoute _fromState(GoRouterState state) => const BackupRoute();

  @override
  String get location => GoRouteData.$location(
        '/settings/backup',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
