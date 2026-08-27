// ============================================================
// GeniusLink Mobile — MTable (SuperTable adapter)
// MCol · mCellText · mcell · MTable
// File placement:  lib/design_system/adapters/table/m_table.dart
// ============================================================

import 'package:flutter/material.dart';
import 'package:super_table_field/super_table_field.dart';
import 'package:super_form_field/super_form_field.dart';
import 'package:super_core/super_core.dart';
import '../../components/feedback/m_feedback.dart';

// ============================================================
// Surface the full SuperField API through kit.dart.
// ============================================================
export 'package:super_table_field/super_table_field.dart'
    show
        SuperTable,
        SuperColumn,
        SuperTableController,
        SuperRow,
        SuperTableMode,
        SuperSelectionMode,
        SuperColumnType,
        SuperAlign,
        CellPos,
        SuperCell,
        SuperCellCondition,
        CellStyle,
        SuperTextColumn,
        SuperNumberColumn,
        SuperCurrencyColumn,
        SuperEnumerationColumn,
        SuperComboColumn,
        SuperComputedColumn,
        SuperDateColumn,
        SuperTimeColumn,
        SuperLinkColumn,
        SuperCheckboxColumn,
        SuperProgressColumn,
        SuperReadonlyColumn,
        SuperAgg,
        SuperPill,
        SuperTableSkin,
        SuperDensity;

// ============================================================
// MTable — mobile wrapper over the design-system SuperTable
// ------------------------------------------------------------
// For the genuinely tabular surfaces on mobile (trial balance,
// exchange rates, journal lines, valuation …). One pre-built
// widget per column — cells render via typed columns from the
// SuperTable controller, with click-to-sort headers, TSV copy,
// an opt-in quick-search bar and whole-row tap (onRowTap).
// ============================================================

/// Column descriptor for [MTable]. [flex] (proportional) or [fixed] (px).
/// Sortable by default; right-aligned or [numeric] columns sort numerically.
/// Pass `sortable:false` to opt out.
///
/// Use [styles] for conditional cell styling (foreground/background/weight per
/// cell based on a condition lambda). Available through the `kit.dart` barrel.
class MCol {
  final String key;
  final String label;
  final int flex;
  final double? fixed;
  final TextAlign align;
  final bool sortable;
  final bool numeric;
  final bool mono;
  final bool bold;
  final String Function(dynamic value)? format;
  final Map<SuperCellCondition, CellStyle>? styles;

  const MCol(
    this.key,
    this.label, {
    this.flex = 1,
    this.fixed,
    this.align = TextAlign.left,
    this.sortable = true,
    bool? numeric,
    this.mono = false,
    this.bold = false,
    this.format,
    this.styles,
  }) : numeric = numeric ?? (align == TextAlign.right);
}

// ── backward-compat helpers ─────────────────────────────────

/// Best-effort plain text of a built cell widget. Kept for backward
/// compatibility; new code should rely on the data-driven SuperTable.
String mCellText(Widget? w) {
  if (w == null) return '';
  if (w is Text) return w.data ?? (w.textSpan?.toPlainText() ?? '');
  if (w is Pill) return w.label;
  if (w is RichText) return w.text.toPlainText();
  if (w is Padding) return mCellText(w.child);
  if (w is Align) return mCellText(w.child);
  if (w is Container) return mCellText(w.child);
  if (w is SizedBox) return mCellText(w.child);
  if (w is ConstrainedBox) return mCellText(w.child);
  if (w is DefaultTextStyle) return mCellText(w.child);
  if (w is Flexible) return mCellText(w.child);
  if (w is ClipRRect) return mCellText(w.child);
  if (w is FittedBox) return mCellText(w.child);
  if (w is Flex) {
    for (final c in w.children) {
      final s = mCellText(c);
      if (s.isNotEmpty) return s;
    }
  }
  if (w is Wrap) {
    for (final c in w.children) {
      final s = mCellText(c);
      if (s.isNotEmpty) return s;
    }
  }
  if (w is Stack) {
    for (final c in w.children) {
      final s = mCellText(c);
      if (s.isNotEmpty) return s;
    }
  }
  return '';
}

/// Styled text cell for an [MTable] row. Kept for backward compatibility.
Widget mcell(
  String text, {
  bool mono = false,
  bool muted = false,
  bool bold = false,
  Color? color,
  TextAlign align = TextAlign.left,
}) {
  return Builder(
    builder: (context) {
      final theme = SuperMaterialThemeData.of(context).superTheme;
      return Text(
        text,
        textAlign: align,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontFamily: mono
              ? SuperMaterialThemeData.of(
                  context,
                ).textTheme.bodyMedium?.fontFamily
              : SuperMaterialThemeData.of(
                  context,
                ).textTheme.bodyMedium?.fontFamily,
          fontSize: 12.5,
          fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
          color: color ?? (muted ? theme.fg3 : theme.fg1),
        ),
      );
    },
  );
}

// ── main widget ──────────────────────────────────────────────

class MTable extends StatefulWidget {
  final List<MCol> columns;
  final List<Map<String, dynamic>> rows;
  final bool sortable;
  final bool showSearch;
  final String searchHint;
  final String itemNoun;
  final String itemNounPlural;
  final void Function(int rowIndex)? onRowTap;

  const MTable({
    super.key,
    required this.columns,
    required this.rows,
    this.sortable = true,
    this.showSearch = false,
    this.searchHint = 'Search\u2026',
    this.itemNoun = 'row',
    this.itemNounPlural = 'rows',
    this.onRowTap,
  });

  @override
  State<MTable> createState() => _MTableState();
}

class _MTableState extends State<MTable> {
  late SuperTableController<Map<String, dynamic>> _controller;
  final SuperTextFieldController _searchCtrl = SuperTextFieldController();

  @override
  void initState() {
    super.initState();
    _controller = _buildController();
  }

  @override
  void didUpdateWidget(MTable old) {
    super.didUpdateWidget(old);
    if (widget.rows != old.rows) {
      _controller.updateRows(widget.rows.map((r) => SuperRow.map(r)).toList());
    }
    if (widget.sortable != old.sortable) {
      _controller.updateColumns(_buildColumns());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  // ── column construction ──

  List<SuperColumn> _buildColumns() {
    return [for (final col in widget.columns) _buildColumn(col)];
  }

  SuperColumn _buildColumn(MCol col) {
    final w = col.fixed ?? (col.flex * 120).toDouble();
    final sa = switch (col.align) {
      TextAlign.right => SuperAlign.end,
      TextAlign.center => SuperAlign.center,
      _ => SuperAlign.start,
    };
    final sortable = widget.sortable && col.sortable && col.label.isNotEmpty;

    final fmt = col.format;

    if (col.numeric) {
      if (fmt != null) {
        return SuperColumn<num>(
          key: col.key,
          label: col.label,
          type: SuperColumnType.number,
          width: w,
          align: sa,
          sortable: sortable,
          decimals: 2,
          format: (v, _) => fmt(v),
          styles: col.styles,
        );
      }
      return SuperNumberColumn<num>(
        key: col.key,
        label: col.label,
        width: w,
        align: sa,
        sortable: sortable,
        decimals: 2,
        styles: col.styles,
      );
    }
    if (fmt != null) {
      return SuperColumn<String>(
        key: col.key,
        label: col.label,
        type: SuperColumnType.text,
        width: w,
        align: sa,
        sortable: sortable,
        mono: col.mono,
        format: (v, _) => fmt(v),
        styles: col.styles,
      );
    }
    return SuperTextColumn(
      key: col.key,
      label: col.label,
      width: w,
      align: sa,
      sortable: sortable,
      mono: col.mono,
      styles: col.styles,
    );
  }

  SuperTableController<Map<String, dynamic>> _buildController() {
    return SuperTableController<Map<String, dynamic>>(
      mode: SuperTableMode.readable,
      selectionMode: widget.onRowTap != null
          ? SuperSelectionMode.singleRow
          : SuperSelectionMode.singleCell,
      columns: _buildColumns(),
      rows: widget.rows.map((r) => SuperRow.map(r)).toList(),
    );
  }

  // ── height calculation ──

  double get _tableHeight {
    const headH = 38.0;
    const rowH = 40.0;
    final n = widget.rows.length.clamp(1, 20);
    return (headH + n * rowH + 2).clamp(60.0, 520.0);
  }

  // ── search bar ──

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SuperTextFormField(
        controller: _searchCtrl,
        decoration: InputDecoration(
          hintText: widget.searchHint,
          prefixIcon: const Icon(Icons.search_rounded, size: 18),
        ),
        clearable: true,
        density: FieldDensity.compact,
        onChanged: _controller.setSearch,
      ),
    );
  }

  // ── build ──

  @override
  Widget build(BuildContext context) {
    // Table needs bounded height.  When the parent is unbounded (e.g. inside a
    // shrink-wrapped card column) we use a calculated SizedBox; callers inside
    // a bounded parent (e.g. a layout with Expanded) should set showSearch and
    // wrap MTable in Flexible themselves.
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.showSearch) _buildSearchBar(),
        SizedBox(
          height: _tableHeight,
          child: SuperTable<Map<String, dynamic>>(
            controller: _controller,
            density: SuperDensity.comfortable,
            numbered: widget.onRowTap != null,
            showTypeTags: false,
            showTotals: false,
            showFooter: false,
            columnFilters: false,
            advancedFilter: false,
            formulaBar: false,
            rowMenuBuilder: widget.onRowTap != null ? _rowMenu : null,
          ),
        ),
      ],
    );
  }

  List<SuperMenuEntry> _rowMenu(
    SuperRowMenuContext<Map<String, dynamic>> ctx,
    List<SuperMenuEntry> defaults,
  ) {
    return [
      ...defaults,
      SuperMenuEntry(
        label: 'Open',
        icon: Icons.open_in_new_rounded,
        onTap: () => widget.onRowTap!(ctx.rowIndex),
      ),
    ];
  }
}
