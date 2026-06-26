// ============================================================
// WORKSPACE / WIDGETS — TenantScope (keyed isolation boundary)
// ------------------------------------------------------------
// The database-per-tenant isolation boundary. Watches TenantCubit;
// when a tenant is active it provides that tenant's TenantDatabase
// (and, in later phases, its repositories + shell blocs) under a
// ValueKey(tenantId). When the active tenant changes, Flutter
// destroys this subtree — the host State's dispose() closes the
// previous connection — and builds a fresh one. No tenant state
// survives a switch.
//
// Phase 1 wires the boundary + connection lifecycle. Tenant repos
// (Phase 6+) and the shell blocs (WorkspaceCubit/NavCubit, Phase
// 3/4) are added inside _TenantConnectionHost's provider tree.
//
// File placement:  lib/workspace/presentation/widgets/tenant_scope.dart
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/tenancy/tenant_database.dart';
import '../../../core/tenancy/tenant_session.dart';
import '../bloc/tenant_cubit.dart';
import '../bloc/tenant_state.dart';

class TenantScope extends StatelessWidget {
  /// The authenticated shell to mount once a tenant is active.
  final Widget child;

  /// Shown while no tenant is active (auth gate / pre-selection).
  final WidgetBuilder fallbackBuilder;

  const TenantScope({
    super.key,
    required this.child,
    required this.fallbackBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TenantCubit, TenantState>(
      // Only rebuild the boundary when the ACTIVE tenant identity changes.
      buildWhen: (a, b) => a.activeTenantId != b.activeTenantId,
      builder: (context, state) {
        final session = state.active;
        if (session == null) return fallbackBuilder(context);

        // ValueKey(tenantId) ⇒ a new tenant gives a new State, so the old
        // host is disposed (connection closed) before the new one mounts.
        return _TenantConnectionHost(
          key: ValueKey('tenant:${session.tenantId}'),
          session: session,
          child: child,
        );
      },
    );
  }
}

/// Owns one tenant's TenantDatabase for the lifetime of the keyed subtree,
/// providing it down the tree and closing it on dispose.
class _TenantConnectionHost extends StatefulWidget {
  final TenantSession session;
  final Widget child;

  const _TenantConnectionHost({
    super.key,
    required this.session,
    required this.child,
  });

  @override
  State<_TenantConnectionHost> createState() => _TenantConnectionHostState();
}

class _TenantConnectionHostState extends State<_TenantConnectionHost> {
  late final TenantDatabase _db;

  @override
  void initState() {
    super.initState();
    _db = TenantDatabase(widget.session)..open();
  }

  @override
  void dispose() {
    _db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Tenant-scoped repositories + shell blocs nest under this provider in
    // later phases (RepositoryProvider … → MultiBlocProvider … → shell).
    return RepositoryProvider<TenantDatabase>.value(
      value: _db,
      child: widget.child,
    );
  }
}
