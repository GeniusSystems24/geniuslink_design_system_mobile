// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
part of 'journal_screens.dart';

/// Public page boundary for [JournalListView].
///
/// The page keeps the original screen API stable while delegating the
/// existing rendering and presentation state to the view component.
///
/// Example:
///
/// ```dart
/// JournalListScreen(
///   entries: entries,
/// )
/// ```
class JournalListScreen extends JournalListView {
  const JournalListScreen({
    required super.entries,
    super.onEntrySelected,
    super.key,
  });
}
