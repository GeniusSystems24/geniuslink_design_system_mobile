// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
// ============================================================
// VIEW — Dashboard tab
// KPI row · cash-flow bars · balances · recent ops · alerts
// ============================================================

import 'package:flutter/material.dart';
import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/features/dashboard/domain/entities/dashboard_snapshot.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

// ── DashboardView ─────────────────────────────────────────
/// Renders the presentation for [DashboardScreen].
///
/// This widget contains the screen's existing layout and presentation
/// state while the corresponding `*Screen` file remains a small public
/// navigation/compatibility boundary. Business and data-layer behavior
/// is intentionally not introduced by this refactor.
///
/// Example:
///
/// ```dart
/// DashboardView(
///   snapshot: snapshot,
/// )
/// ```
class DashboardView extends StatelessWidget {
  final DashboardSnapshot snapshot;

  const DashboardView({required this.snapshot, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(
        title: Text(GeniusLinkLocalization.of(context).dashboard),
        actions: const [AppLanguageToggleButton(), AppThemeToggleButton()],
      ),
      body: _buildDashboardContent(context),
    );
  }

  Widget _buildDashboardContent(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var trailing = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Legend(
          color: SuperMaterialThemeData.of(context).colorScheme.primary,
          label: GeniusLinkLocalization.of(context).inflowShort,
        ),
        const SizedBox(width: 12),
        _Legend(
          color: SuperMaterialThemeData.of(context).superTheme.fg4,
          label: GeniusLinkLocalization.of(context).outflowShort,
        ),
      ],
    );
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor4 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    return MScroll([
      Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Text(
          snapshot.periodLabel,
          style: TextStyle(
            fontFamily: SuperMaterialThemeData.of(
              context,
            ).textTheme.bodyMedium?.fontFamily,
            fontSize: 11.5,
            color: SuperMaterialThemeData.of(context).superTheme.fg3,
          ),
        ),
      ),
      // KPI grid
      SuperGrid(
        scope: SuperGridScope.current,
        gutter: 12,
        rowSpacing: 12,
        children: [
          for (final kpi in snapshot.kpis)
            SuperGridCell(
              mobile: 4,
              tablet: 4,
              desktop: 6,
              large: 6,
              child: AspectRatio(aspectRatio: 1.55, child: _Kpi(kpi: kpi)),
            ),
        ],
      ),
      // Cash flow
      SuperSectionCard2(
        trailing: trailing,
        title: GeniusLinkLocalization.of(context).cashFlow,
        subtitle: GeniusLinkLocalization.of(
          context,
        ).inflowVsOutflowSarThousands12Months,
        initiallyExpanded: true,
        accentColor: accentColor3,

        padding: EdgeInsets.all(16),
        child: SuperGrid(
          scope: SuperGridScope.current,
          children: [
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: _CashFlowBars(points: snapshot.cashFlow),
            ),
          ],
        ),
      ),
      // Balances
      SuperSectionCard2(
        title: GeniusLinkLocalization.of(context).cashAssetAccounts,
        subtitle: GeniusLinkLocalization.of(context).topBalances,
        initiallyExpanded: true,
        accentColor: accentColor2,

        padding: EdgeInsets.all(16),
        child: SuperGrid(
          scope: SuperGridScope.current,
          children: [
            for (final balance in snapshot.balances)
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 6,
                large: 6,
                child: _BalanceRow(balance: balance),
              ),
          ],
        ),
      ),
      // Recent ops
      SuperSectionCard2(
        title: GeniusLinkLocalization.of(context).recentOperations,

        initiallyExpanded: true,
        accentColor: accentColor4,

        padding: EdgeInsets.all(8),
        child: SuperGrid(
          scope: SuperGridScope.current,
          children: [
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    for (int i = 0; i < snapshot.recentOperations.length; i++)
                      _RecentRow(
                        operation: snapshot.recentOperations[i],
                        last: i == snapshot.recentOperations.length - 1,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Alerts
      SuperSectionCard2(
        title: GeniusLinkLocalization.of(context).needsAttention,

        initiallyExpanded: true,
        accentColor: accentColor,

        padding: EdgeInsets.all(16),
        child: SuperGrid(
          scope: SuperGridScope.current,
          children: [
            for (final alert in snapshot.alerts)
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 6,
                large: 6,
                child: _AlertRow(alert: alert),
              ),
          ],
        ),
      ),
    ]);
  }
}

// ── Presentational widgets ───────────────────────────────────
class _Kpi extends StatelessWidget {
  final DashboardKpi kpi;
  const _Kpi({required this.kpi});

  @override
  Widget build(BuildContext context) {
    final accent = kpi.emphasis == DashboardKpiEmphasis.positive
        ? SuperMaterialThemeData.of(context).colorScheme.secondary
        : SuperMaterialThemeData.of(context).superTheme.fg1;
    final delta =
        '${kpi.isPositive ? '+' : '−'}${kpi.deltaPercent.abs().toStringAsFixed(1)}%';
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: SuperMaterialThemeData.of(context).superTheme.surface,
        border: Border.all(
          color: SuperMaterialThemeData.of(context).superTheme.border,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Eyebrow(
            kpi.label,
            color: SuperMaterialThemeData.of(context).superTheme.fg3,
            size: 9.5,
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                _formatDashboardAmount(kpi.amount),
                style: TextStyle(
                  fontFamily: SuperMaterialThemeData.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                  color: accent,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                'SAR',
                style: TextStyle(
                  fontFamily: SuperMaterialThemeData.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                  fontSize: 10,
                  color: SuperMaterialThemeData.of(context).superTheme.fg3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${kpi.isPositive ? '▲' : '▼'} $delta',
            style: TextStyle(
              fontFamily: SuperMaterialThemeData.of(
                context,
              ).textTheme.bodyMedium?.fontFamily,
              fontSize: 11,
              color: kpi.isPositive
                  ? SuperMaterialThemeData.of(context).colorScheme.secondary
                  : SuperMaterialThemeData.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}

String _formatDashboardAmount(double amount, {bool signed = false}) {
  final rounded = amount.abs().round().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < rounded.length; i++) {
    if (i > 0 && (rounded.length - i) % 3 == 0) buffer.write(',');
    buffer.write(rounded[i]);
  }
  final sign = signed ? (amount >= 0 ? '+' : '−') : (amount < 0 ? '−' : '');
  return '$sign$buffer';
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  const _Legend({required this.color, required this.label});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 9,
        height: 9,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      const SizedBox(width: 5),
      Text(
        label,
        style: TextStyle(
          fontSize: 10.5,
          color: SuperMaterialThemeData.of(context).superTheme.fg3,
          fontWeight: FontWeight.w600,
          fontFamily: SuperMaterialThemeData.of(
            context,
          ).textTheme.bodyMedium?.fontFamily,
        ),
      ),
    ],
  );
}

class _CashFlowBars extends StatelessWidget {
  final List<CashFlowPoint> points;
  const _CashFlowBars({required this.points});
  @override
  Widget build(BuildContext context) {
    final maxV = points.isEmpty
        ? 1.0
        : points
              .expand((point) => [point.inflow, point.outflow])
              .reduce((a, b) => a > b ? a : b);
    return SizedBox(
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final point in points)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _bar(
                            point.inflow / maxV,
                            SuperMaterialThemeData.of(
                              context,
                            ).colorScheme.primary,
                          ),
                          const SizedBox(width: 2),
                          _bar(
                            point.outflow / maxV,
                            SuperMaterialThemeData.of(context).superTheme.fg4,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      point.period,
                      style: TextStyle(
                        fontFamily: SuperMaterialThemeData.of(
                          context,
                        ).textTheme.bodyMedium?.fontFamily,
                        fontSize: 8.5,
                        color: SuperMaterialThemeData.of(
                          context,
                        ).superTheme.fg3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _bar(double frac, Color c) => Expanded(
    child: FractionallySizedBox(
      heightFactor: frac.clamp(0.0, 1.0),
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: c,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
        ),
      ),
    ),
  );
}

class _BalanceRow extends StatelessWidget {
  final AccountBalanceSummary balance;
  const _BalanceRow({required this.balance});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${balance.code}  ',
                      style: TextStyle(
                        fontFamily: SuperMaterialThemeData.of(
                          context,
                        ).textTheme.bodyMedium?.fontFamily,
                        color: SuperMaterialThemeData.of(
                          context,
                        ).superTheme.fg3,
                      ),
                    ),
                    TextSpan(text: balance.name),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.5,
                  color: SuperMaterialThemeData.of(context).superTheme.fg1,
                  fontFamily: SuperMaterialThemeData.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              _formatDashboardAmount(balance.amount),
              style: TextStyle(
                fontFamily: SuperMaterialThemeData.of(
                  context,
                ).textTheme.bodyMedium?.fontFamily,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: SuperMaterialThemeData.of(context).superTheme.fg1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: Stack(
            children: [
              Container(
                height: 6,
                color: SuperMaterialThemeData.of(context).superTheme.inputBg,
              ),
              FractionallySizedBox(
                widthFactor: balance.sharePercent / 100,
                child: Container(
                  height: 6,
                  color: SuperMaterialThemeData.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RecentRow extends StatelessWidget {
  final RecentOperation operation;
  final bool last;
  const _RecentRow({required this.operation, required this.last});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: last
            ? null
            : Border(
                bottom: BorderSide(
                  color: SuperMaterialThemeData.of(context).superTheme.border,
                ),
              ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  operation.reference,
                  style: TextStyle(
                    fontFamily: SuperMaterialThemeData.of(
                      context,
                    ).textTheme.bodyMedium?.fontFamily,
                    fontSize: 12,
                    color: SuperMaterialThemeData.of(
                      context,
                    ).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  operation.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: SuperMaterialThemeData.of(context).superTheme.fg3,
                    fontFamily: SuperMaterialThemeData.of(
                      context,
                    ).textTheme.bodyMedium?.fontFamily,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatDashboardAmount(operation.amount, signed: true),
                style: TextStyle(
                  fontFamily: SuperMaterialThemeData.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: operation.isCredit
                      ? SuperMaterialThemeData.of(context).colorScheme.secondary
                      : SuperMaterialThemeData.of(context).colorScheme.error,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                operation.timeLabel,
                style: TextStyle(
                  fontFamily: SuperMaterialThemeData.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                  fontSize: 10.5,
                  color: SuperMaterialThemeData.of(context).superTheme.fg3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AlertRow extends StatelessWidget {
  final DashboardAlert alert;
  const _AlertRow({required this.alert});

  @override
  Widget build(BuildContext context) {
    final colors = SuperMaterialThemeData.of(context).colorScheme;
    final (tone, icon) = switch (alert.type) {
      DashboardAlertType.information => (colors.tertiary, 'info'),
      DashboardAlertType.error => (colors.error, 'info'),
      DashboardAlertType.approval => (colors.primary, 'lock'),
      DashboardAlertType.success => (colors.secondary, 'check'),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      decoration: BoxDecoration(
        color: superCoreTint(tone, 0x14),
        border: Border.all(color: superCoreTint(tone, 0x40)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(MIcons.of(icon), size: 15, color: tone),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert.title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: SuperMaterialThemeData.of(context).superTheme.fg1,
                    fontFamily: SuperMaterialThemeData.of(
                      context,
                    ).textTheme.bodyMedium?.fontFamily,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  alert.description,
                  style: TextStyle(
                    fontSize: 11,
                    color: SuperMaterialThemeData.of(context).superTheme.fg3,
                    fontFamily: SuperMaterialThemeData.of(
                      context,
                    ).textTheme.bodyMedium?.fontFamily,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
