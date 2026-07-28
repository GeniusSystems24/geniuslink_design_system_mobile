import 'package:flutter/material.dart';

import '../../../../design_system/kit.dart';
import '../../domain/domain.dart';
import 'mobile_dashboard_pressable.dart';
import 'mobile_dashboard_shared.dart';
import 'mobile_dashboard_theme.dart';

class MobileDashboardErpHero extends StatelessWidget {
  final MdDashboardProfile profile;
  final MdWorkspace workspace;
  final String currency;
  final VoidCallback onPrimaryAction;

  const MobileDashboardErpHero({
    required this.profile,
    required this.workspace,
    required this.currency,
    required this.onPrimaryAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.mdColors;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [
            colors.primaryContainer.withValues(alpha: 0.82),
            colors.surfaceContainerHighest.withValues(alpha: 0.58),
          ],
        ),
        border: Border.all(color: context.mdTheme.borderStrong),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  profile.eyebrow,
                  style: TextStyle(
                    fontFamily: context.mdTextTheme.labelLarge?.fontFamily,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.15,
                    color: colors.primary,
                  ),
                ),
              ),
              _LiveStatusChip(label: 'LIVE · $currency'),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            profile.title,
            style: TextStyle(
              fontFamily: context.mdTextTheme.headlineMedium?.fontFamily,
              fontSize: 27,
              height: 1.05,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.8,
              color: context.mdTheme.fg1,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            profile.subtitle,
            style: TextStyle(
              fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
              fontSize: 13,
              height: 1.45,
              color: context.mdTheme.fg2,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _ContextChip(icon: Icons.domain_outlined, label: workspace.name),
              const _ContextChip(
                icon: Icons.calendar_month_outlined,
                label: 'Current period',
              ),
              MobileDashboardPressable(
                onTap: onPrimaryAction,
                semanticLabel: profile.primaryActionLabel,
                child: Container(
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: colors.primary.withValues(alpha: 0.22),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add_rounded,
                        size: 18,
                        color: colors.onPrimary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        profile.primaryActionLabel,
                        style: TextStyle(
                          fontFamily:
                              context.mdTextTheme.labelLarge?.fontFamily,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: colors.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LiveStatusChip extends StatelessWidget {
  final String label;

  const _LiveStatusChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: context.mdColors.secondaryContainer.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: context.mdColors.secondary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontFamily: context.mdTextTheme.labelMedium?.fontFamily,
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.45,
              color: context.mdColors.onSecondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContextChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ContextChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      constraints: const BoxConstraints(maxWidth: 220),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: context.mdColors.surface.withValues(alpha: 0.72),
        border: Border.all(color: context.mdTheme.border),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: context.mdTheme.fg3),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: context.mdTextTheme.labelMedium?.fontFamily,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: context.mdTheme.fg2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MobileDashboardErpStatusStrip extends StatelessWidget {
  final String title;
  final List<MdStatusItem> items;
  final ValueChanged<MdStatusItem>? onItemTap;

  const MobileDashboardErpStatusStrip({
    required this.title,
    required this.items,
    this.onItemTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    var title2 = title;
    var marker = MdMarker.primary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SuperSectionTitle1(
          title: title2,
          subtitle: 'Operational health and control indicators',
          trailing: null,
          accentColor: mobileDashboardMarkerColor(context, marker),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 126,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final item = items[index];
              return _StatusCard(
                item: item,
                onTap: onItemTap == null ? null : () => onItemTap!(item),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _StatusCard extends StatelessWidget {
  final MdStatusItem item;
  final VoidCallback? onTap;

  const _StatusCard({required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final tone = mobileDashboardToneColor(context, item.tone);
    final child = Container(
      width: 198,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.mdTheme.surface,
        border: Border.all(color: context.mdTheme.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(color: tone, shape: BoxShape.circle),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: context.mdTextTheme.labelMedium?.fontFamily,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: context.mdTheme.fg3,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            item.value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: context.mdTextTheme.titleLarge?.fontFamily,
              fontSize: item.value.length > 8 ? 18 : 23,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.45,
              color: context.mdTheme.fg1,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            item.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: context.mdTextTheme.bodySmall?.fontFamily,
              fontSize: 10.5,
              color: context.mdTheme.fg3,
            ),
          ),
        ],
      ),
    );

    if (onTap == null) {
      return child;
    }
    return MobileDashboardPressable(
      onTap: onTap!,
      semanticLabel: '${item.label}: ${item.value}',
      child: child,
    );
  }
}

class MobileDashboardWorkflowPanel extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<MdWorkflowItem> items;
  final ValueChanged<MdWorkflowItem> onItemTap;

  const MobileDashboardWorkflowPanel({
    required this.title,
    required this.subtitle,
    required this.items,
    required this.onItemTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    var trailing = MobileDashboardPill(
      label: '${items.length} active',
      color: context.mdColors.tertiary,
    );
    var marker = MdMarker.warning;
    return SuperSectionCard2(
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      accentColor: mobileDashboardMarkerColor(context, marker),
      child: Column(
        children: [
          for (var index = 0; index < items.length; index++)
            _WorkflowRow(
              item: items[index],
              last: index == items.length - 1,
              onTap: () => onItemTap(items[index]),
            ),
        ],
      ),
    );
  }
}

class _WorkflowRow extends StatelessWidget {
  final MdWorkflowItem item;
  final bool last;
  final VoidCallback onTap;

  const _WorkflowRow({
    required this.item,
    required this.last,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tone = mobileDashboardToneColor(context, item.tone);
    return MobileDashboardPressable(
      onTap: onTap,
      semanticLabel: '${item.title}, ${item.value}',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          border: last
              ? null
              : Border(bottom: BorderSide(color: context.mdTheme.border)),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: tone.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(_workflowIcon(item.tone), size: 18, color: tone),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: context.mdTheme.fg1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: context.mdTextTheme.bodySmall?.fontFamily,
                      fontSize: 11,
                      color: context.mdTheme.fg3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MobileDashboardPill(label: item.value, color: tone),
                const SizedBox(height: 6),
                Icon(MIcons.of('chevR'), size: 14, color: context.mdTheme.fg4),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

IconData _workflowIcon(MdTone tone) => switch (tone) {
  MdTone.success => Icons.task_alt_rounded,
  MdTone.information => Icons.sync_alt_rounded,
  MdTone.warning => Icons.pending_actions_rounded,
  MdTone.danger => Icons.error_outline_rounded,
  MdTone.neutral => Icons.work_outline_rounded,
};
