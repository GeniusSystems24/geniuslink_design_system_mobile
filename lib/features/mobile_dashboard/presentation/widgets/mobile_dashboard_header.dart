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

  const MobileDashboardSegmentedPreference({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: context.mdTheme.inputBg,
              border: Border.all(color: context.mdTheme.border),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                for (var index = 0; index < options.length; index++)
                  Expanded(
                    child: GestureDetector(
                      onTap: () => onChanged(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        constraints: const BoxConstraints(minHeight: 32),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: index == value
                              ? context.mdColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          options[index],
                          style: TextStyle(
                            fontFamily:
                                context.mdTextTheme.bodyMedium?.fontFamily,
                            fontSize: 12.5,
                            fontWeight: index == value
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: index == value
                                ? context.mdColors.onPrimary
                                : context.mdTheme.fg3,
                          ),
                        ),
                      ),
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
