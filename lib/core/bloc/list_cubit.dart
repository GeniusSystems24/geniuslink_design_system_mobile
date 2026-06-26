// ============================================================
// CORE / BLOC — ListCubit<T> (generic list + filter/search)
// ------------------------------------------------------------
// One reusable page-scoped cubit for every filterable list/table
// screen. Holds the async status, the search query, an open map of
// named filters, and the derived results.
//
// `source` stands in for a tenant-scoped repository read — today it
// returns a fixture synchronously; when the data layer lands it
// becomes `await repo.fetch()` with no change to call sites. Because
// the cubit is created per page INSIDE the tenant scope, switching
// tenants disposes it and the next tenant's list loads fresh.
//
// File placement:  lib/core/bloc/list_cubit.dart
// ============================================================

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'load_status.dart';

typedef ListPredicate<T> = bool Function(
  T item,
  String query,
  Map<String, Object?> filters,
);

class ListState<T> extends Equatable {
  final LoadStatus status;
  final String query;
  final Map<String, Object?> filters;
  final List<T> all;
  final List<T> results;

  const ListState({
    this.status = LoadStatus.initial,
    this.query = '',
    this.filters = const {},
    this.all = const [],
    this.results = const [],
  });

  ListState<T> copyWith({
    LoadStatus? status,
    String? query,
    Map<String, Object?>? filters,
    List<T>? all,
    List<T>? results,
  }) {
    return ListState<T>(
      status: status ?? this.status,
      query: query ?? this.query,
      filters: filters ?? this.filters,
      all: all ?? this.all,
      results: results ?? this.results,
    );
  }

  @override
  List<Object?> get props => [status, query, filters, all, results];
}

class ListCubit<T> extends Cubit<ListState<T>> {
  /// Stands in for a tenant-scoped repository read.
  final List<T> Function() source;
  final ListPredicate<T> predicate;

  ListCubit({
    required this.source,
    required this.predicate,
    Map<String, Object?> initialFilters = const {},
  }) : super(ListState<T>(filters: initialFilters));

  Future<void> load() async {
    emit(state.copyWith(status: LoadStatus.loading));
    final all = source(); // later: await repo.fetch()
    emit(state.copyWith(
      status: LoadStatus.ready,
      all: all,
      results: _apply(all, state.query, state.filters),
    ));
  }

  void setQuery(String q) => emit(state.copyWith(
        query: q,
        results: _apply(state.all, q, state.filters),
      ));

  void setFilter(String key, Object? value) {
    final f = {...state.filters, key: value};
    emit(state.copyWith(
      filters: f,
      results: _apply(state.all, state.query, f),
    ));
  }

  List<T> _apply(List<T> all, String q, Map<String, Object?> f) =>
      all.where((e) => predicate(e, q, f)).toList();
}
