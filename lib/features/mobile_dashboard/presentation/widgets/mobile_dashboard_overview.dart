import 'package:flutter/material.dart';

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

class MobileDashboardDomainTabs extends StatelessWidget {
  final List<MdTab> tabs;
  final String selectedTabId;
  final ValueChanged<String> onSelected;

  const MobileDashboardDomainTabs({
    required this.tabs,
    required this.selectedTabId,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: context.mdTheme.border)),
      ),
      child: Row(
        children: [
          for (final tab in tabs)
            Expanded(
              child: _DomainTab(
                tab: tab,
                selected: tab.id == selectedTabId,
                onTap: () => onSelected(tab.id),
              ),
            ),
        ],
      ),
    );
  }
}

class _DomainTab extends StatelessWidget {
  final MdTab tab;
  final bool selected;
  final VoidCallback onTap;

  const _DomainTab({
    required this.tab,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: tab.label,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          constraints: const BoxConstraints(minHeight: 44),
          padding: const EdgeInsets.fromLTRB(4, 10, 4, 12),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Center(
                child: Text(
                  tab.label,
                  style: TextStyle(
                    fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                    fontSize: 15,
                    fontWeight:
                        selected ? FontWeight.w700 : FontWeight.w500,
                    color: selected
                        ? context.mdTheme.fg1
                        : context.mdTheme.fg3,
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                height: 2.5,
                decoration: BoxDecoration(
                  color: context.mdColors.primary
                      .withValues(alpha: selected ? 1 : 0),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileDashboardControls extends StatelessWidget {
  final String view;
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
        MobileDashboardViewToggle(
          view: view,
          onTap: onToggleView,
        ),
        const SizedBox(width: 8),
        MobileDashboardCurrencyMenu(
          currency: currency,
          currencies: currencies,
          onChanged: onCurrencyChanged,
        ),
        const Spacer(),
        MobileDashboardPeriodSelector(
          period: period,
          onChanged: onPeriodChanged,
        ),
      ],
    );
  }
}

class MobileDashboardViewToggle extends StatelessWidget {
  final String view;
  final VoidCallback onTap;

  const MobileDashboardViewToggle({
    required this.view,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isChart = view == 'chart';
    return Semantics(
      button: true,
      label: isChart ? 'Show cards' : 'Show charts',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 34,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: context.mdTheme.inputBg,
            border: Border.all(color: context.mdTheme.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                MIcons.of(isChart ? 'poll' : 'grid'),
                size: 16,
                color: context.mdTheme.fg1,
              ),
              const SizedBox(width: 5),
              Text(
                isChart ? 'Charts' : 'Cards',
                style: TextStyle(
                  fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: context.mdTheme.fg1,
                ),
              ),
            ],
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
        height: 34,
        padding: const EdgeInsets.symmetric(horizontal: 11),
        decoration: BoxDecoration(
          color: context.mdTheme.inputBg,
          border: Border.all(color: context.mdTheme.borderStrong),
          borderRadius: BorderRadius.circular(8),
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
            const SizedBox(width: 4),
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
    this.periods = const ['day', 'week', 'month'],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'COMPARE',
          style: TextStyle(
            fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 10,
            letterSpacing: 0.8,
            color: context.mdTheme.fg3,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: context.mdTheme.inputBg,
            border: Border.all(color: context.mdTheme.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final item in periods)
                _PeriodOption(
                  period: item,
                  selected: item == period,
                  onTap: () => onChanged(item),
                ),
            ],
          ),
        ),
      ],
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
      'day' => 'Day',
      'week' => 'Week',
      'month' => 'Month',
      _ => period,
    };

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        constraints: const BoxConstraints(minHeight: 28),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 11),
        decoration: BoxDecoration(
          color: selected ? context.mdColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
            fontSize: 12,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected
                ? context.mdColors.onPrimary
                : context.mdTheme.fg3,
          ),
        ),
      ),
    );
  }
}
