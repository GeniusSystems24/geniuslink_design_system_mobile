// ============================================================
// WORKSPACE / BLOC — TenantState
// ------------------------------------------------------------
// The active-tenant selection (control-plane scope). Holds the
// tenants the user may enter, the resolved session for the active
// one, and the resolve status. `active?.tenantId` is the value the
// TenantScope keys on — a change tears down and rebuilds the whole
// tenant subtree (repos + blocs + connection).
//
// File placement:  lib/workspace/presentation/bloc/tenant_state.dart
// ============================================================

import 'package:equatable/equatable.dart';

import '../../../core/bloc/load_status.dart';
import '../../../core/tenancy/tenant_session.dart';

class TenantState extends Equatable {
  final LoadStatus status;
  final List<TenantRef> availableTenants;
  final TenantSession? active;
  final String? error;

  const TenantState({
    this.status = LoadStatus.initial,
    this.availableTenants = const [],
    this.active,
    this.error,
  });

  String? get activeTenantId => active?.tenantId;

  TenantState copyWith({
    LoadStatus? status,
    List<TenantRef>? availableTenants,
    TenantSession? active,
    bool clearActive = false,
    String? error,
  }) {
    return TenantState(
      status: status ?? this.status,
      availableTenants: availableTenants ?? this.availableTenants,
      active: clearActive ? null : (active ?? this.active),
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, availableTenants, active, error];
}
