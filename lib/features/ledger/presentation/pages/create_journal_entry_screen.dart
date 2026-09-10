// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
part of 'journal_screens.dart';

/// Public page boundary for [CreateJournalEntryView].
///
/// The page keeps the original screen API stable while delegating the
/// existing rendering and presentation state to the view component.
///
/// Example:
///
/// ```dart
/// CreateJournalEntryScreen(
///   accounts: accounts,
/// )
/// ```
class CreateJournalEntryScreen extends CreateJournalEntryView {
  const CreateJournalEntryScreen({
    required super.accounts,
    super.initialLines = const [],
    super.key,
  });
}
