// ============================================================
// GeniusLink Mobile — MTable (ReadableTable adapter)
// MCol · mCellText · mcell · MTable
// File placement:  lib/design_system/adapters/table/m_table.dart
// ============================================================

import 'package:flutter/material.dart';
import 'package:geniuslink_design_system/geniuslink_design_system.dart';
import '../../tokens/m_colors.dart';
import '../../components/feedback/m_feedback.dart';

// ============================================================
// MTable — mobile wrapper over the design-system ReadableTable
// ------------------------------------------------------------
// For the genuinely tabular surfaces on mobile (trial balance,
// exchange rates, journal lines, valuation …). One pre-built
// widget per column — cells render as before, now inside the DS
// grid with click-to-sort headers + TSV copy, an opt-in quick-
// search bar (showSearch) and whole-row tap (onRowTap). Card
// lists stay as cards; this is only for grids.
// ============================================================

/// Column descriptor for [MTable]. [flex] (proportional) or [fixed] (px).
/// Sortable by default (key derived from the cell's text); right-aligned or
/// [numeric] columns sort numerically. Pass `sortable:false` to opt out.
class MCol {
  final String label;
  final int flex;
  final double? fixed;
  final TextAlign align;
  final bool sortable;
  final bool numeric;
  const MCol(this.label, {this.flex = 1, this.fixed, this.align = TextAlign.left, this.sortable = true, bool? numeric})
      : numeric = numeric ?? (align == TextAlign.right);
}

/// Best-effort plain text of a built cell widget — powers the MTable sort key,
/// quick-search and TSV copy. Walks the wrappers our cells use.
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

num _mNumKey(String s) => double.tryParse(s.replaceAll(RegExp(r'[^0-9.\-]'), '')) ?? double.negativeInfinity;

/// Styled text cell for an [MTable] row.
Widget mcell(String text, {bool mono = false, bool muted = false, bool bold = false, Color? color, TextAlign align = TextAlign.left}) {
  return Text(text,
      textAlign: align,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: mono ? M.mono : M.body,
        fontSize: 12.5,
        fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
        color: color ?? (muted ? M.fg3 : M.fg1),
      ));
}

class MTable extends StatelessWidget {
  final List<MCol> columns;
  final List<List<Widget>> rows;
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
    this.searchHint = 'Search…',
    this.itemNoun = 'row',
    this.itemNounPlural = 'rows',
    this.onRowTap,
  });

  @override
  Widget build(BuildContext context) {
    return ReadableTable<List<Widget>>(
      columns: [
        for (var i = 0; i < columns.length; i++)
          ReadableColumn<List<Widget>>(
            columns[i].label,
            width: columns[i].fixed,
            flex: columns[i].flex,
            align: switch (columns[i].align) {
              TextAlign.right => ReadableAlign.end,
              TextAlign.center => ReadableAlign.center,
              _ => ReadableAlign.start,
            },
            sortable: sortable && columns[i].sortable && columns[i].label.isNotEmpty,
            sortKey: (row) {
              final t = i < row.length ? mCellText(row[i]) : '';
              return (columns[i].numeric ? _mNumKey(t) : t.toLowerCase()) as Comparable<dynamic>?;
            },
            copyText: (row) => i < row.length ? mCellText(row[i]) : '',
            cell: (ctx, row) => i < row.length ? row[i] : const SizedBox.shrink(),
          ),
      ],
      rows: rows,
      hoverHighlight: true,
      rowMinHeight: 0,
      cellPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      selectionMode: onRowTap != null ? ReadableSelectionMode.singleRow : ReadableSelectionMode.none,
      onRowTap: onRowTap == null ? null : (row, i) => onRowTap!(i),
      showFilterBar: showSearch,
      filterSearchHint: searchHint,
      filterItemNoun: itemNoun,
      filterItemNounPlural: itemNounPlural,
    );
  }
}
