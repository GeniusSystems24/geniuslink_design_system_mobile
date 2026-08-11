// ============================================================
// CORE / STATE — LoadStatus
// ------------------------------------------------------------
// Framework-neutral lifecycle status shared by presentation controllers.
// ============================================================

enum LoadStatus { initial, loading, ready, failure }

extension LoadStatusX on LoadStatus {
  bool get isInitial => this == LoadStatus.initial;
  bool get isLoading => this == LoadStatus.loading;
  bool get isReady => this == LoadStatus.ready;
  bool get isFailure => this == LoadStatus.failure;
}
