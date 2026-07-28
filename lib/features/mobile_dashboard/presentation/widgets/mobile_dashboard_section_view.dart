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

  MobileDashboardCatalog get _catalog => widget.repository.catalog;
  String get _sectionId => widget.repository.sectionId;
  MdWorkspace get _workspace => widget.workspace;

  _DashboardViewData get _currentDashboard => _DashboardViewData(
    catalog: _catalog,
    sectionId: _sectionId,
    state: _dashboardCubit.state,
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
      final currentTab = _dashboardCubit.state.tab;
      final targetTab = _resolveDashboardTab(
        tabs: tabs,
        currentTab: currentTab,
        preferSectionTab: preferSectionTab,
      );

      if (currentTab != targetTab) {
        _dashboardCubit.selectTab(targetTab);
      }
    }

    final currencies = catalog.currencies;
    final currentCurrency = _dashboardCubit.state.cur;
    final currencyExists = currencies.any(
      (currency) => currency.code == currentCurrency,
    );
    if (currencies.isNotEmpty && !currencyExists) {
      _dashboardCubit.setCurrency(currencies.first.code);
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
          duration: _DashboardDurations.toast,
          shape: const StadiumBorder(),
          width: _DashboardLayout.toastWidth,
        ),
      );
  }

  Future<void> _refresh() => _dashboardCubit.refresh();

  void _openActions() {
    final dashboard = _currentDashboard;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: context.mdTheme.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: _DashboardLayout.sheetBorderRadius,
      ),
      builder: (sheetContext) => MobileDashboardActionsSheet(
        actions: dashboard.selectedTab.actions,
        onActionTap: (action) {
          Navigator.of(sheetContext).pop();
          _showDashboardToast(_DashboardCopy.openingAction(action.label));
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
        borderRadius: _DashboardLayout.sheetBorderRadius,
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
    _dashboardCubit = MobileDashboardCubit(initialTab: _sectionId);
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
    _dashboardCubit.close();
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
    return BlocProvider<MobileDashboardCubit>.value(
      value: _dashboardCubit,
      child: BlocBuilder<MobileDashboardCubit, MobileDashboardState>(
        builder: (context, state) {
          return _MobileDashboardSectionContent(
            dashboard: _DashboardViewData(
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
            onToggleView: _dashboardCubit.toggleView,
            onCurrencyChanged: _dashboardCubit.setCurrency,
            onPeriodChanged: _dashboardCubit.setPeriod,
            onMetricSelected: _dashboardCubit.setChartMetric,
          );
        },
      ),
    );
  }
}

typedef _DashboardToastCallback = void Function(String message);

class _MobileDashboardSectionContent extends StatelessWidget {
  final _DashboardViewData dashboard;
  final bool online;
  final ScrollController scrollController;
  final RefreshCallback onRefresh;
  final _DashboardToastCallback onToast;
  final VoidCallback onOpenActions;
  final VoidCallback onToggleView;
  final ValueChanged<String> onCurrencyChanged;
  final ValueChanged<String> onPeriodChanged;
  final ValueChanged<String> onMetricSelected;

  const _MobileDashboardSectionContent({
    required this.dashboard,
    required this.online,
    required this.scrollController,
    required this.onRefresh,
    required this.onToast,
    required this.onOpenActions,
    required this.onToggleView,
    required this.onCurrencyChanged,
    required this.onPeriodChanged,
    required this.onMetricSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!online) const MobileDashboardOfflineBanner(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: onRefresh,
            color: context.mdColors.primary,
            backgroundColor: context.mdTheme.surface,
            child: ListView(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: _DashboardLayout.scrollPadding,
              children: [
                _DashboardHeroSection(dashboard: dashboard, onToast: onToast),
                const SizedBox(height: _DashboardLayout.heroSectionGap),
                _DashboardStatusSection(dashboard: dashboard, onToast: onToast),
                const SizedBox(height: _DashboardLayout.sectionGap),
                _FinancialOverviewSection(
                  dashboard: dashboard,
                  onToggleView: onToggleView,
                  onCurrencyChanged: onCurrencyChanged,
                  onPeriodChanged: onPeriodChanged,
                  onMetricSelected: onMetricSelected,
                ),
                const SizedBox(height: _DashboardLayout.sectionGap),
                _DashboardWorkflowSection(
                  dashboard: dashboard,
                  onToast: onToast,
                ),
                const SizedBox(height: _DashboardLayout.sectionGap),
                _DashboardQuickActionsSection(
                  dashboard: dashboard,
                  onToast: onToast,
                  onViewAll: onOpenActions,
                ),
                const SizedBox(height: _DashboardLayout.sectionGap),
                _DashboardRecentOperationsSection(
                  dashboard: dashboard,
                  onToast: onToast,
                ),
                const SizedBox(height: _DashboardLayout.sectionGap),
                _DashboardAttentionSection(
                  dashboard: dashboard,
                  onToast: onToast,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DashboardHeroSection extends StatelessWidget {
  final _DashboardViewData dashboard;
  final _DashboardToastCallback onToast;

  const _DashboardHeroSection({required this.dashboard, required this.onToast});

  @override
  Widget build(BuildContext context) {
    if (dashboard.loading) {
      return const MobileDashboardErpHeroSkeleton();
    }

    return MobileDashboardErpHero(
      profile: dashboard.profile,
      workspace: dashboard.workspace,
      currency: dashboard.currency,
      onPrimaryAction: () => onToast(dashboard.profile.primaryActionLabel),
    );
  }
}

class _DashboardStatusSection extends StatelessWidget {
  final _DashboardViewData dashboard;
  final _DashboardToastCallback onToast;

  const _DashboardStatusSection({
    required this.dashboard,
    required this.onToast,
  });

  @override
  Widget build(BuildContext context) {
    if (dashboard.loading) {
      return MobileDashboardStatusStripSkeleton(
        itemCount: dashboard.statusSkeletonCount,
      );
    }

    return MobileDashboardErpStatusStrip(
      title: dashboard.profile.statusTitle,
      items: dashboard.profile.statusItems,
      onItemTap: (item) => onToast(item.label),
    );
  }
}

class _FinancialOverviewSection extends StatelessWidget {
  final _DashboardViewData dashboard;
  final VoidCallback onToggleView;
  final ValueChanged<String> onCurrencyChanged;
  final ValueChanged<String> onPeriodChanged;
  final ValueChanged<String> onMetricSelected;

  const _FinancialOverviewSection({
    required this.dashboard,
    required this.onToggleView,
    required this.onCurrencyChanged,
    required this.onPeriodChanged,
    required this.onMetricSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SuperSectionCard2(
      title: _DashboardCopy.financialOverviewTitle,
      subtitle: _DashboardCopy.financialOverviewSubtitle,
      trailing: null,
      accentColor: mobileDashboardMarkerColor(
        context,
        _DashboardDefaults.financialOverviewMarker,
      ),
      child: Column(
        children: [
          _DashboardControlsSection(
            dashboard: dashboard,
            onToggleView: onToggleView,
            onCurrencyChanged: onCurrencyChanged,
            onPeriodChanged: onPeriodChanged,
          ),
          const SizedBox(height: _DashboardLayout.controlsReportGap),
          _ReportViewSection(
            dashboard: dashboard,
            onMetricSelected: onMetricSelected,
          ),
        ],
      ),
    );
  }
}

class _DashboardControlsSection extends StatelessWidget {
  final _DashboardViewData dashboard;
  final VoidCallback onToggleView;
  final ValueChanged<String> onCurrencyChanged;
  final ValueChanged<String> onPeriodChanged;

  const _DashboardControlsSection({
    required this.dashboard,
    required this.onToggleView,
    required this.onCurrencyChanged,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (dashboard.loading) {
      return const MobileDashboardControlsSkeleton();
    }

    return MobileDashboardControls(
      view: dashboard.view,
      currency: dashboard.currency,
      period: dashboard.period,
      currencies: dashboard.catalog.currencies,
      onToggleView: onToggleView,
      onCurrencyChanged: onCurrencyChanged,
      onPeriodChanged: onPeriodChanged,
    );
  }
}

class _ReportViewSection extends StatelessWidget {
  final _DashboardViewData dashboard;
  final ValueChanged<String> onMetricSelected;

  const _ReportViewSection({
    required this.dashboard,
    required this.onMetricSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (dashboard.loading) {
      return switch (dashboard.view) {
        ReportView.cards => MobileDashboardMetricGridSkeleton(
          itemCount: dashboard.metricSkeletonCount,
        ),
        ReportView.chart => const MobileDashboardChartSkeleton(),
        ReportView.breakdown => const MobileDashboardBreakdownSkeleton(),
      };
    }

    return switch (dashboard.view) {
      ReportView.cards => MobileDashboardMetricGrid(
        cards: dashboard.selectedTab.cards,
        currency: dashboard.currency,
        period: dashboard.period,
        valueFor: dashboard.cardValue,
      ),
      ReportView.chart => MobileDashboardChartView(
        cards: dashboard.selectedTab.cards,
        currency: dashboard.currency,
        period: dashboard.period,
        selectedMetricId: dashboard.chartMetricId,
        axisLabels: dashboard.axisLabels,
        valueFor: dashboard.cardValue,
        onMetricSelected: onMetricSelected,
      ),
      ReportView.breakdown => MobileDashboardBreakdownView(
        cards: dashboard.selectedTab.cards,
        tabLabel: dashboard.selectedTab.label,
        currency: dashboard.currency,
        valueFor: dashboard.cardValue,
      ),
    };
  }
}

class _DashboardWorkflowSection extends StatelessWidget {
  final _DashboardViewData dashboard;
  final _DashboardToastCallback onToast;

  const _DashboardWorkflowSection({
    required this.dashboard,
    required this.onToast,
  });

  @override
  Widget build(BuildContext context) {
    if (dashboard.loading) {
      return MobileDashboardWorkflowSkeleton(
        itemCount: dashboard.workflowSkeletonCount,
      );
    }

    return MobileDashboardWorkflowPanel(
      title: dashboard.profile.workflowTitle,
      subtitle: dashboard.profile.workflowSubtitle,
      items: dashboard.profile.workflowItems,
      onItemTap: (item) => onToast(item.title),
    );
  }
}

class _DashboardQuickActionsSection extends StatelessWidget {
  final _DashboardViewData dashboard;
  final _DashboardToastCallback onToast;
  final VoidCallback onViewAll;

  const _DashboardQuickActionsSection({
    required this.dashboard,
    required this.onToast,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    if (dashboard.loading) {
      return MobileDashboardQuickActionsSkeleton(
        itemCount: dashboard.quickActionSkeletonCount,
      );
    }

    return MobileDashboardQuickActions(
      title: _DashboardCopy.workspaceTitle(dashboard.selectedTab.label),
      actions: dashboard.selectedTab.actions,
      onActionTap: (action) =>
          onToast(_DashboardCopy.openingAction(action.label)),
      onViewAll: onViewAll,
    );
  }
}

class _DashboardRecentOperationsSection extends StatelessWidget {
  final _DashboardViewData dashboard;
  final _DashboardToastCallback onToast;

  const _DashboardRecentOperationsSection({
    required this.dashboard,
    required this.onToast,
  });

  @override
  Widget build(BuildContext context) {
    if (dashboard.loading) {
      return MobileDashboardRecentOperationsSkeleton(
        itemCount: dashboard.recentOperationsSkeletonCount,
      );
    }

    return MobileDashboardRecentOperations(
      title: dashboard.profile.operationsTitle,
      subtitle: _DashboardCopy.recentOperationsSubtitle,
      operations: dashboard.selectedTab.operations,
      currency: dashboard.currency,
      amountFor: dashboard.operationAmount,
      onViewAll: () => onToast(_DashboardCopy.openRegister),
    );
  }
}

class _DashboardAttentionSection extends StatelessWidget {
  final _DashboardViewData dashboard;
  final _DashboardToastCallback onToast;

  const _DashboardAttentionSection({
    required this.dashboard,
    required this.onToast,
  });

  @override
  Widget build(BuildContext context) {
    if (dashboard.loading) {
      return MobileDashboardAttentionSkeleton(
        itemCount: dashboard.attentionSkeletonCount,
      );
    }

    return MobileDashboardAttentionList(
      title: dashboard.profile.attentionTitle,
      subtitle: _DashboardCopy.attentionSubtitle,
      items: dashboard.profile.attentionItems,
      onItemTap: (item) => onToast(item.label),
      trailing: MobileDashboardPill(
        label: _DashboardCopy.openItems(dashboard.openAttentionCount),
        color: context.mdColors.error,
      ),
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
          size: _DashboardLayout.toastIconSize,
          color: context.mdColors.onInverseSurface,
        ),
        const SizedBox(width: _DashboardLayout.toastIconGap),
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

class _DashboardViewData {
  final MobileDashboardCatalog catalog;
  final String sectionId;
  final MobileDashboardState state;
  final MdWorkspace workspace;

  const _DashboardViewData({
    required this.catalog,
    required this.sectionId,
    required this.state,
    required this.workspace,
  });

  String get currency => state.cur;
  String get period => state.period;
  ReportView get view => state.view;
  String? get chartMetricId => state.chartMetric;
  bool get loading => state.status.isLoading;

  MdTab get selectedTab {
    if (catalog.tabs.isEmpty) {
      return _DashboardDefaults.emptyTab;
    }

    return catalog.tabs.firstWhere(
      (tab) => tab.id == state.tab,
      orElse: () => catalog.tabs.first,
    );
  }

  MdDashboardProfile get profile {
    final tab = selectedTab;
    return catalog.profiles[sectionId] ??
        catalog.profiles[tab.id] ??
        _DashboardDefaults.emptyProfile(sectionId, tab.label);
  }

  List<String> get axisLabels => catalog.axisLabels[period] ?? const <String>[];

  int get statusSkeletonCount => _DashboardDefaults.skeletonCount(
    profile.statusItems.length,
    _DashboardDefaults.statusSkeletonCount,
  );

  int get metricSkeletonCount => _DashboardDefaults.skeletonCount(
    selectedTab.cards.length,
    _DashboardDefaults.metricSkeletonCount,
  );

  int get workflowSkeletonCount => _DashboardDefaults.skeletonCount(
    profile.workflowItems.length,
    _DashboardDefaults.workflowSkeletonCount,
  );

  int get quickActionSkeletonCount {
    final actionsCount = selectedTab.actions.length;
    if (actionsCount == 0) {
      return _DashboardDefaults.quickActionSkeletonCount;
    }

    return actionsCount
        .clamp(
          _DashboardDefaults.minQuickActionSkeletonCount,
          _DashboardDefaults.quickActionSkeletonCount,
        )
        .toInt();
  }

  int get recentOperationsSkeletonCount => _DashboardDefaults.skeletonCount(
    selectedTab.operations.length,
    _DashboardDefaults.recentOperationsSkeletonCount,
  );

  int get attentionSkeletonCount => _DashboardDefaults.skeletonCount(
    profile.attentionItems.length,
    _DashboardDefaults.attentionSkeletonCount,
  );

  int get openAttentionCount =>
      profile.attentionItems.fold<int>(0, (sum, item) => sum + item.count);

  double cardValue(MdCard card) => _scaledCurrencyValue(card.values[currency]);

  double operationAmount(MdOperation operation) {
    return _scaledCurrencyValue(operation.amounts[currency]);
  }

  double _scaledCurrencyValue(double? value) => (value ?? 0) * workspace.factor;
}

abstract final class _DashboardDefaults {
  static const financialOverviewMarker = MdMarker.positive;
  static const statusSkeletonCount = 3;
  static const metricSkeletonCount = 4;
  static const workflowSkeletonCount = 3;
  static const quickActionSkeletonCount = 8;
  static const minQuickActionSkeletonCount = 4;
  static const recentOperationsSkeletonCount = 5;
  static const attentionSkeletonCount = 3;
  static const emptyTab = MdTab(
    id: 'empty',
    label: 'Dashboard',
    cards: [],
    actions: [],
    operations: [],
  );

  static int skeletonCount(int itemCount, int fallbackCount) {
    return itemCount == 0 ? fallbackCount : itemCount;
  }

  static MdDashboardProfile emptyProfile(String sectionId, String title) {
    return MdDashboardProfile(
      sectionId: sectionId,
      eyebrow: _DashboardCopy.dashboardEyebrow,
      title: title,
      subtitle: '',
      primaryActionId: 'create',
      primaryActionLabel: _DashboardCopy.createAction,
      statusTitle: _DashboardCopy.statusTitle,
      workflowTitle: _DashboardCopy.workflowTitle,
      workflowSubtitle: '',
      operationsTitle: _DashboardCopy.operationsTitle,
      attentionTitle: _DashboardCopy.attentionTitle,
      statusItems: const [],
      workflowItems: const [],
      attentionItems: const [],
    );
  }
}

abstract final class _DashboardLayout {
  static const scrollPadding = EdgeInsets.fromLTRB(18, 16, 18, 32);
  static const sheetBorderRadius = BorderRadius.vertical(
    top: Radius.circular(22),
  );
  static const heroSectionGap = 22.0;
  static const sectionGap = 24.0;
  static const controlsReportGap = 12.0;
  static const toastIconSize = 15.0;
  static const toastIconGap = 8.0;
  static const toastWidth = 280.0;
}

abstract final class _DashboardDurations {
  static const toast = Duration(milliseconds: 1600);
}

abstract final class _DashboardCopy {
  static const dashboardEyebrow = 'Dashboard';
  static const createAction = 'Create';
  static const statusTitle = 'Status';
  static const workflowTitle = 'Workflow';
  static const operationsTitle = 'Operations';
  static const attentionTitle = 'Attention';
  static const financialOverviewTitle = 'Financial overview';
  static const financialOverviewSubtitle =
      'Consolidated values, movement, and period comparison';
  static const recentOperationsSubtitle =
      'Latest posted and in-process documents';
  static const attentionSubtitle = 'Control issues that require resolution';
  static const openRegister = 'Open register';

  static String openingAction(String label) => 'Opening $label';
  static String workspaceTitle(String tabLabel) => '$tabLabel workspace';
  static String openItems(int count) => '$count open';
}
