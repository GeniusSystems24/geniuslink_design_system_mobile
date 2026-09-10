// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
import '../widgets/page_views/transfer_list_screen_view.dart';
export '../widgets/page_views/transfer_list_screen_view.dart';

/// Public page boundary for [TransferListView].
///
/// The page keeps the original screen API stable while delegating the
/// existing rendering and presentation state to the view component.
///
/// Example:
///
/// ```dart
/// const TransferListScreen()
/// ```
class TransferListScreen extends TransferListView {
  const TransferListScreen({super.key});
}
