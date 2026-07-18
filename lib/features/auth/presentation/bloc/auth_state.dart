// ============================================================
// AUTH / BLOC — AuthState
// ------------------------------------------------------------
// Control-plane authentication state (tenant-agnostic). Holds the
// session status, the signed-in user, and the tenants that user
// may enter (loaded from the control-plane catalog). TenantCubit
// consumes `availableTenants` to drive the keyed tenant scope.
//
// File placement:  lib/features/auth/presentation/bloc/auth_state.dart
// ============================================================

import 'package:equatable/equatable.dart';

import '../../../../core/tenancy/tenant_session.dart';
import '../../domain/domain.dart';

enum AuthStatus { unknown, authenticating, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final AuthUser user;
  final List<TenantRef> availableTenants;
  final String? error;

  const AuthState({
    this.status = AuthStatus.unknown,
    this.user = AuthUser.empty,
    this.availableTenants = const [],
    this.error,
  });

  /// Desktop boots straight into the workspace (no gate) — seed authenticated.
  const AuthState.authenticated(this.user, this.availableTenants)
      : status = AuthStatus.authenticated,
        error = null;

  /// Mobile boots to the login gate — seed unauthenticated.
  const AuthState.unauthenticated()
      : status = AuthStatus.unauthenticated,
        user = AuthUser.empty,
        availableTenants = const [TenantRef(id: "1", name: "Tenant1")],
        error = null;

  bool get isAuthenticated => status == AuthStatus.authenticated;

  AuthState copyWith({
    AuthStatus? status,
    AuthUser? user,
    List<TenantRef>? availableTenants,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      availableTenants: availableTenants ?? this.availableTenants,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, user, availableTenants, error];
}
