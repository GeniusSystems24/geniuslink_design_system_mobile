// ============================================================
// CONTROLLER — App navigation (ChangeNotifier)
// ------------------------------------------------------------
// Ports MobileApp.jsx's state machine: auth gate, the active
// bottom tab, and the current sub-screen (push/pop). Views call
// these methods; the shell rebuilds from the notified state.
// ============================================================

import 'package:flutter/foundation.dart';

enum AuthScreen { login, signup, forgot }

class NavController extends ChangeNotifier {
  bool _authed = false;
  AuthScreen _authScreen = AuthScreen.login;
  String _tab = 'dashboard';
  final List<String> _stack = []; // sub-screen ids (supports nested back)

  bool get authed => _authed;
  AuthScreen get authScreen => _authScreen;
  String get tab => _tab;
  String? get sub => _stack.isEmpty ? null : _stack.last;

  // ---- auth ----
  void login() { _authed = true; notifyListeners(); }
  void logout() { _authed = false; _authScreen = AuthScreen.login; _tab = 'dashboard'; _stack.clear(); notifyListeners(); }
  void showAuth(AuthScreen s) { _authScreen = s; notifyListeners(); }

  // ---- tabs ----
  void selectTab(String t) { _tab = t; _stack.clear(); notifyListeners(); }

  // ---- sub-screen routing ----
  void go(String id) { _stack.add(id); notifyListeners(); }

  /// Pop to a specific target (the screen's declared `back`), or one level.
  void back(String? target) {
    if (target != null && target != 'more' && _registryHas(target)) {
      // jump the stack to the target screen
      final idx = _stack.lastIndexOf(target);
      if (idx >= 0) {
        _stack.removeRange(idx + 1, _stack.length);
      } else {
        // replace top with the target (it lives under another tab/menu)
        if (_stack.isNotEmpty) _stack.removeLast();
        _stack.add(target);
      }
    } else {
      if (_stack.isNotEmpty) _stack.removeLast();
    }
    notifyListeners();
  }

  void home() { _stack.clear(); notifyListeners(); }

  // registry presence is injected by the shell to avoid a hard import cycle
  bool Function(String) registryHas = (_) => false;
  bool _registryHas(String id) => registryHas(id);
}
