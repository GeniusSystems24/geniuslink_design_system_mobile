// ============================================================
// APP — AppBlocObserver
// ------------------------------------------------------------
// Global Bloc/Cubit lifecycle observer. Logs create · change ·
// transition · error · close in debug builds only. Installed in
// main() via `Bloc.observer = const AppBlocObserver()`.
//
// The onClose hook is load-bearing for the database-per-tenant
// model: when a tenant scope is torn down (ValueKey(tenantId)
// changes), every tenant-scoped Cubit closing should be visible
// here — the Phase 1.4 isolation acceptance relies on it.
//
// File placement:  lib/app/bloc/app_bloc_observer.dart
// ============================================================

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    if (kDebugMode) debugPrint('[Bloc] ++ ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (kDebugMode) debugPrint('[Bloc] ~~ ${bloc.runtimeType}  $change');
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    if (kDebugMode) debugPrint('[Bloc] >> ${bloc.runtimeType}  $transition');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) debugPrint('[Bloc] !! ${bloc.runtimeType}  $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    if (kDebugMode) debugPrint('[Bloc] -- ${bloc.runtimeType}');
  }
}
