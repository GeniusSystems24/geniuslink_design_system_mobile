import '../../domain/domain.dart';

abstract final class MockDashboardDataSource {
  static const snapshot = DashboardSnapshot(
    periodLabel: 'Fiscal 2024 · as of Dec 19, 2025',
    kpis: [
      DashboardKpi(label: 'Total Assets', amount: 289050, deltaPercent: 4.2),
      DashboardKpi(label: 'Cash Position', amount: 235160, deltaPercent: 1.8),
      DashboardKpi(
        label: 'Revenue · MTD',
        amount: 89200,
        deltaPercent: 12.4,
        emphasis: DashboardKpiEmphasis.positive,
      ),
      DashboardKpi(
        label: 'Net Income · MTD',
        amount: 34120,
        deltaPercent: -2.1,
      ),
    ],
    cashFlow: [
      CashFlowPoint(period: 'Jan', inflow: 62, outflow: 48),
      CashFlowPoint(period: 'Feb', inflow: 71, outflow: 52),
      CashFlowPoint(period: 'Mar', inflow: 58, outflow: 61),
      CashFlowPoint(period: 'Apr', inflow: 80, outflow: 55),
      CashFlowPoint(period: 'May', inflow: 74, outflow: 58),
      CashFlowPoint(period: 'Jun', inflow: 92, outflow: 63),
      CashFlowPoint(period: 'Jul', inflow: 88, outflow: 70),
      CashFlowPoint(period: 'Aug', inflow: 79, outflow: 66),
      CashFlowPoint(period: 'Sep', inflow: 96, outflow: 72),
      CashFlowPoint(period: 'Oct', inflow: 104, outflow: 78),
      CashFlowPoint(period: 'Nov', inflow: 98, outflow: 81),
      CashFlowPoint(period: 'Dec', inflow: 112, outflow: 74),
    ],
    balances: [
      AccountBalanceSummary(
        code: '1100',
        name: 'Bank · NCB Main',
        amount: 186420,
        sharePercent: 64,
      ),
      AccountBalanceSummary(
        code: '1001',
        name: 'Cash Box',
        amount: 42500,
        sharePercent: 15,
      ),
      AccountBalanceSummary(
        code: '1200',
        name: 'Inventory (WIP)',
        amount: 54890,
        sharePercent: 19,
      ),
      AccountBalanceSummary(
        code: '1101',
        name: 'Bank · Al Rajhi',
        amount: 6240,
        sharePercent: 2,
      ),
    ],
    recentOperations: [
      RecentOperation(
        reference: 'JV-2024-0226',
        description: 'Mixed sale & revenue',
        amount: 3400,
        timeLabel: '10:14',
      ),
      RecentOperation(
        reference: 'EXT-2024-0311',
        description: 'Wire · Global Steel',
        amount: -12045,
        timeLabel: '11:02',
      ),
      RecentOperation(
        reference: 'DEP-2024-0182',
        description: 'Deposit · Customer 102',
        amount: 5000,
        timeLabel: '09:42',
      ),
      RecentOperation(
        reference: 'INV-ISS-0089',
        description: 'Issue · Project A-92',
        amount: -6600,
        timeLabel: '08:30',
      ),
    ],
    alerts: [
      DashboardAlert(
        type: DashboardAlertType.information,
        title: '1 entry out of balance',
        description: 'JV-2024-0225 · draft',
      ),
      DashboardAlert(
        type: DashboardAlertType.error,
        title: '2 SKUs out of stock',
        description: 'Downtown Central Store',
      ),
      DashboardAlert(
        type: DashboardAlertType.approval,
        title: '3 wires await approval',
        description: 'External transfers · 41,200 SAR',
      ),
      DashboardAlert(
        type: DashboardAlertType.success,
        title: 'Period Nov 2024 closed',
        description: 'Locked Dec 01',
      ),
    ],
  );
}
