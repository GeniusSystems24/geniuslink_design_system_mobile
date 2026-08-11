import 'package:flutter/foundation.dart';

import '../../../core/state/load_status.dart';

/// Immutable state owned by [FormController].
///
/// This preserves the former page-scoped form state contract so views can
/// migrate without changing their business rules or field semantics.
class FormState {
  final Map<String, Object?> values;
  final Map<String, String> errors;
  final bool dirty;
  final LoadStatus status;

  const FormState({
    this.values = const {},
    this.errors = const {},
    this.dirty = false,
    this.status = LoadStatus.initial,
  });

  bool get isValid => errors.isEmpty;

  T? value<T>(String key) => values[key] as T?;

  FormState copyWith({
    Map<String, Object?>? values,
    Map<String, String>? errors,
    bool? dirty,
    LoadStatus? status,
  }) {
    return FormState(
      values: values ?? this.values,
      errors: errors ?? this.errors,
      dirty: dirty ?? this.dirty,
      status: status ?? this.status,
    );
  }
}

typedef FormValidator = Map<String, String> Function(Map<String, Object?>);
typedef FormSubmit = Future<void> Function(Map<String, Object?>);

/// Presentation controller for page-scoped forms.
///
/// Screens own and dispose this controller. Views observe it through
/// ListenableBuilder, keeping the MVC dependency direction explicit:
/// view -> controller -> business callback/state.
class FormController extends ChangeNotifier {
  final FormValidator? validator;
  final FormSubmit? onSubmit;
  final void Function(bool dirty)? onDirtyChanged;

  FormState _state;

  FormController({
    Map<String, Object?> initial = const {},
    this.validator,
    this.onSubmit,
    this.onDirtyChanged,
  }) : _state = FormState(values: initial);

  FormState get state => _state;

  void setField(String key, Object? value) {
    final values = {..._state.values, key: value};
    final wasDirty = _state.dirty;
    final errors = validator?.call(values) ?? _state.errors;
    _replace(_state.copyWith(values: values, dirty: true, errors: errors));
    if (!wasDirty) onDirtyChanged?.call(true);
  }

  bool validate() {
    final errors = validator?.call(_state.values) ?? const {};
    _replace(_state.copyWith(errors: errors));
    return errors.isEmpty;
  }

  Future<bool> submit() async {
    if (!validate()) return false;
    _replace(_state.copyWith(status: LoadStatus.loading));
    try {
      await onSubmit?.call(_state.values);
      _replace(_state.copyWith(status: LoadStatus.ready, dirty: false));
      onDirtyChanged?.call(false);
      return true;
    } catch (_) {
      _replace(_state.copyWith(status: LoadStatus.failure));
      return false;
    }
  }

  void reset() {
    if (_state.dirty) onDirtyChanged?.call(false);
    _replace(const FormState());
  }

  void _replace(FormState next) {
    _state = next;
    notifyListeners();
  }
}
