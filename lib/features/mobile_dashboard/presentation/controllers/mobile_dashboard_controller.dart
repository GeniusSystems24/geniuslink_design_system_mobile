import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show IconData, Icons;

import '../../../../core/state/load_status.dart';

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

class MobileDashboardState {
  final String tab;
  final String cur;
  final String period;
  final ReportView view;
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
}

/// Page-scoped MVC controller for mobile-dashboard view selections and refresh.
class MobileDashboardController extends ChangeNotifier {
  int _refreshGeneration = 0;
  bool _disposed = false;
  MobileDashboardState _state;

  MobileDashboardController({String initialTab = 'banking'})
    : _state = MobileDashboardState(tab: initialTab);

  MobileDashboardState get state => _state;

  void selectTab(String tab) =>
      _replace(_state.copyWith(tab: tab, clearChartMetric: true));
  void setCurrency(String cur) => _replace(_state.copyWith(cur: cur));
  void setPeriod(String period) => _replace(_state.copyWith(period: period));
  void toggleView() => _replace(
    _state.copyWith(
      view:
          ReportView.values[(_state.view.index + 1) % ReportView.values.length],
    ),
  );
  void setChartMetric(String id) => _replace(_state.copyWith(chartMetric: id));

  Future<void> refresh() async {
    final generation = ++_refreshGeneration;
    _replace(_state.copyWith(status: LoadStatus.loading));
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (_disposed || generation != _refreshGeneration) return;
    _replace(_state.copyWith(status: LoadStatus.ready));
  }

  void _replace(MobileDashboardState next) {
    if (_disposed) return;
    _state = next;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _refreshGeneration++;
    super.dispose();
  }
}
