// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
part of 'contacts_screens.dart';

/// Public page boundary for [ContactDetailView].
///
/// The page keeps the original screen API stable while delegating the
/// existing rendering and presentation state to the view component.
///
/// Example:
///
/// ```dart
/// ContactDetailScreen(
///   kind: kind,
/// )
/// ```
class ContactDetailScreen extends ContactDetailView {
  const ContactDetailScreen({
    required super.kind,
    super.contactIndex = 0,
    super.key,
  });
}
