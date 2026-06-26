// ============================================================
// CORE / TENANCY — TenantDatabase
// ------------------------------------------------------------
// The open/close lifecycle for ONE tenant's connection. Created
// inside the keyed TenantScope (RepositoryProvider) and disposed
// when the scope is torn down (tenant switch / logout) — Flutter
// rebuilds the subtree on ValueKey(tenantId) change, calling
// dispose() here, which closes the underlying connection.
//
// Hard invariant: a TenantDatabase serves exactly ONE tenant and
// rejects any access whose tenantId differs from its session —
// the cross-tenant guard for database-per-tenant isolation.
//
// File placement:  lib/core/tenancy/tenant_database.dart
// ============================================================

import 'package:flutter/foundation.dart';

import 'tenant_session.dart';

class TenantDatabase {
  final TenantSession session;
  bool _open = false;

  TenantDatabase(this.session);

  bool get isOpen => _open;
  String get tenantId => session.tenantId;

  /// Opens the per-tenant connection (sqlite file / scoped API client).
  /// Idempotent. In the local build this just flips the flag; the real
  /// implementation (Phase 9 data layer) opens the descriptor's resource.
  Future<void> open() async {
    if (_open) return;
    _open = true;
    if (kDebugMode) {
      debugPrint('[TenantDB] open  ${session.tenantId} '
          '→ ${session.connection.dbName}');
    }
  }

  /// Guards every query/request: the tenantId must match this database's
  /// session, or it is a cross-tenant leak and throws.
  void guard(String tenantId) {
    if (tenantId != session.tenantId) {
      throw StateError(
        'Cross-tenant access blocked: db is "${session.tenantId}", '
        'request was "$tenantId".',
      );
    }
  }

  /// Closes the connection. Called from RepositoryProvider.dispose when the
  /// keyed scope is destroyed — observable in the AppBlocObserver flow as
  /// the surrounding cubits close alongside it.
  Future<void> close() async {
    if (!_open) return;
    _open = false;
    if (kDebugMode) debugPrint('[TenantDB] close ${session.tenantId}');
  }
}
