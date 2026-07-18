import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/load_status.dart';
import '../../../../workspace/presentation/bloc/tenant_cubit.dart';
import '../../domain/domain.dart';
import '../bloc/mobile_dashboard_cubit.dart';
import '../widgets/widgets.dart';

class MobileDashboardScreen extends StatefulWidget {
  final MobileDashboardCatalog catalog;

  const MobileDashboardScreen({
    required this.catalog,
    super.key,
  });

  @override
  State<MobileDashboardScreen> createState() =>
      _MobileDashboardScreenState();
}

class _MobileDashboardScreenState extends State<MobileDashboardScreen> {
  late final MobileDashboardCubit _dashboardCubit;
  final ScrollController _scrollController = ScrollController();

  String _activeTenantId = '9';
  bool _workspaceMenuOpen = false;
  bool _drawerOpen = false;
  bool _online = true;

  MobileDashboardState get _dashboardState => _dashboardCubit.state;
  String get _tabId => _dashboardState.tab;
  String get _currency => _dashboardState.cur;
  String get _period => _dashboardState.period;
  String get _view => _dashboardState.view;
  String? get _chartMetricId => _dashboardState.chartMetric;
  bool get _loading => _dashboardState.status.isLoading;

  MdTab get _selectedTab {
    if (widget.catalog.tabs.isEmpty) {
      return const MdTab(
        id: 'empty',
        label: 'Dashboard',
        cards: [],
        actions: [],
        operations: [],
      );
    }
    return widget.catalog.tabs.firstWhere(
      (tab) => tab.id == _tabId,
      orElse: () => widget.catalog.tabs.first,
    );
  }

  MdWorkspace get _workspace {
    if (widget.catalog.workspaces.isEmpty) {
      return const MdWorkspace('default', 'default', 'Workspace', '', 1);
    }
    return widget.catalog.workspaces.firstWhere(
      (workspace) => workspace.tenantId == _activeTenantId,
      orElse: () => widget.catalog.workspaces.first,
    );
  }

  @override
  void initState() {
    super.initState();
    _dashboardCubit = MobileDashboardCubit();

    if (widget.catalog.tabs.isNotEmpty &&
        !widget.catalog.tabs.any((tab) => tab.id == _dashboardCubit.state.tab)) {
      _dashboardCubit.selectTab(widget.catalog.tabs.first.id);
    }
    if (widget.catalog.currencies.isNotEmpty &&
        !widget.catalog.currencies
            .any((currency) => currency.code == _dashboardCubit.state.cur)) {
      _dashboardCubit.setCurrency(widget.catalog.currencies.first.code);
    }
  }

  @override
  void dispose() {
    _dashboardCubit.close();
    _scrollController.dispose();
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

  Future<void> _refresh() => _dashboardCubit.refresh();

  void _switchWorkspace(MdWorkspace workspace) {
    setState(() => _workspaceMenuOpen = false);
    context.read<TenantCubit>().switchTo(workspace.tenantId);
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
    _refresh();
  }

  double _cardValue(MdCard card) {
    return (card.values[_currency] ?? 0) * _workspace.factor;
  }

  double _operationAmount(MdOperation operation) {
    return (operation.amounts[_currency] ?? 0) * _workspace.factor;
  }

  void _openActions() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: context.mdTheme.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (sheetContext) => MobileDashboardActionsSheet(
        actions: _selectedTab.actions,
        onActionTap: (action) {
          Navigator.of(sheetContext).pop();
          _showToast('Opening ${action.label}');
        },
      ),
    );
  }

  void _openSearch() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: context.mdColors.surface,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) => MobileDashboardSearchSheet(
        currency: _currency,
        factor: _workspace.factor,
        tabs: widget.catalog.tabs,
        onOperationTap: (operation) {
          Navigator.of(context).pop();
          _showToast(operation.reference);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _activeTenantId =
        context.watch<TenantCubit>().state.activeTenantId ?? _activeTenantId;

    return BlocProvider<MobileDashboardCubit>.value(
      value: _dashboardCubit,
      child: BlocBuilder<MobileDashboardCubit, MobileDashboardState>(
        builder: (context, _) {
          final selectedTab = _selectedTab;
          return Scaffold(
            backgroundColor: context.mdColors.surface,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                MediaQuery.paddingOf(context).top + 64,
              ),
              child: MobileDashboardAppBar(
                workspace: _workspace,
                workspaceMenuOpen: _workspaceMenuOpen,
                onWorkspaceTap: () => setState(
                  () => _workspaceMenuOpen = !_workspaceMenuOpen,
                ),
                onNotificationsTap: () => _showToast('Notifications'),
                onMenuTap: () => setState(() => _drawerOpen = true),
              ),
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    if (!_online) const MobileDashboardOfflineBanner(),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _refresh,
                        color: context.mdColors.primary,
                        backgroundColor: context.mdTheme.surface,
                        child: ListView(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(18, 16, 18, 120),
                          children: [
                            const MobileDashboardTitle(),
                            const SizedBox(height: 16),
                            MobileDashboardDomainTabs(
                              tabs: widget.catalog.tabs,
                              selectedTabId: _tabId,
                              onSelected: _dashboardCubit.selectTab,
                            ),
                            const SizedBox(height: 14),
                            MobileDashboardControls(
                              view: _view,
                              currency: _currency,
                              period: _period,
                              currencies: widget.catalog.currencies,
                              onToggleView: _dashboardCubit.toggleView,
                              onCurrencyChanged:
                                  _dashboardCubit.setCurrency,
                              onPeriodChanged: _dashboardCubit.setPeriod,
                            ),
                            const SizedBox(height: 12),
                            if (_view == 'cards')
                              MobileDashboardMetricGrid(
                                cards: selectedTab.cards,
                                currency: _currency,
                                period: _period,
                                loading: _loading,
                                valueFor: _cardValue,
                              )
                            else
                              MobileDashboardChartView(
                                cards: selectedTab.cards,
                                tabLabel: selectedTab.label,
                                currency: _currency,
                                period: _period,
                                selectedMetricId: _chartMetricId,
                                axisLabels: widget.catalog.axisLabels[_period] ??
                                    const <String>[],
                                valueFor: _cardValue,
                                onMetricSelected:
                                    _dashboardCubit.setChartMetric,
                              ),
                            const SizedBox(height: 24),
                            MobileDashboardQuickActions(
                              actions: selectedTab.actions,
                              onActionTap: (action) =>
                                  _showToast('Opening ${action.label}'),
                              onViewAll: _openActions,
                            ),
                            const SizedBox(height: 24),
                            MobileDashboardRecentOperations(
                              operations: selectedTab.operations,
                              currency: _currency,
                              loading: _loading,
                              amountFor: _operationAmount,
                              onViewAll: () => _showToast('Open journal'),
                            ),
                            const SizedBox(height: 24),
                            MobileDashboardAttentionList(
                              items: widget.catalog.attention,
                              onItemTap: (item) => _showToast(item.label),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                MobileDashboardBottomNavigation(
                  selectedId: 'home',
                  onSelected: (id) {
                    if (id != 'home') {
                      _showToast(id[0].toUpperCase() + id.substring(1));
                    }
                  },
                ),
                MobileDashboardFloatingSearchButton(onTap: _openSearch),
                if (_workspaceMenuOpen)
                  MobileDashboardWorkspaceMenu(
                    workspaces: widget.catalog.workspaces,
                    selectedWorkspace: _workspace,
                    onSelected: _switchWorkspace,
                    onDismiss: () =>
                        setState(() => _workspaceMenuOpen = false),
                  ),
                MobileDashboardDrawer(
                  open: _drawerOpen,
                  workspace: _workspace,
                  online: _online,
                  onOnlineChanged: (online) =>
                      setState(() => _online = online),
                  onNavigationSelected: (label) {
                    setState(() => _drawerOpen = false);
                    _showToast(label);
                  },
                  onSignOut: () {
                    setState(() => _drawerOpen = false);
                    _showToast('Sign out');
                  },
                  onDismiss: () => setState(() => _drawerOpen = false),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
