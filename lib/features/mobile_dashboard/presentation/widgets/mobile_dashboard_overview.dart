import 'package:flutter/material.dart';
import 'package:gl_mobile_app/features/mobile_dashboard/presentation/controllers/mobile_dashboard_controller.dart';

import '../../../../design_system/kit.dart';
import '../../domain/domain.dart';
import 'mobile_dashboard_theme.dart';

class MobileDashboardTitle extends StatelessWidget {
  final String eyebrow;
  final String title;

  const MobileDashboardTitle({
    this.eyebrow = 'GOOD MORNING',
    this.title = 'Dashboard',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow,
          style: TextStyle(
            fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 11,
            letterSpacing: 1.3,
            color: context.mdColors.primary,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          title,
          style: TextStyle(
            fontFamily: context.mdTextTheme.headlineMedium?.fontFamily,
            fontWeight: FontWeight.w800,
            fontSize: 28,
            letterSpacing: -0.8,
            color: context.mdTheme.fg1,
          ),
        ),
      ],
    );
  }
}

class MobileDashboardControls extends StatelessWidget {
  final ReportView view;
  final String currency;
  final String period;
  final List<MdCurrency> currencies;
  final VoidCallback onToggleView;
  final ValueChanged<String> onCurrencyChanged;
  final ValueChanged<String> onPeriodChanged;

  const MobileDashboardControls({
    required this.view,
    required this.currency,
    required this.period,
    required this.currencies,
    required this.onToggleView,
    required this.onCurrencyChanged,
    required this.onPeriodChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MobileDashboardViewToggle(view: view, onTap: onToggleView),
        const SizedBox(width: 8),
        MobileDashboardCurrencyMenu(
          currency: currency,
          currencies: currencies,
          onChanged: onCurrencyChanged,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: MobileDashboardPeriodSelector(
            period: period,
            onChanged: onPeriodChanged,
          ),
        ),
      ],
    );
  }
}

class MobileDashboardViewToggle extends StatelessWidget {
  final ReportView view;
  final VoidCallback onTap;

  const MobileDashboardViewToggle({
    required this.view,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tooltip = view.tooltip;

    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        label: tooltip,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(9),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              width: 38,
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.mdTheme.inputBg,
                border: Border.all(color: context.mdTheme.borderStrong),
                borderRadius: BorderRadius.circular(9),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 160),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Icon(
                  view.icon,
                  key: ValueKey<ReportView>(view),
                  size: 18,
                  color: context.mdColors.primary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MobileDashboardCurrencyMenu extends StatelessWidget {
  final String currency;
  final List<MdCurrency> currencies;
  final ValueChanged<String> onChanged;

  const MobileDashboardCurrencyMenu({
    required this.currency,
    required this.currencies,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Display currency',
      color: context.mdTheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: context.mdTheme.borderStrong),
      ),
      onSelected: onChanged,
      itemBuilder: (_) => [
        for (final item in currencies)
          PopupMenuItem<String>(
            value: item.code,
            child: Row(
              children: [
                SizedBox(
                  width: 42,
                  child: Text(
                    item.code,
                    style: TextStyle(
                      fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: item.code == currency
                          ? context.mdColors.primary
                          : context.mdTheme.fg1,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    item.name,
                    style: TextStyle(
                      fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                      fontSize: 13,
                      color: context.mdTheme.fg2,
                    ),
                  ),
                ),
                if (item.code == currency)
                  Icon(
                    MIcons.of('check'),
                    size: 16,
                    color: context.mdColors.primary,
                  ),
              ],
            ),
          ),
      ],
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: context.mdTheme.inputBg,
          border: Border.all(color: context.mdTheme.borderStrong),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currency,
              style: TextStyle(
                fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: context.mdTheme.fg1,
              ),
            ),
            const SizedBox(width: 5),
            Icon(MIcons.of('chevD'), size: 14, color: context.mdTheme.fg3),
          ],
        ),
      ),
    );
  }
}

class MobileDashboardPeriodSelector extends StatelessWidget {
  final String period;
  final ValueChanged<String> onChanged;
  final List<String> periods;

  const MobileDashboardPeriodSelector({
    required this.period,
    required this.onChanged,
    this.periods = const ['week', 'month'],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final activePeriod = periods.contains(period) ? period : periods.first;

    return Container(
      height: 38,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: context.mdTheme.inputBg,
        border: Border.all(color: context.mdTheme.border),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          for (final item in periods)
            Expanded(
              child: _PeriodOption(
                period: item,
                selected: item == activePeriod,
                onTap: () => onChanged(item),
              ),
            ),
        ],
      ),
    );
  }
}

class _PeriodOption extends StatelessWidget {
  final String period;
  final bool selected;
  final VoidCallback onTap;

  const _PeriodOption({
    required this.period,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final label = switch (period) {
      'week' => 'Week',
      'month' => 'Month',
      _ => period,
    };

    return Semantics(
      button: true,
      selected: selected,
      label: '$label comparison period',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(7),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? context.mdColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(7),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: context.mdColors.primary.withValues(alpha: 0.18),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                fontSize: 12,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                color: selected
                    ? context.mdColors.onPrimary
                    : context.mdTheme.fg3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
