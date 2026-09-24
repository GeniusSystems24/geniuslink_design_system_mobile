// MOBILE_DASHBOARD_COMPONENTIZATION_V3
// MOBILE_DASHBOARD_CHROME_SCAFFOLD_V1
import 'dart:async' show unawaited;

import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart' show ChromeScaffold;
import 'package:gl_mobile_app/features/mobile_dashboard/presentation/widgets/mobile_dashboard_workspace_menu.dart';

import '../../../../core/tenancy/tenant_connection.dart';
import '../../../../localization/generated/l10n.dart';
import '../../../../workspace/presentation/controllers/tenant_controller.dart';
import '../../domain/domain.dart';
import '../widgets/mobile_dashboard_header.dart';
import '../widgets/mobile_dashboard_navigation.dart';
import '../widgets/mobile_dashboard_section_view.dart';
import '../widgets/mobile_dashboard_theme.dart';
import '../mobile_dashboard_localization.dart';

class MobileDashboardScreen extends StatefulWidget {
  final WorkspaceRepository repository;
  final TenantController? tenantController;
  final MobileDashboardComponentThemeData componentTheme;

  const MobileDashboardScreen({
    required this.repository,
    this.tenantController,
    this.componentTheme = const MobileDashboardComponentThemeData(),
    super.key,
  });

  @override
  State<MobileDashboardScreen> createState() => _MobileDashboardScreenState();
}

class _MobileDashboardScreenState extends State<MobileDashboardScreen> {
  final _sectionKey = GlobalKey<MobileDashboardSectionViewState>();
  TenantController? _ownedTenantController;

  String _activeTenantId = '9';
  bool _workspaceMenuOpen = false;
  final bool _online = true;

  TenantController get _tenantController =>
      widget.tenantController ?? _ownedTenantController!;

  MdWorkspace _workspaceFor(
    MobileDashboardCatalog catalog,
    GeniusLinkLocalization l10n,
  ) {
    if (catalog.workspaces.isEmpty) {
      return MdWorkspace(
        'default',
        'default',
        l10n.mobileDashboardWorkspace,
        '',
        1,
      );
    }
    return catalog.workspaces.firstWhere(
      (workspace) => workspace.tenantId == _activeTenantId,
      orElse: () => catalog.workspaces.first,
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.tenantController == null) {
      _ownedTenantController = TenantController(
        resolver: const FakeTenantConnectionResolver(),
      );
      unawaited(_initializeOwnedTenant());
    }
  }

  Future<void> _initializeOwnedTenant() async {
    final controller = _ownedTenantController;
    if (controller == null) return;
    await controller.loadAvailable();
    if (_ownedTenantController == controller) {
      await controller.switchTo(_activeTenantId);
    }
  }

  @override
  void dispose() {
    _ownedTenantController?.dispose();
    super.dispose();
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_rounded,
                size: 15,
                color: context.mdColors.onInverseSurface,
              ),
              const SizedBox(width: 8),
              Text(
                message,
                style: TextStyle(
                  color: context.mdColors.onInverseSurface,
                  fontWeight: FontWeight.w600,
                  fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                ),
              ),
            ],
          ),
          backgroundColor: context.mdColors.inverseSurface,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(milliseconds: 1600),
          shape: const StadiumBorder(),
          width: 280,
        ),
      );
  }

  void _switchWorkspace(MdWorkspace workspace) {
    setState(() => _workspaceMenuOpen = false);
    unawaited(_tenantController.switchTo(workspace.tenantId));
    _sectionKey.currentState?.scrollToTop();
    _sectionKey.currentState?.refresh();
  }

  void _selectNavigationItem(
    String id,
    List<MobileDashboardNavigationDestination> items,
  ) {
    if (id == 'home') return;

    for (final item in items) {
      if (item.id == id) {
        _showToast(item.label);
        return;
      }
    }

    _showToast(id);
  }

  @override
  Widget build(BuildContext context) {
    return MobileDashboardTheme(
      data: widget.componentTheme,
      child: ListenableBuilder(
        listenable: _tenantController,
        builder: (context, _) {
          _activeTenantId =
              _tenantController.state.activeTenantId ?? _activeTenantId;

          final l10n = GeniusLinkLocalization.of(context);
          final repository = LocalizedWorkspaceRepository(
            widget.repository,
            l10n,
          );
          final catalog = repository.catalog;
          final navigationItems = repository.navigationItems;
          final workspace = _workspaceFor(catalog, l10n);

          return ChromeScaffold(
            hideFloatingActionButtonWhenScroll: true,
            hideBottomNavigationBarWhenScroll: true,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                MediaQuery.paddingOf(context).top + 64,
              ),
              child: MobileDashboardAppBar(
                workspace: workspace,
                workspaceMenuOpen: _workspaceMenuOpen,
                onWorkspaceTap: () =>
                    setState(() => _workspaceMenuOpen = !_workspaceMenuOpen),
                onNotificationsTap: () =>
                    _showToast(l10n.mobileDashboardNotifications),
              ),
            ),
            bottomNavigationBar: MobileDashboardBottomNavigation(
              selectedId: 'home',
              items: navigationItems,
              onSelected: (id) => _selectNavigationItem(id, navigationItems),
            ),
            floatingActionButton: MobileDashboardFloatingSearchButton(
              onTap: () => _sectionKey.currentState?.openSearch(),
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                MobileDashboardSectionView(
                  key: _sectionKey,
                  repository: repository,
                  workspace: workspace,
                  online: _online,
                ),
                if (_workspaceMenuOpen)
                  MobileDashboardWorkspaceMenu(
                    workspaces: catalog.workspaces,
                    selectedWorkspace: workspace,
                    onSelected: _switchWorkspace,
                    onDismiss: () => setState(() => _workspaceMenuOpen = false),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
