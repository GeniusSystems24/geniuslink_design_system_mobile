// ============================================================
// MOBILE DASHBOARD / BLOC — MobileDashboardCubit
// ------------------------------------------------------------
// The mobile dashboard's view state: active domain tab, display
// currency, period, cards-vs-chart view, the selected chart
// metric, and the refresh LoadStatus. Tenant-scoped data (the
// active tenant + per-tenant currency factor) stays in TenantCubit
// and is mirrored into the screen; this cubit owns only the
// dashboard's own view selections.
//
// Ephemeral overlay state (workspace popup / drawer open, the
// offline toggle) remains local widget state — it is pure UI, not
// dashboard data.
//
// File placement:
//   lib/features/mobile_dashboard/presentation/bloc/mobile_dashboard_cubit.dart
// ============================================================

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show IconData, Icons;

import '../../../../core/bloc/load_status.dart';

enum ReportView {
  cards(title: 'Cards', tooltip: 'Show cards', icon: Icons.view_module),
  chart(title: 'Chart', tooltip: 'Show charts', icon: Icons.show_chart),
  breakdown(
    title: 'Breakdown',
    tooltip: 'Show breakdown',
    icon: Icons.pie_chart,
  );

  final String tooltip;
  final String title;
  final IconData icon;
  const ReportView({
    required this.tooltip,
    required this.title,
    required this.icon,
  });
}

class MobileDashboardState extends Equatable {
  final String tab;
  final String cur;
  final String period;
  final ReportView view; // 'cards' | 'chart' | "breakdown"
  final String? chartMetric;
  final LoadStatus status;

  const MobileDashboardState({
    this.tab = 'banking',
    this.cur = 'SAR',
    this.period = 'week',
    this.view = ReportView.cards,
    this.chartMetric,
    this.status = LoadStatus.ready,
  });

  MobileDashboardState copyWith({
    String? tab,
    String? cur,
    String? period,
    ReportView? view,
    String? chartMetric,
    bool clearChartMetric = false,
    LoadStatus? status,
  }) {
    return MobileDashboardState(
      tab: tab ?? this.tab,
      cur: cur ?? this.cur,
      period: period ?? this.period,
      view: view ?? this.view,
      chartMetric: clearChartMetric ? null : (chartMetric ?? this.chartMetric),
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [tab, cur, period, view, chartMetric, status];
}

class MobileDashboardCubit extends Cubit<MobileDashboardState> {
  int _refreshGeneration = 0;

  MobileDashboardCubit({String initialTab = 'banking'})
    : super(MobileDashboardState(tab: initialTab));

  void selectTab(String tab) =>
      emit(state.copyWith(tab: tab, clearChartMetric: true));
  void setCurrency(String cur) => emit(state.copyWith(cur: cur));
  void setPeriod(String period) => emit(state.copyWith(period: period));
  void toggleView() => emit(
    state.copyWith(
      view:
          ReportView.values[(state.view.index + 1) % ReportView.values.length],
    ),
  );
  void setChartMetric(String id) => emit(state.copyWith(chartMetric: id));

  /// Simulated pull-to-refresh. Replace the delay with a tenant-repo read.
  Future<void> refresh() async {
    final generation = ++_refreshGeneration;
    emit(state.copyWith(status: LoadStatus.loading));
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (isClosed || generation != _refreshGeneration) {
      return;
    }
    emit(state.copyWith(status: LoadStatus.ready));
  }
}
