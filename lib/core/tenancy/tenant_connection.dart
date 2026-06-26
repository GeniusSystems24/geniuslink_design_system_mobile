// ============================================================
// CORE / TENANCY — TenantConnectionResolver
// ------------------------------------------------------------
// Catalog lookup: tenantId → ConnectionDescriptor. In the
// database-per-tenant model this is the control-plane query that
// answers "which database/connection owns this tenant?". There is
// NO shared data connection — each tenant resolves to its own.
//
// Injectable interface so Phase 9 can swap the fake for a real
// control-plane client without touching call sites. The fake below
// seeds the same tenants the UI already shows (Al-Rashid · Najd ·
// Coastal · …) and synthesises a distinct connection per tenant.
//
// File placement:  lib/core/tenancy/tenant_connection.dart
// ============================================================

import 'tenant_session.dart';

/// Resolves a tenantId to the connection for that tenant's own database.
abstract class TenantConnectionResolver {
  /// The tenants the current user may enter (control-plane catalog).
  Future<List<TenantRef>> availableTenants();

  /// Route a tenantId to its isolated connection. Throws if unknown.
  Future<ConnectionDescriptor> resolve(String tenantId);
}

/// In-memory resolver for the current local-datasource build. Every tenant
/// gets a distinct dbName/token so isolation is observable end to end.
class FakeTenantConnectionResolver implements TenantConnectionResolver {
  const FakeTenantConnectionResolver();

  static const List<TenantRef> _catalog = [
    TenantRef(id: '9', name: 'Al-Rashid Trading Co.', plan: 'Business'),
    TenantRef(id: '14', name: 'Najd Holdings', plan: 'Enterprise'),
    TenantRef(id: '22', name: 'Coastal Logistics', plan: 'Starter'),
  ];

  @override
  Future<List<TenantRef>> availableTenants() async => _catalog;

  @override
  Future<ConnectionDescriptor> resolve(String tenantId) async {
    final known = _catalog.any((t) => t.id == tenantId);
    if (!known) {
      throw StateError('Unknown tenant "$tenantId" — not in catalog.');
    }
    // Each tenant ⇒ its own database file + scoped token. No shared store.
    return ConnectionDescriptor(
      baseUrl: 'local://geniuslink',
      dbName: 'tenant_$tenantId.db',
      schema: 't$tenantId',
      token: 'tok_$tenantId',
    );
  }
}
