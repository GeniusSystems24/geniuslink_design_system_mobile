import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../design_system/kit.dart';
import '../../domain/domain.dart';
import 'mobile_dashboard_pressable.dart';
import 'mobile_dashboard_theme.dart';
import 'mobile_dashboard_trend_chart.dart';

typedef MobileDashboardCardValueResolver = double Function(MdCard card);

class MobileDashboardMetricGrid extends StatelessWidget {
  final List<MdCard> cards;
  final String currency;
  final String period;
  final MobileDashboardCardValueResolver valueFor;

  const MobileDashboardMetricGrid({
    required this.cards,
    required this.currency,
    required this.period,
    required this.valueFor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) {
      return const MobileDashboardChartEmptyState(
        message: 'No metrics are available for this dashboard.',
      );
    }

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.45,
      children: [
        for (final card in cards)
          MobileDashboardMetricCard(
            card: card,
            currency: currency,
            period: period,
            value: valueFor(card),
          ),
      ],
    );
  }
}

class MobileDashboardMetricCard extends StatelessWidget {
  final MdCard card;
  final String currency;
  final String period;
  final double value;

  const MobileDashboardMetricCard({
    required this.card,
    required this.currency,
    required this.period,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final trend = card.trends[period];
    final trendColor = trend == null
        ? context.mdTheme.fg4
        : trend.up
            ? context.mdColors.secondary
            : context.mdColors.error;

    return Semantics(
      label: '${card.label}, $currency ${mobileDashboardNumber(value)}',
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 14, 14, 14),
            decoration: BoxDecoration(
              color: context.mdTheme.surface,
              border: Border.all(color: context.mdTheme.border),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.label.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily:
                              context.mdTextTheme.bodyMedium?.fontFamily,
                          fontWeight: FontWeight.w700,
                          fontSize: 10.5,
                          letterSpacing: 0.5,
                          color: context.mdTheme.fg2,
                        ),
                      ),
                      const SizedBox(height: 9),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            currency,
                            style: TextStyle(
                              fontFamily: context
                                  .mdTextTheme.bodyMedium?.fontFamily,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: context.mdTheme.fg3,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              mobileDashboardNumber(value),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: context
                                    .mdTextTheme.bodyMedium?.fontFamily,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.8,
                                color: context.mdTheme.fg1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 9),
                      SizedBox(
                        height: 16,
                        child: trend == null
                            ? Text(
                                '—',
                                style: TextStyle(
                                  fontFamily: context
                                      .mdTextTheme.bodyMedium?.fontFamily,
                                  fontSize: 12,
                                  color: context.mdTheme.fg4,
                                ),
                              )
                            : Row(
                                children: [
                                  Text(
                                    trend.up ? '▲' : '▼',
                                    style: TextStyle(
                                      fontSize: 10,
                                      height: 1,
                                      color: trendColor,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '${mobileDashboardNumber(trend.pct, decimals: 1)}%',
                                    style: TextStyle(
                                      fontFamily: context
                                          .mdTextTheme.bodyMedium?.fontFamily,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: trendColor,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
          ),
          PositionedDirectional(
            start: 0,
            top: 14,
            bottom: 14,
            child: Container(
              width: 3,
              decoration: BoxDecoration(
                color: mobileDashboardMarkerColor(context, card.marker),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MobileDashboardChartView extends StatelessWidget {
  final List<MdCard> cards;
  final String tabLabel;
  final String currency;
  final String period;
  final String? selectedMetricId;
  final List<String> axisLabels;
  final MobileDashboardCardValueResolver valueFor;
  final ValueChanged<String> onMetricSelected;

  const MobileDashboardChartView({
    required this.cards,
    required this.tabLabel,
    required this.currency,
    required this.period,
    required this.selectedMetricId,
    required this.axisLabels,
    required this.valueFor,
    required this.onMetricSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) {
      return const MobileDashboardChartEmptyState(
        message: 'No metrics are available for this dashboard.',
      );
    }

    final selected = cards.firstWhere(
      (card) => card.id == selectedMetricId,
      orElse: () => cards.first,
    );
    final trend = selected.trends[period];
    final trendColor = trend == null
        ? context.mdTheme.fg4
        : trend.up
            ? context.mdColors.secondary
            : context.mdColors.error;
    final rawSeries = selected.series[period] ?? const <double>[];
    final currentValue = valueFor(selected);
    final chartValues = <double>[
      for (final point in rawSeries)
        if (point.isFinite && (point * currentValue).isFinite)
          point * currentValue,
    ];
    final cardValues = <double>[
      for (final card in cards)
        if (valueFor(card).isFinite && valueFor(card) >= 0) valueFor(card),
    ];
    final maxValue = cardValues.isEmpty ? 0.0 : cardValues.reduce(math.max);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: cards.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, index) {
              final card = cards[index];
              return MobileDashboardMetricSelector(
                card: card,
                selected: card.id == selected.id,
                onTap: () => onMetricSelected(card.id),
              );
            },
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.fromLTRB(14, 16, 14, 12),
          decoration: BoxDecoration(
            color: context.mdTheme.surface,
            border: Border.all(color: context.mdTheme.border),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${selected.label} · ${_periodLabel(period)} trend',
                          style: TextStyle(
                            fontFamily:
                                context.mdTextTheme.bodyMedium?.fontFamily,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: context.mdTheme.fg3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              currency,
                              style: TextStyle(
                                fontFamily: context
                                    .mdTextTheme.bodyMedium?.fontFamily,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: context.mdTheme.fg3,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                mobileDashboardNumber(currentValue),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: context
                                      .mdTextTheme.bodyMedium?.fontFamily,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.8,
                                  color: context.mdTheme.fg1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                    decoration: BoxDecoration(
                      color: superCoreTint(trendColor, 0x24),
                      border: Border.all(
                        color: trendColor.withValues(alpha: 0.28),
                      ),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      trend == null
                          ? 'No change'
                          : '${trend.up ? '▲' : '▼'} ${mobileDashboardNumber(trend.pct, decimals: 1)}%',
                      style: TextStyle(
                        fontFamily:
                            context.mdTextTheme.bodyMedium?.fontFamily,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: trendColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (chartValues.isEmpty)
                const MobileDashboardChartEmptyState(
                  message: 'No trend data is available for this period.',
                  compact: true,
                )
              else
                MobileDashboardTrendChart(
                  values: chartValues,
                  color:
                      mobileDashboardMarkerColor(context, selected.marker),
                  axisLabels: axisLabels,
                  currency: currency,
                  semanticsLabel:
                      '${selected.label} trend chart. Current value $currency ${mobileDashboardNumber(currentValue)}.',
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.mdTheme.surface,
            border: Border.all(color: context.mdTheme.border),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Breakdown',
                style: TextStyle(
                  fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 13.5,
                  color: context.mdTheme.fg1,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                'Relative value across ${tabLabel.toLowerCase()} metrics',
                style: TextStyle(
                  fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                  fontSize: 11,
                  color: context.mdTheme.fg3,
                ),
              ),
              const SizedBox(height: 15),
              for (final card in cards)
                MobileDashboardBreakdownBar(
                  card: card,
                  value: valueFor(card),
                  maxValue: maxValue,
                  currency: currency,
                ),
            ],
          ),
        ),
      ],
    );
  }

  String _periodLabel(String value) {
    if (value.isEmpty) {
      return value;
    }
    return '${value[0].toUpperCase()}${value.substring(1)}';
  }
}

class MobileDashboardMetricSelector extends StatelessWidget {
  final MdCard card;
  final bool selected;
  final VoidCallback onTap;

  const MobileDashboardMetricSelector({
    required this.card,
    required this.selected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final marker = mobileDashboardMarkerColor(context, card.marker);
    return Semantics(
      button: true,
      selected: selected,
      label: '${card.label} chart',
      child: MobileDashboardPressable(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: selected
                ? superCoreTint(marker, 0x24)
                : context.mdTheme.inputBg,
            border: Border.all(
              color: selected
                  ? marker.withValues(alpha: 0.55)
                  : context.mdTheme.border,
            ),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: marker,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 7),
              Text(
                card.label,
                style: TextStyle(
                  fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected ? marker : context.mdTheme.fg3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileDashboardChartEmptyState extends StatelessWidget {
  final String message;
  final bool compact;

  const MobileDashboardChartEmptyState({
    required this.message,
    this.compact = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: compact ? 150 : 190,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.mdTheme.inputBg,
        border: Border.all(color: context.mdTheme.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.show_chart_rounded,
            size: compact ? 24 : 30,
            color: context.mdTheme.fg4,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                fontSize: 12,
                color: context.mdTheme.fg3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MobileDashboardBreakdownBar extends StatelessWidget {
  final MdCard card;
  final double value;
  final double maxValue;
  final String currency;

  const MobileDashboardBreakdownBar({
    required this.card,
    required this.value,
    required this.maxValue,
    required this.currency,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final safeValue = value.isFinite ? math.max(0.0, value).toDouble() : 0.0;
    final ratio = maxValue <= 0
        ? 0.0
        : (safeValue / maxValue).clamp(0.0, 1.0).toDouble();
    final marker = mobileDashboardMarkerColor(context, card.marker);

    return Semantics(
      label:
          '${card.label}, $currency ${mobileDashboardNumber(safeValue)}, ${(ratio * 100).round()} percent of the largest metric',
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 7,
                  height: 7,
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: marker,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    card.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: context.mdTheme.fg2,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '$currency ${mobileDashboardNumber(safeValue)}',
                  style: TextStyle(
                    fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: context.mdTheme.fg1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: ratio),
              duration: const Duration(milliseconds: 520),
              curve: Curves.easeOutCubic,
              builder: (_, animatedValue, __) => ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  minHeight: 8,
                  value: animatedValue,
                  color: marker,
                  backgroundColor: context.mdTheme.inputBg,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
