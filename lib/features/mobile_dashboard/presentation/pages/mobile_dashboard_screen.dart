import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gl_mobile_app/features/mobile_dashboard/presentation/widgets/mobile_dashboard_workspace_menu.dart';

import '../../../../workspace/presentation/bloc/tenant_cubit.dart';
import '../../domain/domain.dart';
import '../widgets/mobile_dashboard_header.dart';
import '../widgets/mobile_dashboard_navigation.dart';
import '../widgets/mobile_dashboard_section_view.dart';
import '../widgets/mobile_dashboard_theme.dart';

class MobileDashboardScreen extends StatefulWidget {
  final WorkspaceRepository repository;

  const MobileDashboardScreen({required this.repository, super.key});

  @override
  State<MobileDashboardScreen> createState() => _MobileDashboardScreenState();
}

class _MobileDashboardScreenState extends State<MobileDashboardScreen> {
  final _sectionKey = GlobalKey<MobileDashboardSectionViewState>();

  String _activeTenantId = '9';
  bool _workspaceMenuOpen = false;
  final bool _online = true;

  MobileDashboardCatalog get _catalog => widget.repository.catalog;
  List<MobileDashboardNavigationDestination> get _navigationItems =>
      widget.repository.navigationItems;

  MdWorkspace get _workspace {
    if (_catalog.workspaces.isEmpty) {
      return const MdWorkspace('default', 'default', 'Workspace', '', 1);
    }
    return _catalog.workspaces.firstWhere(
      (workspace) => workspace.tenantId == _activeTenantId,
      orElse: () => _catalog.workspaces.first,
    );
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
    context.read<TenantCubit>().switchTo(workspace.tenantId);
    _sectionKey.currentState?.scrollToTop();
    _sectionKey.currentState?.refresh();
  }

  void _selectNavigationItem(String id) {
    if (id != 'home') {
      _showToast(id[0].toUpperCase() + id.substring(1));
    }
  }

  @override
  Widget build(BuildContext context) {
    _activeTenantId =
        context.watch<TenantCubit>().state.activeTenantId ?? _activeTenantId;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.paddingOf(context).top + 64),
        child: MobileDashboardAppBar(
          workspace: _workspace,
          workspaceMenuOpen: _workspaceMenuOpen,
          onWorkspaceTap: () =>
              setState(() => _workspaceMenuOpen = !_workspaceMenuOpen),
          onNotificationsTap: () => _showToast('Notifications'),
        ),
      ),
      bottomNavigationBar: MobileDashboardBottomNavigation(
        selectedId: 'home',
        items: _navigationItems,
        onSelected: _selectNavigationItem,
      ),
      floatingActionButton: MobileDashboardFloatingSearchButton(
        onTap: () => _sectionKey.currentState?.openSearch(),
      ),
      body: Stack(
        children: [
          MobileDashboardSectionView(
            key: _sectionKey,
            repository: widget.repository,
            workspace: _workspace,
            online: _online,
          ),
          if (_workspaceMenuOpen)
            MobileDashboardWorkspaceMenu(
              workspaces: _catalog.workspaces,
              selectedWorkspace: _workspace,
              onSelected: _switchWorkspace,
              onDismiss: () => setState(() => _workspaceMenuOpen = false),
            ),
        ],
      ),
    );
  }
}
