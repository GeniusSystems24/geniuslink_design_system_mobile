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

import '../../../../core/bloc/load_status.dart';

class MobileDashboardState extends Equatable {
  final String tab;
  final String cur;
  final String period;
  final String view; // 'cards' | 'chart'
  final String? chartMetric;
  final LoadStatus status;

  const MobileDashboardState({
    this.tab = 'banking',
    this.cur = 'SAR',
    this.period = 'week',
    this.view = 'cards',
    this.chartMetric,
    this.status = LoadStatus.ready,
  });

  MobileDashboardState copyWith({
    String? tab,
    String? cur,
    String? period,
    String? view,
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
  MobileDashboardCubit() : super(const MobileDashboardState());

  void selectTab(String tab) =>
      emit(state.copyWith(tab: tab, clearChartMetric: true));
  void setCurrency(String cur) => emit(state.copyWith(cur: cur));
  void setPeriod(String period) => emit(state.copyWith(period: period));
  void toggleView() =>
      emit(state.copyWith(view: state.view == 'chart' ? 'cards' : 'chart'));
  void setChartMetric(String id) => emit(state.copyWith(chartMetric: id));

  /// Simulated pull-to-refresh. Replace the delay with a tenant-repo read.
  Future<void> refresh() async {
    emit(state.copyWith(status: LoadStatus.loading));
    await Future<void>.delayed(const Duration(milliseconds: 900));
    emit(state.copyWith(status: LoadStatus.ready));
  }
}
