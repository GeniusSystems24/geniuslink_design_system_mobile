// MOBILE_DASHBOARD_COMPONENTIZATION_V3
import 'package:flutter/material.dart';
import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/features/mobile_dashboard/domain/domain.dart';
import 'package:gl_mobile_app/features/mobile_dashboard/presentation/widgets/mobile_dashboard_theme.dart';

class MobileDashboardWorkspaceMenu extends StatelessWidget {
  final List<MdWorkspace> workspaces;
  final MdWorkspace selectedWorkspace;
  final ValueChanged<MdWorkspace> onSelected;
  final VoidCallback onDismiss;

  const MobileDashboardWorkspaceMenu({
    required this.workspaces,
    required this.selectedWorkspace,
    required this.onSelected,
    required this.onDismiss,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          GestureDetector(
            onTap: onDismiss,
            child: Container(color: Colors.transparent),
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 60,
            left: 18,
            right: 18,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: context.mdTheme.surface,
                  border: Border.all(color: context.mdTheme.borderStrong),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: context.mdColors.shadow.withValues(alpha: 0.5),
                      blurRadius: 28,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 8, 10, 6),
                      child: Text(
                        'SWITCH WORKSPACE',
                        style: TextStyle(
                          fontFamily:
                              context.mdTextTheme.bodyMedium?.fontFamily,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          letterSpacing: 0.8,
                          color: context.mdTheme.fg3,
                        ),
                      ),
                    ),
                    for (final workspace in workspaces)
                      WorkspaceMenuItem(
                        workspace: workspace,
                        selected: workspace.id == selectedWorkspace.id,
                        onTap: () => onSelected(workspace),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WorkspaceMenuItem extends StatelessWidget {
  final MdWorkspace workspace;
  final bool selected;
  final VoidCallback onTap;
  final DirectionalSlotTileThemeData? theme;

  const WorkspaceMenuItem({
    super.key,
    required this.workspace,
    required this.selected,
    required this.onTap,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return DirectionalSlotTile(
      onTap: onTap,
      semanticLabel: workspace.name,
      theme:
          theme ??
          DirectionalSlotTileThemeData(
            minHeight: 48,
            padding: const EdgeInsets.all(10),
            backgroundColor: selected
                ? context.mdTheme.hover
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            pressableTheme: const PressableSurfaceThemeData(pressedScale: 1),
          ),
      start: IconSurface(
        theme: IconSurfaceThemeData(
          size: 34,
          backgroundColor: selected
              ? context.mdColors.primary
              : context.mdTheme.inputBg,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Text(
          workspace.name.isEmpty ? '?' : workspace.name[0],
          style: TextStyle(
            fontFamily: context.mdTextTheme.headlineMedium?.fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: selected ? context.mdColors.onPrimary : context.mdTheme.fg3,
          ),
        ),
      ),
      center: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            workspace.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: context.mdTheme.fg1,
            ),
          ),
          Text(
            workspace.subtitle,
            style: TextStyle(
              fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
              fontSize: 10.5,
              color: context.mdTheme.fg3,
            ),
          ),
        ],
      ),
      end: selected
          ? Icon(MIcons.of('check'), size: 16, color: context.mdColors.primary)
          : null,
    );
  }
}
