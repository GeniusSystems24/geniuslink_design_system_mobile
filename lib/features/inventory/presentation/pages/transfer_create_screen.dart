// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
import '../widgets/page_views/transfer_create_screen_view.dart';
export '../widgets/page_views/transfer_create_screen_view.dart';

/// Public page boundary for [TransferCreateView].
///
/// The page keeps the original screen API stable while delegating the
/// existing rendering and presentation state to the view component.
///
/// Example:
///
/// ```dart
/// const TransferCreateScreen()
/// ```
class TransferCreateScreen extends TransferCreateView {
  const TransferCreateScreen({super.onSubmit, super.key});
}
