import 'dart:async' show unawaited;

import 'package:flutter/material.dart';
import 'package:gl_mobile_app/features/mobile_dashboard/presentation/widgets/mobile_dashboard_workspace_menu.dart';

import '../../../../core/tenancy/tenant_connection.dart';
import '../../../../localization/generated/l10n.dart';
import '../../data/datasources/mobile_dashboard_data.dart';
import '../../../../workspace/presentation/controllers/tenant_controller.dart';
import '../../domain/domain.dart';
import '../widgets/mobile_dashboard_header.dart';
import '../widgets/mobile_dashboard_navigation.dart';
import '../widgets/mobile_dashboard_section_view.dart';
import '../widgets/mobile_dashboard_theme.dart';

// MOBILE_DASHBOARD_LOCALIZATION_V2_START
String _mobileDashboardText(
  GeniusLinkLocalization l10n,
  String sourceText,
) {
  return switch (sourceText) {
    'Workspace' => l10n.mobileDashboardWorkspace,
    'Notifications' => l10n.mobileDashboardNotifications,
    'Overview' => l10n.mobileDashboardOverview,
    'Sales' => l10n.mobileDashboardSales,
    'Inventory' => l10n.inventory,
    'More' => l10n.more,
    'Accounts' => l10n.accounts,
    'Transfers' => l10n.mobileDashboardTransfers,
    'Ledger' => l10n.mobileDashboardLedger,
    'Reports' => l10n.mobileDashboardReports,
    'Saudi Riyal' => l10n.mobileDashboardSaudiRiyal,
    'US Dollar' => l10n.mobileDashboardUsDollar,
    'UAE Dirham' => l10n.mobileDashboardUaeDirham,
    'Tenant 9' => l10n.mobileDashboardTenant9,
    'Tenant 14' => l10n.mobileDashboardTenant14,
    'Tenant 22' => l10n.mobileDashboardTenant22,
    'Out-of-balance entries' => l10n.mobileDashboardOutOfBalanceEntries,
    'Debits and credits don\'t match' => l10n.mobileDashboardDebitsAndCreditsDonTMatch2,
    'Pending approvals' => l10n.mobileDashboardPendingApprovals,
    'Vouchers awaiting your sign-off' => l10n.mobileDashboardVouchersAwaitingYourSignOff,
    'Sync conflict' => l10n.mobileDashboardSyncConflict,
    'A draft edited on two devices' => l10n.mobileDashboardADraftEditedOnTwoDevices,
    'Banking' => l10n.mobileDashboardBanking,
    'Total Balance' => l10n.mobileDashboardTotalBalance,
    'Available Cash' => l10n.mobileDashboardAvailableCash,
    'Inflow' => l10n.mobileDashboardInflow,
    'Outflow' => l10n.mobileDashboardOutflow,
    'Deposit' => l10n.mobileDashboardDeposit,
    'Withdrawal' => l10n.mobileDashboardWithdrawal,
    'Transfer' => l10n.mobileDashboardTransfer,
    'Statement' => l10n.mobileDashboardStatement,
    'Beneficiaries' => l10n.mobileDashboardBeneficiaries,
    'Reconcile' => l10n.mobileDashboardReconcile,
    'Cards' => l10n.mobileDashboardCards,
    'Cheques' => l10n.mobileDashboardCheques,
    'Bank Accounts' => l10n.mobileDashboardBankAccounts,
    'Cash deposit — Main' => l10n.mobileDashboardCashDepositMain,
    '1h ago' => l10n.mobileDashboardText1hAgo,
    'Payroll release' => l10n.mobileDashboardPayrollRelease,
    '4h ago' => l10n.mobileDashboardText4hAgo,
    'Riyad Bank → Main' => l10n.mobileDashboardRiyadBankMain,
    'Yesterday' => l10n.mobileDashboardYesterday,
    'Supplier wire' => l10n.mobileDashboardSupplierWire,
    'Customer settlement' => l10n.mobileDashboardCustomerSettlement,
    '2 days ago' => l10n.mobileDashboardText2DaysAgo,
    'Accounting' => l10n.mobileDashboardAccounting,
    'Total Assets' => l10n.mobileDashboardTotalAssets,
    'Cash' => l10n.mobileDashboardCash,
    'Revenue MTD' => l10n.mobileDashboardRevenueMtd,
    'Net Income' => l10n.netIncome,
    'Journal Entry' => l10n.journalEntry,
    'Voucher' => l10n.mobileDashboardVoucher,
    'Receipt' => l10n.mobileDashboardReceipt,
    'Invoice' => l10n.mobileDashboardInvoice,
    'Customers' => l10n.mobileDashboardCustomers,
    'Suppliers' => l10n.mobileDashboardSuppliers,
    'Fixed Assets' => l10n.mobileDashboardFixedAssets,
    'Chart of Accounts' => l10n.chartOfAccounts,
    'Journal' => l10n.mobileDashboardJournal,
    'Depreciation — Q4' => l10n.mobileDashboardDepreciationQ4,
    '2h ago' => l10n.mobileDashboardText2hAgo,
    'Office rent payment' => l10n.mobileDashboardOfficeRentPayment,
    '5h ago' => l10n.mobileDashboardText5hAgo,
    'Revenue accrual' => l10n.mobileDashboardRevenueAccrual,
    'Utilities — Nov' => l10n.mobileDashboardUtilitiesNov,
    'FX revaluation' => l10n.mobileDashboardFxRevaluation,
    'Commercial' => l10n.mobileDashboardCommercial,
    'Sales MTD' => l10n.mobileDashboardSalesMtd,
    'Purchases MTD' => l10n.mobileDashboardPurchasesMtd,
    'Receivables' => l10n.mobileDashboardReceivables,
    'Payables' => l10n.mobileDashboardPayables,
    'Sale' => l10n.mobileDashboardSale,
    'Purchase' => l10n.mobileDashboardPurchase,
    'Quotation' => l10n.mobileDashboardQuotation,
    'Return' => l10n.mobileDashboardReturnText,
    'Price Lists' => l10n.priceLists,
    'Items' => l10n.items,
    '30m ago' => l10n.mobileDashboardText30mAgo,
    '3h ago' => l10n.mobileDashboardText3hAgo,
    'TREASURY & CASH MANAGEMENT' => l10n.mobileDashboardTreasuryCashManagement,
    'Banking control center' => l10n.mobileDashboardBankingControlCenter,
    'Monitor liquidity, bank positions, transfers, and reconciliation activity across every legal entity.' => l10n.mobileDashboardMonitorLiquidityBankPositionsTransfersAndReconciliationActivityAcrossEveryLegalEntity,
    'New transfer' => l10n.mobileDashboardNewTransfer,
    'Treasury status' => l10n.mobileDashboardTreasuryStatus,
    'Treasury workflow' => l10n.mobileDashboardTreasuryWorkflow,
    'Items that require action before the next cut-off.' => l10n.mobileDashboardItemsThatRequireActionBeforeTheNextCutOff,
    'Latest bank movements' => l10n.mobileDashboardLatestBankMovements,
    'Treasury exceptions' => l10n.mobileDashboardTreasuryExceptions,
    'Connected accounts' => l10n.mobileDashboardConnectedAccounts,
    'Across 3 banks' => l10n.mobileDashboardAcross3Banks,
    'Reconciliation' => l10n.mobileDashboardReconciliation,
    '3 statements pending' => l10n.mobileDashboardText3StatementsPending,
    'Payment approvals' => l10n.mobileDashboardPaymentApprovals,
    'SAR 284K awaiting release' => l10n.mobileDashboardSar284kAwaitingRelease,
    'Approve payment batch' => l10n.mobileDashboardApprovePaymentBatch,
    'Payroll and supplier wires' => l10n.mobileDashboardPayrollAndSupplierWires,
    '5 items' => l10n.mobileDashboardText5Items,
    'Reconcile bank statements' => l10n.mobileDashboardReconcileBankStatements,
    'Riyad Bank and SNB' => l10n.mobileDashboardRiyadBankAndSnb,
    '3 open' => l10n.mobileDashboardText3Open,
    'Review 13-week cash forecast' => l10n.mobileDashboardReview13WeekCashForecast,
    'Updated with current commitments' => l10n.mobileDashboardUpdatedWithCurrentCommitments,
    'Today' => l10n.mobileDashboardToday,
    'Unreconciled statements' => l10n.mobileDashboardUnreconciledStatements,
    'Bank statement lines remain unmatched' => l10n.mobileDashboardBankStatementLinesRemainUnmatched,
    'Payments awaiting approval' => l10n.mobileDashboardPaymentsAwaitingApproval,
    'Transfers are approaching the bank cut-off' => l10n.mobileDashboardTransfersAreApproachingTheBankCutOff,
    'Bank feed delayed' => l10n.mobileDashboardBankFeedDelayed,
    'One account has not synchronized today' => l10n.mobileDashboardOneAccountHasNotSynchronizedToday,
    'GENERAL LEDGER & FINANCIAL CONTROL' => l10n.mobileDashboardGeneralLedgerFinancialControl,
    'Accounting command center' => l10n.mobileDashboardAccountingCommandCenter,
    'Track close readiness, posting health, balances, and control exceptions from one operational workspace.' => l10n.mobileDashboardTrackCloseReadinessPostingHealthBalancesAndControlExceptionsFromOneOperationalWorkspace,
    'Post journal' => l10n.mobileDashboardPostJournal,
    'Close readiness' => l10n.mobileDashboardCloseReadiness,
    'Period-close workflow' => l10n.mobileDashboardPeriodCloseWorkflow,
    'Priority tasks for an accurate and controlled close.' => l10n.mobileDashboardPriorityTasksForAnAccurateAndControlledClose,
    'Recent postings' => l10n.mobileDashboardRecentPostings,
    'Accounting exceptions' => l10n.mobileDashboardAccountingExceptions,
    'Open period' => l10n.mobileDashboardOpenPeriod,
    'DEC 2024' => l10n.mobileDashboardDec2024,
    'Closes in 4 days' => l10n.mobileDashboardClosesIn4Days,
    'Trial balance' => l10n.mobileDashboardTrialBalance,
    'Balanced' => l10n.mobileDashboardBalanced,
    'No variance detected' => l10n.mobileDashboardNoVarianceDetected,
    'Unposted journals' => l10n.mobileDashboardUnpostedJournals,
    '2 require approval' => l10n.mobileDashboardText2RequireApproval,
    'Post recurring journals' => l10n.mobileDashboardPostRecurringJournals,
    'Rent, payroll, and depreciation' => l10n.mobileDashboardRentPayrollAndDepreciation,
    '4 batches' => l10n.mobileDashboardText4Batches,
    'Review control accounts' => l10n.mobileDashboardReviewControlAccounts,
    'AR, AP, inventory, and tax' => l10n.mobileDashboardArApInventoryAndTax,
    '2 variances' => l10n.mobileDashboardText2Variances,
    'Lock operational subledgers' => l10n.mobileDashboardLockOperationalSubledgers,
    'After final posting review' => l10n.mobileDashboardAfterFinalPostingReview,
    'Pending' => l10n.mobileDashboardPending,
    'Debits and credits do not match' => l10n.mobileDashboardDebitsAndCreditsDoNotMatch,
    'Draft and approval queues remain open' => l10n.mobileDashboardDraftAndApprovalQueuesRemainOpen,
    'Control account variances' => l10n.mobileDashboardControlAccountVariances,
    'AR and inventory require investigation' => l10n.mobileDashboardArAndInventoryRequireInvestigation,
    'SALES, PURCHASING & ORDER FULFILMENT' => l10n.mobileDashboardSalesPurchasingOrderFulfilment,
    'Commercial operations center' => l10n.mobileDashboardCommercialOperationsCenter,
    'Manage revenue execution, procurement commitments, receivables, and fulfilment risks across the business.' => l10n.mobileDashboardManageRevenueExecutionProcurementCommitmentsReceivablesAndFulfilmentRisksAcrossTheBusiness,
    'Create sales order' => l10n.mobileDashboardCreateSalesOrder,
    'Commercial pulse' => l10n.mobileDashboardCommercialPulse,
    'Order-to-cash workflow' => l10n.mobileDashboardOrderToCashWorkflow,
    'Operational work that can affect revenue and customer service.' => l10n.mobileDashboardOperationalWorkThatCanAffectRevenueAndCustomerService,
    'Latest commercial documents' => l10n.mobileDashboardLatestCommercialDocuments,
    'Commercial exceptions' => l10n.mobileDashboardCommercialExceptions,
    'Open sales orders' => l10n.mobileDashboardOpenSalesOrders,
    'SAR 1.14M pipeline' => l10n.mobileDashboardSar114mPipeline,
    'On-time fulfilment' => l10n.mobileDashboardOnTimeFulfilment,
    '4 orders at risk' => l10n.mobileDashboardText4OrdersAtRisk,
    'Overdue receivables' => l10n.mobileDashboardOverdueReceivables,
    'SAR 176K overdue' => l10n.mobileDashboardSar176kOverdue,
    'Release blocked sales orders' => l10n.mobileDashboardReleaseBlockedSalesOrders,
    'Credit and margin checks' => l10n.mobileDashboardCreditAndMarginChecks,
    '4 orders' => l10n.mobileDashboardText4Orders,
    'Confirm purchase commitments' => l10n.mobileDashboardConfirmPurchaseCommitments,
    'Lead-time changes from suppliers' => l10n.mobileDashboardLeadTimeChangesFromSuppliers,
    '6 lines' => l10n.mobileDashboardText6Lines,
    'Follow up overdue invoices' => l10n.mobileDashboardFollowUpOverdueInvoices,
    'Top customer balances' => l10n.mobileDashboardTopCustomerBalances,
    '8 accounts' => l10n.mobileDashboardText8Accounts,
    'Orders on credit hold' => l10n.mobileDashboardOrdersOnCreditHold,
    'Customer limits or overdue balances exceeded' => l10n.mobileDashboardCustomerLimitsOrOverdueBalancesExceeded,
    'Fulfilment shortages' => l10n.mobileDashboardFulfilmentShortages,
    'Committed quantities exceed available stock' => l10n.mobileDashboardCommittedQuantitiesExceedAvailableStock,
    'Supplier delivery changes' => l10n.mobileDashboardSupplierDeliveryChanges,
    'Expected dates were updated by vendors' => l10n.mobileDashboardExpectedDatesWereUpdatedByVendors,
    '9a' => l10n.mobileDashboardText9a,
    '12p' => l10n.mobileDashboardText12p,
    '3p' => l10n.mobileDashboardText3p,
    '6p' => l10n.mobileDashboardText6p,
    'now' => l10n.mobileDashboardNow,
    'M' => l10n.mobileDashboardM,
    'T' => l10n.mobileDashboardT,
    'W' => l10n.mobileDashboardW,
    'F' => l10n.mobileDashboardF,
    'S' => l10n.mobileDashboardS,
    'W1' => l10n.mobileDashboardW1,
    'W2' => l10n.mobileDashboardW2,
    'W3' => l10n.mobileDashboardW3,
    'W4' => l10n.mobileDashboardW4,
    'W5' => l10n.mobileDashboardW5,
    'W6' => l10n.mobileDashboardW6,
    'W7' => l10n.mobileDashboardW7,
    'W8' => l10n.mobileDashboardW8,
    'Al-Rashid Trading Co.' => l10n.mobileDashboardAlRashidTradingCo,
    'Najd Holdings' => l10n.mobileDashboardNajdHoldings,
    'Coastal Logistics' => l10n.mobileDashboardCoastalLogistics,
    'Gulf Contracting Ltd' => l10n.mobileDashboardGulfContractingLtd,
    'Saudi Steel Co' => l10n.mobileDashboardSaudiSteelCo,
    'Najd Builders' => l10n.mobileDashboardNajdBuilders,
    'Coastal Cement' => l10n.mobileDashboardCoastalCement,
    'Eastern Timber' => l10n.mobileDashboardEasternTimber,
    _ => sourceText,
  };
}

class _LocalizedWorkspaceRepository implements WorkspaceRepository {
  _LocalizedWorkspaceRepository(this._source, this._l10n);

  final WorkspaceRepository _source;
  final GeniusLinkLocalization _l10n;

  late final MobileDashboardCatalog _catalog =
      localizeMobileDashboardCatalog(
        _source.catalog,
        (text) => _mobileDashboardText(_l10n, text),
      );

  late final List<MobileDashboardNavigationDestination> _navigation =
      localizeMobileDashboardNavigationItems(
        _source.navigationItems,
        (text) => _mobileDashboardText(_l10n, text),
      );

  @override
  String get sectionId => _source.sectionId;

  @override
  MobileDashboardCatalog get catalog => _catalog;

  @override
  List<MobileDashboardNavigationDestination> get navigationItems =>
      _navigation;
}
// MOBILE_DASHBOARD_LOCALIZATION_V2_END

class MobileDashboardScreen extends StatefulWidget {
  final WorkspaceRepository repository;
  final TenantController? tenantController;

  const MobileDashboardScreen({
    required this.repository,
    this.tenantController,
    super.key,
  });

  @override
  State<MobileDashboardScreen> createState() => _MobileDashboardScreenState();
}

class _MobileDashboardScreenState extends State<MobileDashboardScreen> {
  final _sectionKey = GlobalKey<MobileDashboardSectionViewState>();
  TenantController? _ownedTenantController;

  String _activeTenantId = '9';
  bool _workspaceMenuOpen = false;
  final bool _online = true;

  TenantController get _tenantController =>
      widget.tenantController ?? _ownedTenantController!;

  MdWorkspace _workspaceFor(
    MobileDashboardCatalog catalog,
    GeniusLinkLocalization l10n,
  ) {
    if (catalog.workspaces.isEmpty) {
      return MdWorkspace(
        'default',
        'default',
        l10n.mobileDashboardWorkspace,
        '',
        1,
      );
    }
    return catalog.workspaces.firstWhere(
      (workspace) => workspace.tenantId == _activeTenantId,
      orElse: () => catalog.workspaces.first,
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.tenantController == null) {
      _ownedTenantController = TenantController(
        resolver: const FakeTenantConnectionResolver(),
      );
      unawaited(_initializeOwnedTenant());
    }
  }

  Future<void> _initializeOwnedTenant() async {
    final controller = _ownedTenantController;
    if (controller == null) return;
    await controller.loadAvailable();
    if (_ownedTenantController == controller) {
      await controller.switchTo(_activeTenantId);
    }
  }

  @override
  void dispose() {
    _ownedTenantController?.dispose();
    super.dispose();
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_rounded,
                size: 15,
                color: context.mdColors.onInverseSurface,
              ),
              const SizedBox(width: 8),
              Text(
                message,
                style: TextStyle(
                  color: context.mdColors.onInverseSurface,
                  fontWeight: FontWeight.w600,
                  fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                ),
              ),
            ],
          ),
          backgroundColor: context.mdColors.inverseSurface,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(milliseconds: 1600),
          shape: const StadiumBorder(),
          width: 280,
        ),
      );
  }

  void _switchWorkspace(MdWorkspace workspace) {
    setState(() => _workspaceMenuOpen = false);
    unawaited(_tenantController.switchTo(workspace.tenantId));
    _sectionKey.currentState?.scrollToTop();
    _sectionKey.currentState?.refresh();
  }

  void _selectNavigationItem(
    String id,
    List<MobileDashboardNavigationDestination> items,
  ) {
    if (id == 'home') return;

    for (final item in items) {
      if (item.id == id) {
        _showToast(item.label);
        return;
      }
    }

    _showToast(id);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _tenantController,
      builder: (context, _) {
        _activeTenantId =
            _tenantController.state.activeTenantId ?? _activeTenantId;

        final l10n = GeniusLinkLocalization.of(context);
        final repository = _LocalizedWorkspaceRepository(
          widget.repository,
          l10n,
        );
        final catalog = repository.catalog;
        final navigationItems = repository.navigationItems;
        final workspace = _workspaceFor(catalog, l10n);

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(
              MediaQuery.paddingOf(context).top + 64,
            ),
            child: MobileDashboardAppBar(
              workspace: workspace,
              workspaceMenuOpen: _workspaceMenuOpen,
              onWorkspaceTap: () =>
                  setState(() => _workspaceMenuOpen = !_workspaceMenuOpen),
              onNotificationsTap: () => _showToast(l10n.mobileDashboardNotifications),
            ),
          ),
          bottomNavigationBar: MobileDashboardBottomNavigation(
            selectedId: 'home',
            items: navigationItems,
            onSelected: (id) => _selectNavigationItem(id, navigationItems),
          ),
          floatingActionButton: MobileDashboardFloatingSearchButton(
            onTap: () => _sectionKey.currentState?.openSearch(),
          ),
          body: Stack(
            children: [
              MobileDashboardSectionView(
                key: _sectionKey,
                repository: repository,
                workspace: workspace,
                online: _online,
              ),
              if (_workspaceMenuOpen)
                MobileDashboardWorkspaceMenu(
                  workspaces: catalog.workspaces,
                  selectedWorkspace: workspace,
                  onSelected: _switchWorkspace,
                  onDismiss: () => setState(() => _workspaceMenuOpen = false),
                ),
            ],
          ),
        );
      },
    );
  }
}
