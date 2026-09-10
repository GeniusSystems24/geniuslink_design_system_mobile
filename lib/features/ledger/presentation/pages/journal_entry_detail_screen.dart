// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
part of 'journal_screens.dart';

/// Public page boundary for [JournalEntryDetailView].
///
/// The page keeps the original screen API stable while delegating the
/// existing rendering and presentation state to the view component.
///
/// Example:
///
/// ```dart
/// JournalEntryDetailScreen(
///   entry: entry,
/// )
/// ```
class JournalEntryDetailScreen extends JournalEntryDetailView {
  const JournalEntryDetailScreen({required super.entry, super.key});
}
