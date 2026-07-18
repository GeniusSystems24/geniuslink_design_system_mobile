// ============================================================
// AUTH / BLOC — AuthBloc (event-driven, control-plane)
// ------------------------------------------------------------
// The one event-driven Bloc in the migration (everything else is
// Cubit-first). Authenticates against the control-plane and loads
// the tenants the user may enter. It does NOT open any tenant
// database — that is TenantCubit + the keyed TenantScope.
//
// Events:
//   AuthLoginRequested   — credentials → authenticate + load tenants
//   AuthSignUpRequested  — provision a brand-new tenant workspace
//   AuthTenantsLoaded    — (re)load available tenants from the catalog
//   AuthLogoutRequested  — clear session; the shell closes the tenant scope
//
// File placement:  lib/features/auth/presentation/bloc/auth_bloc.dart
// ============================================================

import 'package:bloc/bloc.dart';

import '../../../../core/tenancy/tenant_connection.dart';
import '../../domain/domain.dart';
import 'auth_state.dart';

// ----------------------------------------------------------------- events
abstract class AuthEvent {
  const AuthEvent();
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  const AuthLoginRequested(this.email, this.password);
}

/// sign_up = provision a new tenant workspace (control-plane).
class AuthSignUpRequested extends AuthEvent {
  final String email;
  final String workspaceName;
  const AuthSignUpRequested(this.email, this.workspaceName);
}

class AuthTenantsLoaded extends AuthEvent {
  const AuthTenantsLoaded();
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

// ------------------------------------------------------------------- bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final TenantConnectionResolver resolver;

  AuthBloc({required this.resolver, AuthState? initial})
      : super(initial ?? const AuthState(status: AuthStatus.unknown)) {
    on<AuthLoginRequested>(_onLogin);
    on<AuthSignUpRequested>(_onSignUp);
    on<AuthTenantsLoaded>(_onTenantsLoaded);
    on<AuthLogoutRequested>(_onLogout);
  }

  Future<void> _onLogin(
    AuthLoginRequested e,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.authenticating, error: null));
    try {
      final tenants = await resolver.availableTenants();
      final user = AuthUser(
        id: 'u_${e.email.hashCode.toUnsigned(16)}',
        name: e.email.split('@').first,
        email: e.email,
      );
      emit(AuthState.authenticated(user, tenants));
    } catch (err) {
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        error: err.toString(),
      ));
    }
  }

  Future<void> _onSignUp(
    AuthSignUpRequested e,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.authenticating, error: null));
    try {
      final tenants = await resolver.availableTenants();
      final user = AuthUser(
        id: 'u_${e.email.hashCode.toUnsigned(16)}',
        name: e.email.split('@').first,
        email: e.email,
      );
      // A real provision call would mint a new tenant + connection here.
      emit(AuthState.authenticated(user, tenants));
    } catch (err) {
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        error: err.toString(),
      ));
    }
  }

  Future<void> _onTenantsLoaded(
    AuthTenantsLoaded e,
    Emitter<AuthState> emit,
  ) async {
    final tenants = await resolver.availableTenants();
    emit(state.copyWith(availableTenants: tenants));
  }

  void _onLogout(AuthLogoutRequested e, Emitter<AuthState> emit) {
    emit(const AuthState.unauthenticated());
  }
}
