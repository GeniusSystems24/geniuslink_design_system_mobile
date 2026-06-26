// ============================================================
// WORKSPACE / BLOC — NavState
// ------------------------------------------------------------
// Immutable snapshot of the mobile shell's navigation: the auth
// gate (authed + which auth form), the active bottom tab, and the
// sub-screen stack (push/pop, supports nested back).
//
// Ported from NavController's fields. The tab + stack are the
// tenant-scoped part (reset on tenant switch); authed/authScreen
// are the control-plane gate.
//
// File placement:  lib/workspace/presentation/bloc/nav_state.dart
// ============================================================

import 'package:equatable/equatable.dart';

enum AuthScreen { login, signup, forgot }

class NavState extends Equatable {
  final bool authed;
  final AuthScreen authScreen;
  final String tab;
  final List<String> stack; // sub-screen ids

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

  @override
  List<Object?> get props => [authed, authScreen, tab, stack];
}
