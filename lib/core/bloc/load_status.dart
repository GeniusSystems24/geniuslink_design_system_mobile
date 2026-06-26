// ============================================================
// CORE — LoadStatus
// ------------------------------------------------------------
// Shared async-operation status used by Cubit/Bloc states across
// the app. Under the database-per-tenant model every tenant data
// read is async, so list / form / settings states carry one of
// these instead of bare booleans.
//
// File placement:  lib/core/bloc/load_status.dart
// ============================================================

enum LoadStatus { initial, loading, ready, failure }

extension LoadStatusX on LoadStatus {
  bool get isInitial => this == LoadStatus.initial;
  bool get isLoading => this == LoadStatus.loading;
  bool get isReady => this == LoadStatus.ready;
  bool get isFailure => this == LoadStatus.failure;
}
