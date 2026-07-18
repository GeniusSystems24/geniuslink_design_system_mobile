import 'dart:async' show unawaited;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/load_status.dart';
import '../../../../workspace/presentation/bloc/tenant_cubit.dart';
import '../../domain/domain.dart';
import '../bloc/mobile_dashboard_cubit.dart';
import 'mobile_dashboard_attention.dart';
import 'mobile_dashboard_erp_overview.dart';
import 'mobile_dashboard_header.dart';
import 'mobile_dashboard_metrics.dart';
import 'mobile_dashboard_navigation.dart';
import 'mobile_dashboard_overview.dart';
import 'mobile_dashboard_quick_actions.dart';
import 'mobile_dashboard_recent_operations.dart';
import 'mobile_dashboard_search_sheet.dart';
import 'mobile_dashboard_skeleton.dart';
import 'mobile_dashboard_shared.dart';
import 'mobile_dashboard_theme.dart';

class MobileDashboardSectionView extends StatefulWidget {
  final MobileDashboardCatalog catalog;
  final String sectionId;

  const MobileDashboardSectionView({
    required this.catalog,
    required this.sectionId,
    super.key,
  });

  @override
  State<MobileDashboardSectionView> createState() =>
      _MobileDashboardSectionViewState();
}

class _MobileDashboardSectionViewState
    extends State<MobileDashboardSectionView> {
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

  MdDashboardProfile get _profile =>
      widget.catalog.profiles[widget.sectionId] ??
      MdDashboardProfile(
        sectionId: widget.sectionId,
        eyebrow: 'ERP OPERATIONS',
        title: '${_selectedTab.label} control center',
        subtitle: 'A consolidated operational view for this business area.',
        primaryActionId: _selectedTab.actions.isEmpty
            ? 'create'
            : _selectedTab.actions.first.id,
        primaryActionLabel: _selectedTab.actions.isEmpty
            ? 'Create'
            : _selectedTab.actions.first.label,
        statusTitle: 'Operational status',
        workflowTitle: 'Workflow',
        workflowSubtitle: 'Tasks that require review or action.',
        operationsTitle: 'Recent operations',
        attentionTitle: 'Exceptions',
        statusItems: const [],
        workflowItems: const [],
        attentionItems: const [],
      );

  List<MobileDashboardNavigationDestination> get _navigationItems =>
      switch (widget.sectionId) {
        'banking' => const [
            (id: 'home', label: 'Overview', icon: 'home'),
            (id: 'accounts', label: 'Accounts', icon: 'inbox'),
            (id: 'transfers', label: 'Transfers', icon: 'send'),
            (id: 'more', label: 'More', icon: 'dots'),
          ],
        'accounting' => const [
            (id: 'home', label: 'Overview', icon: 'home'),
            (id: 'ledger', label: 'Ledger', icon: 'doc'),
            (id: 'reports', label: 'Reports', icon: 'poll'),
            (id: 'more', label: 'More', icon: 'dots'),
          ],
        'commercial' => const [
            (id: 'home', label: 'Overview', icon: 'home'),
            (id: 'sales', label: 'Sales', icon: 'send'),
            (id: 'inventory', label: 'Inventory', icon: 'grid'),
            (id: 'more', label: 'More', icon: 'dots'),
          ],
        _ => const [
            (id: 'home', label: 'Overview', icon: 'home'),
            (id: 'more', label: 'More', icon: 'dots'),
          ],
      };

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
    _dashboardCubit = MobileDashboardCubit(initialTab: widget.sectionId);

    if (widget.catalog.tabs.isNotEmpty &&
        !widget.catalog.tabs.any((tab) => tab.id == widget.sectionId)) {
      _dashboardCubit.selectTab(widget.catalog.tabs.first.id);
    }
    if (widget.catalog.currencies.isNotEmpty &&
        !widget.catalog.currencies
            .any((currency) => currency.code == _dashboardCubit.state.cur)) {
      _dashboardCubit.setCurrency(widget.catalog.currencies.first.code);
    }
    unawaited(_dashboardCubit.refresh());
  }

  @override
  void didUpdateWidget(covariant MobileDashboardSectionView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sectionId != widget.sectionId &&
        widget.catalog.tabs.any((tab) => tab.id == widget.sectionId)) {
      _dashboardCubit.selectTab(widget.sectionId);
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
                            if (_loading)
                              const MobileDashboardErpHeroSkeleton()
                            else
                              MobileDashboardErpHero(
                                profile: _profile,
                                workspace: _workspace,
                                currency: _currency,
                                onPrimaryAction: () =>
                                    _showToast(_profile.primaryActionLabel),
                              ),
                            const SizedBox(height: 22),
                            if (_loading)
                              MobileDashboardStatusStripSkeleton(
                                itemCount: _profile.statusItems.isEmpty
                                    ? 3
                                    : _profile.statusItems.length,
                              )
                            else
                              MobileDashboardErpStatusStrip(
                                title: _profile.statusTitle,
                                items: _profile.statusItems,
                                onItemTap: (item) => _showToast(item.label),
                              ),
                            const SizedBox(height: 24),
                            if (_loading)
                              const MobileDashboardSectionTitleSkeleton()
                            else
                              const MobileDashboardSectionHeader(
                                title: 'Financial overview',
                                marker: MdMarker.positive,
                                subtitle:
                                    'Consolidated values, movement, and period comparison',
                              ),
                            if (_loading)
                              const MobileDashboardControlsSkeleton()
                            else
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
                            if (_loading)
                              _view == 'cards'
                                  ? MobileDashboardMetricGridSkeleton(
                                      itemCount: selectedTab.cards.isEmpty
                                          ? 4
                                          : selectedTab.cards.length,
                                    )
                                  : const MobileDashboardChartSkeleton()
                            else if (_view == 'cards')
                              MobileDashboardMetricGrid(
                                cards: selectedTab.cards,
                                currency: _currency,
                                period: _period,
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
                            if (_loading)
                              MobileDashboardWorkflowSkeleton(
                                itemCount: _profile.workflowItems.isEmpty
                                    ? 3
                                    : _profile.workflowItems.length,
                              )
                            else
                              MobileDashboardWorkflowPanel(
                                title: _profile.workflowTitle,
                                subtitle: _profile.workflowSubtitle,
                                items: _profile.workflowItems,
                                onItemTap: (item) => _showToast(item.title),
                              ),
                            const SizedBox(height: 24),
                            if (_loading)
                              MobileDashboardQuickActionsSkeleton(
                                itemCount: selectedTab.actions.isEmpty
                                    ? 8
                                    : (selectedTab.actions.length.clamp(4, 8) as int),
                              )
                            else
                              MobileDashboardQuickActions(
                                title: '${selectedTab.label} workspace',
                                actions: selectedTab.actions,
                                onActionTap: (action) =>
                                    _showToast('Opening ${action.label}'),
                                onViewAll: _openActions,
                              ),
                            const SizedBox(height: 24),
                            if (_loading)
                              MobileDashboardRecentOperationsSkeleton(
                                itemCount: selectedTab.operations.isEmpty
                                    ? 5
                                    : selectedTab.operations.length,
                              )
                            else
                              MobileDashboardRecentOperations(
                                title: _profile.operationsTitle,
                                subtitle:
                                    'Latest posted and in-process documents',
                                operations: selectedTab.operations,
                                currency: _currency,
                                amountFor: _operationAmount,
                                onViewAll: () => _showToast('Open register'),
                              ),
                            const SizedBox(height: 24),
                            if (_loading)
                              MobileDashboardAttentionSkeleton(
                                itemCount: _profile.attentionItems.isEmpty
                                    ? 3
                                    : _profile.attentionItems.length,
                              )
                            else
                              MobileDashboardAttentionList(
                                title: _profile.attentionTitle,
                                subtitle:
                                    'Control issues that require resolution',
                                items: _profile.attentionItems,
                                onItemTap: (item) => _showToast(item.label),
                                trailing: MobileDashboardPill(
                                  label:
                                      '${_profile.attentionItems.fold<int>(0, (sum, item) => sum + item.count)} open',
                                  color: context.mdColors.error,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                MobileDashboardBottomNavigation(
                  selectedId: 'home',
                  items: _navigationItems,
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
