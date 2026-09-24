// MOBILE_DASHBOARD_COMPONENTIZATION_V3
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:gl_mobile_app/features/mobile_dashboard/presentation/widgets/mobile_dashboard_icon_button.dart';

import '../../../../design_system/kit.dart';
import '../../domain/domain.dart';
import 'mobile_dashboard_pressable.dart';
import 'mobile_dashboard_theme.dart';

class MobileDashboardAppBar extends StatelessWidget {
  final MdWorkspace workspace;
  final bool workspaceMenuOpen;
  final VoidCallback onWorkspaceTap;
  final VoidCallback onNotificationsTap;
  final String? notificationBadge;

  const MobileDashboardAppBar({
    required this.workspace,
    required this.workspaceMenuOpen,
    required this.onWorkspaceTap,
    required this.onNotificationsTap,
    this.notificationBadge = '8',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: EdgeInsets.fromLTRB(
            18,
            MediaQuery.paddingOf(context).top + 14,
            18,
            12,
          ),
          decoration: BoxDecoration(
            color:
                (context.mdMaterialTheme.appBarTheme.backgroundColor ??
                        context.mdColors.surface)
                    .withAlpha(0xE6),
            border: Border(bottom: BorderSide(color: context.mdTheme.border)),
          ),
          child: Row(
            children: [
              Expanded(
                child: MobileDashboardPressable(
                  onTap: onWorkspaceTap,
                  semanticLabel: 'Switch workspace',
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: superCoreTint(context.mdColors.primary, 0x29),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          MIcons.of('grid'),
                          size: 19,
                          color: context.mdColors.primary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              workspace.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: context
                                    .mdTextTheme
                                    .headlineMedium
                                    ?.fontFamily,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: context.mdTheme.fg1,
                              ),
                            ),
                            Text(
                              workspace.subtitle,
                              style: TextStyle(
                                fontFamily:
                                    context.mdTextTheme.bodyMedium?.fontFamily,
                                fontSize: 10.5,
                                color: context.mdTheme.fg3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AnimatedRotation(
                        turns: workspaceMenuOpen ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          MIcons.of('chevD'),
                          size: 15,
                          color: context.mdTheme.fg3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              MobileDashboardIconButton(
                icon: 'bell',
                onTap: onNotificationsTap,
                badge: notificationBadge,
                semanticLabel: 'Notifications',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileDashboardSegmentedPreference extends StatelessWidget {
  final String label;
  final int value;
  final List<String> options;
  final ValueChanged<int> onChanged;
  final SegmentedSlotSelectorThemeData? theme;

  const MobileDashboardSegmentedPreference({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.theme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedTheme =
        theme ??
        context.mdComponentTheme.segmentedSelectorTheme ??
        SegmentedSlotSelectorThemeData(
          minHeight: 38,
          backgroundColor: context.mdTheme.inputBg,
          borderColor: context.mdTheme.border,
          borderRadius: BorderRadius.circular(8),
          optionBorderRadius: BorderRadius.circular(6),
          selectedBackgroundColor: context.mdColors.primary,
          selectedForegroundColor: context.mdColors.onPrimary,
          unselectedForegroundColor: context.mdTheme.fg3,
          duration: const Duration(milliseconds: 150),
        );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: context.mdTheme.fg2,
            ),
          ),
          const SizedBox(height: 8),
          SegmentedSlotSelector(
            selectedIndex: value,
            onChanged: onChanged,
            semanticLabels: options,
            theme: resolvedTheme,
            options: [
              for (var index = 0; index < options.length; index++)
                Text(
                  options[index],
                  style: TextStyle(
                    fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                    fontSize: 12.5,
                    fontWeight: index == value
                        ? FontWeight.w700
                        : FontWeight.w500,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
