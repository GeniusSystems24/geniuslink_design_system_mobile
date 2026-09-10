// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
part of 'contacts_screens.dart';

/// Public page boundary for [ContactListView].
///
/// The page keeps the original screen API stable while delegating the
/// existing rendering and presentation state to the view component.
///
/// Example:
///
/// ```dart
/// ContactListScreen(
///   kind: kind,
///   detailKey: detailKey,
/// )
/// ```
class ContactListScreen extends ContactListView {
  const ContactListScreen({
    required super.kind,
    required super.detailKey,
    super.key,
  });
}
