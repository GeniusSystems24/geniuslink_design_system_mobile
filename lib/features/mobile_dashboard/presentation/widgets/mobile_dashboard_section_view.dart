import 'dart:async' show unawaited;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gl_mobile_app/features/mobile_dashboard/presentation/widgets/mobile_dashboard_offline_banner.dart';
import 'package:super_core/super_core.dart';

import '../../../../core/bloc/load_status.dart';
import '../../domain/domain.dart';
import '../bloc/mobile_dashboard_cubit.dart';
import 'mobile_dashboard_attention.dart';
import 'mobile_dashboard_erp_overview.dart';
import 'mobile_dashboard_metrics.dart';
import 'mobile_dashboard_overview.dart';
import 'mobile_dashboard_quick_actions.dart';
import 'mobile_dashboard_recent_operations.dart';
import 'mobile_dashboard_search_sheet.dart';
import 'mobile_dashboard_skeleton.dart';
import 'mobile_dashboard_shared.dart';
import 'mobile_dashboard_theme.dart';

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
  late final MobileDashboardCubit _dashboardCubit;
  final ScrollController _scrollController = ScrollController();

  MobileDashboardState get _dashboardState => _dashboardCubit.state;
  String get _tabId => _dashboardState.tab;
  String get _currency => _dashboardState.cur;
  String get _period => _dashboardState.period;
  String get _view => _dashboardState.view;
  String? get _chartMetricId => _dashboardState.chartMetric;
  bool get _loading => _dashboardState.status.isLoading;
  MobileDashboardCatalog get _catalog => widget.repository.catalog;
  String get _sectionId => widget.repository.sectionId;
  MdWorkspace get _workspace => widget.workspace;

  MdTab get _selectedTab {
    if (_catalog.tabs.isEmpty) {
      return const MdTab(
        id: 'empty',
        label: 'Dashboard',
        cards: [],
        actions: [],
        operations: [],
      );
    }
    return _catalog.tabs.firstWhere(
      (tab) => tab.id == _tabId,
      orElse: () => _catalog.tabs.first,
    );
  }

  MdDashboardProfile get _profile => _catalog.profiles[_sectionId]!;

  @override
  void initState() {
    super.initState();
    _dashboardCubit = MobileDashboardCubit(initialTab: _sectionId);

    if (_catalog.tabs.isNotEmpty &&
        !_catalog.tabs.any((tab) => tab.id == _sectionId)) {
      _dashboardCubit.selectTab(_catalog.tabs.first.id);
    }
    if (_catalog.currencies.isNotEmpty &&
        !_catalog.currencies.any(
          (currency) => currency.code == _dashboardCubit.state.cur,
        )) {
      _dashboardCubit.setCurrency(_catalog.currencies.first.code);
    }
    unawaited(_dashboardCubit.refresh());
  }

  @override
  void didUpdateWidget(covariant MobileDashboardSectionView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.repository.sectionId != _sectionId &&
        _catalog.tabs.any((tab) => tab.id == _sectionId)) {
      _dashboardCubit.selectTab(_sectionId);
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

  Future<void> refresh() => _refresh();

  void scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
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

  void openSearch() => _openSearch();

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
        tabs: _catalog.tabs,
        onOperationTap: (operation) {
          Navigator.of(context).pop();
          _showToast(operation.reference);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MobileDashboardCubit>.value(
      value: _dashboardCubit,
      child: BlocBuilder<MobileDashboardCubit, MobileDashboardState>(
        builder: (context, _) {
          final selectedTab = _selectedTab;
          final marker = MdMarker.positive;

          return Column(
            children: [
              if (!widget.online) const MobileDashboardOfflineBanner(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  color: context.mdColors.primary,
                  backgroundColor: context.mdTheme.surface,
                  child: ListView(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(18, 16, 18, 32),
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
                      else ...[
                        SuperSectionTitle1(
                          title: 'Financial overview',
                          subtitle:
                              'Consolidated values, movement, and period comparison',
                          trailing: null,
                          accentColor: mobileDashboardMarkerColor(
                            context,
                            marker,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                      if (_loading)
                        const MobileDashboardControlsSkeleton()
                      else
                        MobileDashboardControls(
                          view: _view,
                          currency: _currency,
                          period: _period,
                          currencies: _catalog.currencies,
                          onToggleView: _dashboardCubit.toggleView,
                          onCurrencyChanged: _dashboardCubit.setCurrency,
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
                          axisLabels:
                              _catalog.axisLabels[_period] ?? const <String>[],
                          valueFor: _cardValue,
                          onMetricSelected: _dashboardCubit.setChartMetric,
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
                              : selectedTab.actions.length.clamp(4, 8),
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
                          subtitle: 'Latest posted and in-process documents',
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
                          subtitle: 'Control issues that require resolution',
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
          );
        },
      ),
    );
  }
}
