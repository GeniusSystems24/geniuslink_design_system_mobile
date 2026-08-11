import 'package:flutter/foundation.dart';

import '../../../core/state/load_status.dart';

typedef ListPredicate<T> =
    bool Function(T item, String query, Map<String, Object?> filters);

/// Immutable state exposed by [ListController].
class ListControllerState<T> {
  final LoadStatus status;
  final String query;
  final Map<String, Object?> filters;
  final List<T> all;
  final List<T> results;

  const ListControllerState({
    this.status = LoadStatus.initial,
    this.query = '',
    this.filters = const {},
    this.all = const [],
    this.results = const [],
  });

  ListControllerState<T> copyWith({
    LoadStatus? status,
    String? query,
    Map<String, Object?>? filters,
    List<T>? all,
    List<T>? results,
  }) {
    return ListControllerState<T>(
      status: status ?? this.status,
      query: query ?? this.query,
      filters: filters ?? this.filters,
      all: all ?? this.all,
      results: results ?? this.results,
    );
  }
}

/// Presentation controller for page-scoped searchable/filterable lists.
///
/// Screens own and dispose the controller. Views observe it with
/// ListenableBuilder, while data sourcing and predicate semantics remain
/// injected so feature behavior stays unchanged.
class ListController<T> extends ChangeNotifier {
  final List<T> Function() source;
  final ListPredicate<T> predicate;

  ListControllerState<T> _state;

  ListController({
    required this.source,
    required this.predicate,
    Map<String, Object?> initialFilters = const {},
  }) : _state = ListControllerState<T>(filters: initialFilters);

  ListControllerState<T> get state => _state;

  Future<void> load() async {
    _replace(_state.copyWith(status: LoadStatus.loading));
    final all = source();
    _replace(
      _state.copyWith(
        status: LoadStatus.ready,
        all: all,
        results: _apply(all, _state.query, _state.filters),
      ),
    );
  }

  void setQuery(String query) {
    _replace(
      _state.copyWith(
        query: query,
        results: _apply(_state.all, query, _state.filters),
      ),
    );
  }

  void setFilter(String key, Object? value) {
    final filters = {..._state.filters, key: value};
    _replace(
      _state.copyWith(
        filters: filters,
        results: _apply(_state.all, _state.query, filters),
      ),
    );
  }

  List<T> _apply(List<T> all, String query, Map<String, Object?> filters) =>
      all.where((item) => predicate(item, query, filters)).toList();

  void _replace(ListControllerState<T> next) {
    _state = next;
    notifyListeners();
  }
}
