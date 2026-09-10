// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
part of 'contacts_screens.dart';

/// Public page boundary for [CreateContactView].
///
/// The page keeps the original screen API stable while delegating the
/// existing rendering and presentation state to the view component.
///
/// Example:
///
/// ```dart
/// CreateContactScreen(
///   kind: kind,
/// )
/// ```
class CreateContactScreen extends CreateContactView {
  const CreateContactScreen({required super.kind, super.key});
}
