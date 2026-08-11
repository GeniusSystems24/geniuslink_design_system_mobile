import 'package:equatable/equatable.dart';

enum DashboardKpiEmphasis { normal, positive }

enum DashboardAlertType { information, error, approval, success }

class DashboardKpi extends Equatable {
  final String label;
  final double amount;
  final double deltaPercent;
  final DashboardKpiEmphasis emphasis;

  const DashboardKpi({
    required this.label,
    required this.amount,
    required this.deltaPercent,
    this.emphasis = DashboardKpiEmphasis.normal,
  });

  bool get isPositive => deltaPercent >= 0;
  @override
  List<Object?> get props => [label, amount, deltaPercent, emphasis];
}

class CashFlowPoint extends Equatable {
  final String period;
  final double inflow;
  final double outflow;
  const CashFlowPoint({
    required this.period,
    required this.inflow,
    required this.outflow,
  });
  @override
  List<Object?> get props => [period, inflow, outflow];
}

class AccountBalanceSummary extends Equatable {
  final String code;
  final String name;
  final double amount;
  final int sharePercent;
  const AccountBalanceSummary({
    required this.code,
    required this.name,
    required this.amount,
    required this.sharePercent,
  });
  @override
  List<Object?> get props => [code, name, amount, sharePercent];
}

class RecentOperation extends Equatable {
  final String reference;
  final String description;
  final double amount;
  final String timeLabel;
  const RecentOperation({
    required this.reference,
    required this.description,
    required this.amount,
    required this.timeLabel,
  });
  bool get isCredit => amount >= 0;
  @override
  List<Object?> get props => [reference, description, amount, timeLabel];
}

class DashboardAlert extends Equatable {
  final DashboardAlertType type;
  final String title;
  final String description;
  const DashboardAlert({
    required this.type,
    required this.title,
    required this.description,
  });
  @override
  List<Object?> get props => [type, title, description];
}

class DashboardSnapshot extends Equatable {
  final String periodLabel;
  final List<DashboardKpi> kpis;
  final List<CashFlowPoint> cashFlow;
  final List<AccountBalanceSummary> balances;
  final List<RecentOperation> recentOperations;
  final List<DashboardAlert> alerts;

  const DashboardSnapshot({
    required this.periodLabel,
    this.kpis = const [],
    this.cashFlow = const [],
    this.balances = const [],
    this.recentOperations = const [],
    this.alerts = const [],
  });

  @override
  List<Object?> get props => [
    periodLabel,
    kpis,
    cashFlow,
    balances,
    recentOperations,
    alerts,
  ];
}
