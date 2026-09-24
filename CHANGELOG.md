# Changelog

<!-- migration-1.0.1-super-table-field:start -->
## 1.0.1 - 2026-09-24

### Changed

- Upgraded `super_table_field` from `3.1.1` to `3.2.0`.
- Ensured the direct `super_auto_suggestion_box` dependency is compatible with
  `super_table_field 3.2.0` (`>=1.6.0 <2.0.0`).
- Updated custom suggestion-builder callbacks to receive `BuildContext` as the
  first parameter where required by the new autocomplete integration.
- Kept existing `SuperComboColumn.advancedSearch` and
  `SuperComboColumn.leading` behavior unchanged.
- Updated project documentation for the `1.0.1` dependency baseline.
<!-- migration-1.0.1-super-table-field:end -->


<!-- geniuslink-v3.2.1 -->
## 3.2.1 - 2026-09-24

### Changed
- Upgraded `super_form_field` from `^1.14.0` to `^1.15.0`.
- Migrated `SuperSelectFormField` from deprecated `sources` / `SuperSelectListSource` usage to the `source` / `SuperSelectSources.list(...)` API.
- Exported the new `SuperSelectSources` and `SuperMultiSelectSources` factories from the shared form adapter and removed deprecated select-source exports.
- Upgraded `super_auto_suggestion_box` to `^1.7.0`.
- Migrated suggestion builders to the BuildContext-aware `(context, items, index, item)` signature required since `1.6.0`.
- Adopted the `1.7.0` remote-loading contract: context-aware remote callbacks, immediate local matching, remote-only debounce, and optional `minResult` behavior.
- Updated `README.md` with the v3.2.1 package baseline and migration rules.

### Validation
- Preserved `SuperChoiceFormField.options`; it is not part of the `super_form_field 1.15.0` source migration.
- No project usages of auto-suggestion `async`, `hybrid`, `remoteFallback`, `paged`, or direct `query` / `progressive` / `fetchPage` APIs were present at migration time, so no speculative remote-fetch thresholds were introduced.
