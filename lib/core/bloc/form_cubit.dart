// ============================================================
// CORE / BLOC — FormCubit (field values · dirty · validation · submit)
// ------------------------------------------------------------
// One reusable page-scoped cubit for create/edit forms. Holds the
// field values, a dirty flag (true after the first real edit), the
// validation errors, and the submit status.
//
// `onDirtyChanged` lets a form report its dirty state UP to the
// shell — desktop wires it to `WorkspaceCubit.tabs.setDirty(...)`
// so the tab's unsaved-dot reflects ACTUAL edits instead of being
// force-set the moment a form tab opens. Created per page inside
// the tenant scope, so a tenant switch discards in-progress edits.
//
// `submit()` calls the injected `onSubmit` (later: a tenant-repo
// write) and tracks LoadStatus.
//
// File placement:  lib/core/bloc/form_cubit.dart
// ============================================================

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'load_status.dart';

class FormData extends Equatable {
  final Map<String, Object?> values;
  final Map<String, String> errors;
  final bool dirty;
  final LoadStatus status;

  const FormData({
    this.values = const {},
    this.errors = const {},
    this.dirty = false,
    this.status = LoadStatus.initial,
  });

  bool get isValid => errors.isEmpty;

  T? value<T>(String key) => values[key] as T?;

  FormData copyWith({
    Map<String, Object?>? values,
    Map<String, String>? errors,
    bool? dirty,
    LoadStatus? status,
  }) {
    return FormData(
      values: values ?? this.values,
      errors: errors ?? this.errors,
      dirty: dirty ?? this.dirty,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [values, errors, dirty, status];
}

typedef FormValidator = Map<String, String> Function(Map<String, Object?>);
typedef FormSubmit = Future<void> Function(Map<String, Object?>);

class FormCubit extends Cubit<FormData> {
  final FormValidator? validator;
  final FormSubmit? onSubmit;

  /// Reports dirty transitions to the shell (e.g. tab unsaved-dot).
  final void Function(bool dirty)? onDirtyChanged;

  FormCubit({
    Map<String, Object?> initial = const {},
    this.validator,
    this.onSubmit,
    this.onDirtyChanged,
  }) : super(FormData(values: initial));

  void setField(String key, Object? value) {
    final values = {...state.values, key: value};
    final wasDirty = state.dirty;
    final errors = validator?.call(values) ?? state.errors;
    emit(state.copyWith(values: values, dirty: true, errors: errors));
    if (!wasDirty) onDirtyChanged?.call(true);
  }

  bool validate() {
    final errors = validator?.call(state.values) ?? const {};
    emit(state.copyWith(errors: errors));
    return errors.isEmpty;
  }

  Future<bool> submit() async {
    if (!validate()) return false;
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      await onSubmit?.call(state.values); // later: await repo.save(...)
      emit(state.copyWith(status: LoadStatus.ready, dirty: false));
      onDirtyChanged?.call(false);
      return true;
    } catch (_) {
      emit(state.copyWith(status: LoadStatus.failure));
      return false;
    }
  }

  /// Discard edits (cancel) — clears the dirty flag for the shell.
  void reset() {
    if (state.dirty) onDirtyChanged?.call(false);
    emit(const FormData());
  }
}
