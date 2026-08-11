import 'package:flutter/foundation.dart';

import '../../../../core/tenancy/tenant_connection.dart';
import '../../../../core/tenancy/tenant_session.dart';
import '../../domain/domain.dart';

enum AuthStatus { unknown, authenticating, authenticated, unauthenticated }

/// Immutable control-plane authentication state exposed by [AuthController].
class AuthState {
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

  const AuthState.authenticated(this.user, this.availableTenants)
    : status = AuthStatus.authenticated,
      error = null;

  const AuthState.unauthenticated()
    : status = AuthStatus.unauthenticated,
      user = AuthUser.empty,
      availableTenants = const [TenantRef(id: '1', name: 'Tenant1')],
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
}

/// MVC control-plane controller for authentication and tenant discovery.
///
/// The application root owns/disposes this controller. Auth screens receive it
/// explicitly from the router and invoke commands without depending on a
/// provider or event bus.
class AuthController extends ChangeNotifier {
  final TenantConnectionResolver resolver;

  int _generation = 0;
  bool _disposed = false;
  AuthState _state;

  AuthController({required this.resolver, AuthState? initial})
    : _state = initial ?? const AuthState(status: AuthStatus.unknown);

  AuthState get state => _state;

  Future<bool> login(String email, String password) =>
      _authenticate(email: email);

  Future<bool> signUp(String email, String workspaceName) =>
      _authenticate(email: email);

  Future<bool> _authenticate({required String email}) async {
    final generation = ++_generation;
    _replace(_state.copyWith(status: AuthStatus.authenticating, error: null));
    try {
      final tenants = await resolver.availableTenants();
      if (_disposed || generation != _generation) return false;
      final user = AuthUser(
        id: 'u_${email.hashCode.toUnsigned(16)}',
        name: email.split('@').first,
        email: email,
      );
      _replace(AuthState.authenticated(user, tenants));
      return true;
    } catch (err) {
      if (_disposed || generation != _generation) return false;
      _replace(
        _state.copyWith(
          status: AuthStatus.unauthenticated,
          error: err.toString(),
        ),
      );
      return false;
    }
  }

  Future<void> loadTenants() async {
    final tenants = await resolver.availableTenants();
    if (_disposed) return;
    _replace(_state.copyWith(availableTenants: tenants));
  }

  void logout() {
    _generation++;
    _replace(const AuthState.unauthenticated());
  }

  void _replace(AuthState next) {
    if (_disposed) return;
    _state = next;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _generation++;
    super.dispose();
  }
}

/// Page-scoped MVC controller for the forgot-password confirmation state.
class ForgotPasswordController extends ChangeNotifier {
  bool _sent = false;

  bool get sent => _sent;

  void sendResetLink() {
    if (_sent) return;
    _sent = true;
    notifyListeners();
  }

  void useDifferentEmail() {
    if (!_sent) return;
    _sent = false;
    notifyListeners();
  }
}
