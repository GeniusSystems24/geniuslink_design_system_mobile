// MOBILE_DASHBOARD_COMPONENTIZATION_V3
import 'package:flutter/material.dart';

import 'mobile_dashboard_theme.dart';
import '../../../../design_system/kit.dart';

/// Animated ERP loading placeholder whose colors are derived from the active
/// `super_core` theme.
///
/// Each placeholder owns a short-lived animation only while it is mounted. The
/// dashboard mounts these widgets exclusively for loading states, so normal
/// content does not retain animation controllers or repaint work.
class MobileDashboardSkeleton extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadiusGeometry borderRadius;
  final Duration duration;

  const MobileDashboardSkeleton({
    required this.width,
    required this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.duration = const Duration(milliseconds: 1250),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = context.mdTheme.inputBg;
    final highlightColor = Color.alphaBlend(
      context.mdColors.onSurface.withValues(
        alpha: context.mdMaterialTheme.brightness == Brightness.dark
            ? 0.12
            : 0.07,
      ),
      baseColor,
    );

    return AnimatedSkeletonBox(
      width: width,
      height: height,
      borderRadius: borderRadius,
      theme: AnimatedSkeletonBoxThemeData(
        baseColor: baseColor,
        highlightColor: highlightColor,
        duration: duration,
      ),
    );
  }
}

/// Loading state for the ERP hero at the top of every dashboard.
class MobileDashboardErpHeroSkeleton extends StatelessWidget {
  const MobileDashboardErpHeroSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.mdTheme.surface,
        border: Border.all(color: context.mdTheme.borderStrong),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MobileDashboardSkeleton(width: 108, height: 10),
              Spacer(),
              MobileDashboardSkeleton(
                width: 74,
                height: 24,
                borderRadius: BorderRadius.all(Radius.circular(999)),
              ),
            ],
          ),
          SizedBox(height: 16),
          MobileDashboardSkeleton(width: 244, height: 27),
          SizedBox(height: 10),
          MobileDashboardSkeleton(width: double.infinity, height: 12),
          SizedBox(height: 7),
          MobileDashboardSkeleton(width: 236, height: 12),
          SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: MobileDashboardSkeleton(
                  width: double.infinity,
                  height: 34,
                ),
              ),
              SizedBox(width: 8),
              MobileDashboardSkeleton(width: 114, height: 34),
            ],
          ),
        ],
      ),
    );
  }
}

/// Loading state for the horizontal operational status strip.
class MobileDashboardStatusStripSkeleton extends StatelessWidget {
  final int itemCount;

  const MobileDashboardStatusStripSkeleton({this.itemCount = 3, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const MobileDashboardSectionTitleSkeleton(),
        SizedBox(
          height: 126,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (_, _) => Container(
              width: 198,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: context.mdTheme.surface,
                border: Border.all(color: context.mdTheme.border),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MobileDashboardSkeleton(width: 112, height: 10),
                  Spacer(),
                  MobileDashboardSkeleton(width: 92, height: 23),
                  SizedBox(height: 7),
                  MobileDashboardSkeleton(width: 142, height: 10),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Loading state for the compact one-row chart controls.
class MobileDashboardControlsSkeleton extends StatelessWidget {
  const MobileDashboardControlsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.mdTheme.surface,
        border: Border.all(color: context.mdTheme.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          MobileDashboardSkeleton(width: 38, height: 38),
          SizedBox(width: 8),
          MobileDashboardSkeleton(width: 74, height: 38),
          SizedBox(width: 8),
          Expanded(
            child: MobileDashboardSkeleton(width: double.infinity, height: 38),
          ),
        ],
      ),
    );
  }
}

/// Loading state for one ERP metric card.
class MobileDashboardMetricCardSkeleton extends StatelessWidget {
  const MobileDashboardMetricCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 14, 14, 14),
      decoration: BoxDecoration(
        color: context.mdTheme.surface,
        border: Border.all(color: context.mdTheme.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MobileDashboardSkeleton(width: 80, height: 9),
          SizedBox(height: 12),
          MobileDashboardSkeleton(width: 110, height: 20),
          SizedBox(height: 12),
          MobileDashboardSkeleton(width: 60, height: 9),
        ],
      ),
    );
  }
}

/// Loading state for the two-column ERP metric grid.
class MobileDashboardMetricGridSkeleton extends StatelessWidget {
  final int itemCount;

  const MobileDashboardMetricGridSkeleton({this.itemCount = 4, super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveSlotGrid(
      minItemWidth: 145,
      maxColumns: 2,
      runSpacing: 12,
      spacing: 12,
      childAspectRatio: 1.45,
      children: [
        for (var index = 0; index < itemCount; index++)
          const MobileDashboardMetricCardSkeleton(),
      ],
    );
  }
}

/// Loading state for the chart view, including metric chips.
class MobileDashboardChartSkeleton extends StatelessWidget {
  const MobileDashboardChartSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Row(
          children: [
            MobileDashboardSkeleton(
              width: 92,
              height: 36,
              borderRadius: BorderRadius.all(Radius.circular(999)),
            ),
            SizedBox(width: 8),
            MobileDashboardSkeleton(
              width: 108,
              height: 36,
              borderRadius: BorderRadius.all(Radius.circular(999)),
            ),
            SizedBox(width: 8),
            Expanded(
              child: MobileDashboardSkeleton(
                width: double.infinity,
                height: 36,
                borderRadius: BorderRadius.all(Radius.circular(999)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.fromLTRB(14, 16, 14, 12),
          decoration: BoxDecoration(
            color: context.mdTheme.surface,
            border: Border.all(color: context.mdTheme.border),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MobileDashboardSkeleton(width: 146, height: 10),
              SizedBox(height: 8),
              MobileDashboardSkeleton(width: 128, height: 23),
              SizedBox(height: 18),
              MobileDashboardSkeleton(width: double.infinity, height: 176),
            ],
          ),
        ),
      ],
    );
  }
}

/// Loading state for the metric breakdown view.
class MobileDashboardBreakdownSkeleton extends StatelessWidget {
  const MobileDashboardBreakdownSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.mdTheme.surface,
        border: Border.all(color: context.mdTheme.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MobileDashboardSkeleton(width: 88, height: 13),
          SizedBox(height: 8),
          MobileDashboardSkeleton(width: 208, height: 10),
          SizedBox(height: 18),
          MobileDashboardSkeleton(width: double.infinity, height: 9),
          SizedBox(height: 14),
          MobileDashboardSkeleton(width: double.infinity, height: 9),
          SizedBox(height: 14),
          MobileDashboardSkeleton(width: double.infinity, height: 9),
        ],
      ),
    );
  }
}

/// Loading state for workflow and exception list containers.
class MobileDashboardListSectionSkeleton extends StatelessWidget {
  final int itemCount;
  final bool showLeading;

  const MobileDashboardListSectionSkeleton({
    this.itemCount = 3,
    this.showLeading = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const MobileDashboardSectionTitleSkeleton(showTrailing: true),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: context.mdTheme.surface,
            border: Border.all(color: context.mdTheme.border),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              for (var index = 0; index < itemCount; index++)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(
                    border: index == itemCount - 1
                        ? null
                        : Border(
                            bottom: BorderSide(color: context.mdTheme.border),
                          ),
                  ),
                  child: Row(
                    children: [
                      if (showLeading) ...[
                        const MobileDashboardSkeleton(width: 38, height: 38),
                        const SizedBox(width: 12),
                      ],
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MobileDashboardSkeleton(
                              width: double.infinity,
                              height: 12,
                            ),
                            SizedBox(height: 8),
                            MobileDashboardSkeleton(width: 176, height: 10),
                          ],
                        ),
                      ),
                      const SizedBox(width: 14),
                      const MobileDashboardSkeleton(
                        width: 48,
                        height: 22,
                        borderRadius: BorderRadius.all(Radius.circular(999)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Loading state for the ERP workflow section.
class MobileDashboardWorkflowSkeleton extends StatelessWidget {
  final int itemCount;

  const MobileDashboardWorkflowSkeleton({this.itemCount = 3, super.key});

  @override
  Widget build(BuildContext context) {
    return MobileDashboardListSectionSkeleton(itemCount: itemCount);
  }
}

/// Loading state for ERP exceptions and attention items.
class MobileDashboardAttentionSkeleton extends StatelessWidget {
  final int itemCount;

  const MobileDashboardAttentionSkeleton({this.itemCount = 3, super.key});

  @override
  Widget build(BuildContext context) {
    return MobileDashboardListSectionSkeleton(itemCount: itemCount);
  }
}

/// Loading state for recent posted and in-process documents.
class MobileDashboardRecentOperationsSkeleton extends StatelessWidget {
  final int itemCount;

  const MobileDashboardRecentOperationsSkeleton({
    this.itemCount = 5,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const MobileDashboardSectionTitleSkeleton(showTrailing: true),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: context.mdTheme.surface,
            border: Border.all(color: context.mdTheme.border),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              for (var index = 0; index < itemCount; index++)
                MobileDashboardOperationRowSkeleton(
                  last: index == itemCount - 1,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Loading state for a single operation row.
class MobileDashboardOperationRowSkeleton extends StatelessWidget {
  final bool last;

  const MobileDashboardOperationRowSkeleton({required this.last, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        border: last
            ? null
            : Border(bottom: BorderSide(color: context.mdTheme.border)),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Expanded(child: MobileDashboardSkeleton(width: 160, height: 13)),
              SizedBox(width: 12),
              MobileDashboardSkeleton(width: 64, height: 13),
            ],
          ),
          SizedBox(height: 9),
          Row(
            children: [
              MobileDashboardSkeleton(width: 110, height: 9),
              Spacer(),
              MobileDashboardSkeleton(width: 40, height: 9),
            ],
          ),
        ],
      ),
    );
  }
}

/// Loading state for the quick-action icon grid.
class MobileDashboardQuickActionsSkeleton extends StatelessWidget {
  final int itemCount;

  const MobileDashboardQuickActionsSkeleton({this.itemCount = 8, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const MobileDashboardSectionTitleSkeleton(showTrailing: true),
        AdaptiveSlotGrid(
          minItemWidth: 68,
          maxColumns: 4,
          runSpacing: 10,
          spacing: 10,
          childAspectRatio: 0.82,
          children: [
            for (var index = 0; index < itemCount; index++)
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MobileDashboardSkeleton(width: 46, height: 46),
                  SizedBox(height: 8),
                  MobileDashboardSkeleton(width: 54, height: 10),
                ],
              ),
          ],
        ),
      ],
    );
  }
}

/// Shared title placeholder used by section-level loading widgets.
class MobileDashboardSectionTitleSkeleton extends StatelessWidget {
  final bool showTrailing;

  const MobileDashboardSectionTitleSkeleton({
    this.showTrailing = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 3,
            height: 34,
            decoration: BoxDecoration(
              color: context.mdTheme.inputBg,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MobileDashboardSkeleton(width: 152, height: 13),
                SizedBox(height: 7),
                MobileDashboardSkeleton(width: 224, height: 10),
              ],
            ),
          ),
          if (showTrailing) ...[
            const SizedBox(width: 12),
            const MobileDashboardSkeleton(
              width: 62,
              height: 24,
              borderRadius: BorderRadius.all(Radius.circular(999)),
            ),
          ],
        ],
      ),
    );
  }
}
