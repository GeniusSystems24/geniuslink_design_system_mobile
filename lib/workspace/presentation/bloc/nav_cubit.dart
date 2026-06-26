// ============================================================
// WORKSPACE / BLOC — NavCubit
// ------------------------------------------------------------
// The mobile shell's navigation state machine. Ports
// NavController 1:1 (auth gate · active tab · sub-screen stack)
// from a ChangeNotifier to a Cubit. Views call selectTab/go/back/
// home; the shell rebuilds via BlocBuilder<NavCubit, NavState>.
//
// `registryHas` is injected by the app root (avoids a router →
// workspace import cycle) and lets back() jump to a declared
// target screen.
//
// Re-exports nav_state.dart so a single import gives NavCubit,
// NavState, and AuthScreen.
//
// File placement:  lib/workspace/presentation/bloc/nav_cubit.dart
// ============================================================

import 'package:bloc/bloc.dart';

import 'nav_state.dart';
export 'nav_state.dart';

class NavCubit extends Cubit<NavState> {
  NavCubit() : super(const NavState());

  /// Injected by the shell to avoid a hard router import cycle.
  bool Function(String) registryHas = (_) => false;

  // Convenience getters mirroring the old NavController surface.
  bool get authed => state.authed;
  AuthScreen get authScreen => state.authScreen;
  String get tab => state.tab;
  String? get sub => state.sub;

  // ---- auth ----
  void login() => emit(state.copyWith(authed: true));
  void logout() => emit(const NavState());
  void showAuth(AuthScreen s) => emit(state.copyWith(authScreen: s));

  // ---- tabs ----
  void selectTab(String t) => emit(state.copyWith(tab: t, stack: const []));

  // ---- sub-screen routing ----
  void go(String id) => emit(state.copyWith(stack: [...state.stack, id]));

  /// Pop to a specific target (the screen's declared `back`), or one level.
  void back(String? target) {
    final stack = [...state.stack];
    if (target != null && target != 'more' && registryHas(target)) {
      final idx = stack.lastIndexOf(target);
      if (idx >= 0) {
        stack.removeRange(idx + 1, stack.length);
      } else {
        if (stack.isNotEmpty) stack.removeLast();
        stack.add(target);
      }
    } else {
      if (stack.isNotEmpty) stack.removeLast();
    }
    emit(state.copyWith(stack: stack));
  }

  void home() => emit(state.copyWith(stack: const []));
}
