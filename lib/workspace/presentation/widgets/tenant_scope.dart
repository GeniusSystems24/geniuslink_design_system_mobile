import 'dart:async' show unawaited;

import 'package:flutter/material.dart';

import '../../../core/tenancy/tenant_database.dart';
import '../../../core/tenancy/tenant_session.dart';
import '../controllers/tenant_controller.dart';

/// Keyed MVC isolation boundary for the active tenant database.
class TenantScope extends StatelessWidget {
  final TenantController controller;
  final Widget child;
  final WidgetBuilder fallbackBuilder;

  const TenantScope({
    super.key,
    required this.controller,
    required this.child,
    required this.fallbackBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final session = controller.state.active;
        if (session == null) return fallbackBuilder(context);

        return _TenantConnectionHost(
          key: ValueKey('tenant:${session.tenantId}'),
          session: session,
          child: child,
        );
      },
    );
  }
}

/// Lightweight inherited database boundary replacing provider coupling.
class TenantDatabaseScope extends InheritedWidget {
  final TenantDatabase database;

  const TenantDatabaseScope({
    super.key,
    required this.database,
    required super.child,
  });

  static TenantDatabase of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<TenantDatabaseScope>();
    assert(scope != null, 'TenantDatabaseScope not found in context.');
    return scope!.database;
  }

  @override
  bool updateShouldNotify(TenantDatabaseScope oldWidget) =>
      !identical(database, oldWidget.database);
}

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
    _db = TenantDatabase(widget.session);
    unawaited(_db.open());
  }

  @override
  void dispose() {
    unawaited(_db.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TenantDatabaseScope(database: _db, child: widget.child);
  }
}
