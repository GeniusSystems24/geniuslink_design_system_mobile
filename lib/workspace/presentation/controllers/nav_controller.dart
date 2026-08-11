import 'package:flutter/foundation.dart';

enum AuthScreen { login, signup, forgot }

/// Immutable navigation snapshot used by [NavController].
class NavState {
  final bool authed;
  final AuthScreen authScreen;
  final String tab;
  final List<String> stack;

  const NavState({
    this.authed = false,
    this.authScreen = AuthScreen.login,
    this.tab = 'dashboard',
    this.stack = const [],
  });

  String? get sub => stack.isEmpty ? null : stack.last;

  NavState copyWith({
    bool? authed,
    AuthScreen? authScreen,
    String? tab,
    List<String>? stack,
  }) {
    return NavState(
      authed: authed ?? this.authed,
      authScreen: authScreen ?? this.authScreen,
      tab: tab ?? this.tab,
      stack: stack ?? this.stack,
    );
  }
}

/// App-scoped MVC controller for legacy navigation compatibility state.
///
/// GoRouter remains the source of truth for URL navigation. This controller
/// preserves the legacy mobile-shell navigation contract for code that still
/// needs auth-gate, active-tab, and sub-screen stack state while the route
/// registry bridges legacy screen IDs to GoRouter paths.
class NavController extends ChangeNotifier {
  NavState _state;
  bool _disposed = false;

  NavController({NavState initial = const NavState()}) : _state = initial;

  /// Injected by the app root to avoid a router/workspace import cycle.
  bool Function(String) registryHas = (_) => false;

  NavState get state => _state;
  bool get authed => _state.authed;
  AuthScreen get authScreen => _state.authScreen;
  String get tab => _state.tab;
  String? get sub => _state.sub;

  void login() => _replace(_state.copyWith(authed: true));

  void logout() => _replace(const NavState());

  void showAuth(AuthScreen screen) =>
      _replace(_state.copyWith(authScreen: screen));

  void selectTab(String tab) =>
      _replace(_state.copyWith(tab: tab, stack: const []));

  void go(String id) => _replace(
    _state.copyWith(stack: List<String>.unmodifiable([..._state.stack, id])),
  );

  /// Pop to [target] when it is registered, otherwise pop one level.
  void back(String? target) {
    final stack = [..._state.stack];
    if (target != null && target != 'more' && registryHas(target)) {
      final index = stack.lastIndexOf(target);
      if (index >= 0) {
        stack.removeRange(index + 1, stack.length);
      } else {
        if (stack.isNotEmpty) stack.removeLast();
        stack.add(target);
      }
    } else if (stack.isNotEmpty) {
      stack.removeLast();
    }
    _replace(_state.copyWith(stack: List<String>.unmodifiable(stack)));
  }

  void home() => _replace(_state.copyWith(stack: const []));

  void _replace(NavState next) {
    if (_disposed) return;
    _state = next;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
