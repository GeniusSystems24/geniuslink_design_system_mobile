// ============================================================
// CORE / TENANCY — TenantSession + ConnectionDescriptor + TenantRef
// ------------------------------------------------------------
// Immutable identity layer for the database-per-tenant model.
//
//   TenantRef             — lightweight catalog entry (id · name · plan).
//                           What AuthController loads + TenantController lists.
//   ConnectionDescriptor  — how to reach ONE tenant's own database
//                           (baseUrl / dbName / schema / token). No
//                           shared data store — every tenant routes to
//                           its own connection.
//   TenantSession         — the active tenant: ref + resolved connection.
//                           Drives ValueKey(tenantId) on the tenant scope.
//
// File placement:  lib/core/tenancy/tenant_session.dart
// ============================================================

import 'package:equatable/equatable.dart';

/// A tenant the signed-in user may enter. Control-plane catalog entry —
/// carries no connection (that is resolved on switch).
class TenantRef extends Equatable {
  final String id;
  final String name;
  final String plan;

  const TenantRef({required this.id, required this.name, this.plan = ''});

  @override
  List<Object?> get props => [id, name, plan];
}

/// Routing details for a single tenant's isolated database/connection.
class ConnectionDescriptor extends Equatable {
  final String baseUrl;
  final String dbName;
  final String schema;
  final String token;

  const ConnectionDescriptor({
    required this.baseUrl,
    required this.dbName,
    this.schema = 'public',
    this.token = '',
  });

  @override
  List<Object?> get props => [baseUrl, dbName, schema, token];
}

/// The active tenant: its catalog ref + the resolved connection it routes
/// to. Immutable — a switch produces a new instance, never a mutation.
class TenantSession extends Equatable {
  final String tenantId;
  final String name;
  final ConnectionDescriptor connection;

  const TenantSession({
    required this.tenantId,
    required this.name,
    required this.connection,
  });

  factory TenantSession.fromRef(TenantRef ref, ConnectionDescriptor c) =>
      TenantSession(tenantId: ref.id, name: ref.name, connection: c);

  @override
  List<Object?> get props => [tenantId, name, connection];
}
