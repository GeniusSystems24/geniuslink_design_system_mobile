// MOBILE_DASHBOARD_COMPONENTIZATION_V3
import 'dart:async' show unawaited;

import 'package:flutter/material.dart';

import '../../domain/domain.dart';
import '../controllers/mobile_dashboard_controller.dart';
import 'mobile_dashboard_quick_actions.dart';
import 'mobile_dashboard_search_sheet.dart';
import 'mobile_dashboard_theme.dart';
import 'mobile_dashboard_sections.dart';
import 'mobile_dashboard_view_data.dart';

class MobileDashboardSectionView extends StatefulWidget {
  final WorkspaceRepository repository;
  final MdWorkspace workspace;
  final bool online;

  const MobileDashboardSectionView({
    required this.repository,
    required this.workspace,
    required this.online,
    super.key,
  });

  @override
  MobileDashboardSectionViewState createState() =>
      MobileDashboardSectionViewState();
}

class MobileDashboardSectionViewState
    extends State<MobileDashboardSectionView> {
  late final MobileDashboardController _dashboardController;
  final ScrollController _scrollController = ScrollController();

  MobileDashboardCatalog get _catalog => widget.repository.catalog;
  String get _sectionId => widget.repository.sectionId;
  MdWorkspace get _workspace => widget.workspace;

  MobileDashboardViewData get _currentDashboard => MobileDashboardViewData(
    catalog: _catalog,
    sectionId: _sectionId,
    state: _dashboardController.state,
    workspace: _workspace,
  );

  String _resolveDashboardTab({
    required List<MdTab> tabs,
    required String currentTab,
    required bool preferSectionTab,
  }) {
    bool hasTab(String tabId) => tabs.any((tab) => tab.id == tabId);

    if (preferSectionTab && hasTab(_sectionId)) {
      return _sectionId;
    }
    if (hasTab(currentTab)) {
      return currentTab;
    }
    return tabs.first.id;
  }

  void _syncDashboardSelections({required bool preferSectionTab}) {
    final catalog = _catalog;
    final tabs = catalog.tabs;

    if (tabs.isNotEmpty) {
      final currentTab = _dashboardController.state.tab;
      final targetTab = _resolveDashboardTab(
        tabs: tabs,
        currentTab: currentTab,
        preferSectionTab: preferSectionTab,
      );

      if (currentTab != targetTab) {
        _dashboardController.selectTab(targetTab);
      }
    }

    final currencies = catalog.currencies;
    final currentCurrency = _dashboardController.state.cur;
    final currencyExists = currencies.any(
      (currency) => currency.code == currentCurrency,
    );
    if (currencies.isNotEmpty && !currencyExists) {
      _dashboardController.setCurrency(currencies.first.code);
    }
  }

  void _showDashboardToast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: _DashboardToastContent(message: message),
          backgroundColor: context.mdColors.inverseSurface,
          behavior: SnackBarBehavior.floating,
          duration: MobileDashboardDurations.toast,
          shape: const StadiumBorder(),
          width: MobileDashboardLayout.toastWidth,
        ),
      );
  }

  Future<void> _refresh() => _dashboardController.refresh();

  void _openActions() {
    final dashboard = _currentDashboard;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: context.mdTheme.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: MobileDashboardLayout.sheetBorderRadius,
      ),
      builder: (sheetContext) => MobileDashboardActionsSheet(
        actions: dashboard.selectedTab.actions,
        onActionTap: (action) {
          Navigator.of(sheetContext).pop();
          _showDashboardToast(MobileDashboardCopy.openingAction(action.label));
        },
      ),
    );
  }

  void _openSearch() {
    final dashboard = _currentDashboard;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: context.mdColors.surface,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: MobileDashboardLayout.sheetBorderRadius,
      ),
      builder: (sheetContext) => MobileDashboardSearchSheet(
        currency: dashboard.currency,
        factor: dashboard.workspace.factor,
        tabs: dashboard.catalog.tabs,
        onOperationTap: (operation) {
          Navigator.of(sheetContext).pop();
          _showDashboardToast(operation.reference);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _dashboardController = MobileDashboardController(initialTab: _sectionId);
    _syncDashboardSelections(preferSectionTab: false);
    unawaited(_refresh());
  }

  @override
  void didUpdateWidget(covariant MobileDashboardSectionView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncDashboardSelections(
      preferSectionTab: oldWidget.repository.sectionId != _sectionId,
    );
  }

  @override
  void dispose() {
    _dashboardController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> refresh() => _refresh();

  void scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
  }

  void openSearch() => _openSearch();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _dashboardController,
      builder: (context, _) {
        final state = _dashboardController.state;
        return MobileDashboardSectionContent(
          dashboard: MobileDashboardViewData(
            catalog: _catalog,
            sectionId: _sectionId,
            state: state,
            workspace: _workspace,
          ),
          online: widget.online,
          scrollController: _scrollController,
          onRefresh: _refresh,
          onToast: _showDashboardToast,
          onOpenActions: _openActions,
          onToggleView: _dashboardController.toggleView,
          onCurrencyChanged: _dashboardController.setCurrency,
          onPeriodChanged: _dashboardController.setPeriod,
          onMetricSelected: _dashboardController.setChartMetric,
        );
      },
    );
  }
}

class _DashboardToastContent extends StatelessWidget {
  final String message;

  const _DashboardToastContent({required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.check_rounded,
          size: MobileDashboardLayout.toastIconSize,
          color: context.mdColors.onInverseSurface,
        ),
        const SizedBox(width: MobileDashboardLayout.toastIconGap),
        Expanded(
          child: Text(
            message,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: context.mdColors.onInverseSurface,
              fontWeight: FontWeight.w600,
              fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
            ),
          ),
        ),
      ],
    );
  }
}
