// ============================================================
// WORKSPACE / BLOC — TenantCubit
// ------------------------------------------------------------
// Owns the available-tenants list + the active selection, and
// resolves a tenantId to a TenantSession (via the connection
// resolver) on switch. Emitting a new active session changes the
// key the TenantScope rebuilds on — that is the isolation pivot:
// old repos/blocs/connection are destroyed, fresh ones built.
//
//   setAvailable(list)  — seed from AuthBloc.availableTenants
//   switchTo(id)        — resolve + activate a tenant (async)
//   clear()             — drop the active tenant (logout / gate)
//
// File placement:  lib/workspace/presentation/bloc/tenant_cubit.dart
// ============================================================

import 'package:bloc/bloc.dart';

import '../../../core/bloc/load_status.dart';
import '../../../core/tenancy/tenant_connection.dart';
import '../../../core/tenancy/tenant_session.dart';
import 'tenant_state.dart';

class TenantCubit extends Cubit<TenantState> {
  final TenantConnectionResolver resolver;

  TenantCubit({required this.resolver}) : super(const TenantState());

  /// Replace the catalog of tenants the user may enter (from AuthBloc).
  void setAvailable(List<TenantRef> tenants) {
    emit(state.copyWith(availableTenants: tenants));
  }

  /// Resolve a tenant's connection and make it active. A new active
  /// session ⇒ new ValueKey(tenantId) ⇒ TenantScope teardown + rebuild.
  Future<void> switchTo(String tenantId) async {
    if (state.activeTenantId == tenantId) return;
    emit(state.copyWith(status: LoadStatus.loading, error: null));
    try {
      final connection = await resolver.resolve(tenantId);
      final ref = state.availableTenants.firstWhere(
        (t) => t.id == tenantId,
        orElse: () => TenantRef(id: tenantId, name: 'Tenant $tenantId'),
      );
      emit(state.copyWith(
        status: LoadStatus.ready,
        active: TenantSession.fromRef(ref, connection),
      ));
    } catch (err) {
      emit(state.copyWith(status: LoadStatus.failure, error: err.toString()));
    }
  }

  /// Drop the active tenant — logout or returning to the auth gate.
  /// The scope tears down the previous tenant's repos/blocs/connection.
  void clear() {
    emit(state.copyWith(
      status: LoadStatus.initial,
      clearActive: true,
      error: null,
    ));
  }
}
