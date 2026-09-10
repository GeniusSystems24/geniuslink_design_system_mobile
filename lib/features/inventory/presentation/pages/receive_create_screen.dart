// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
import '../widgets/page_views/receive_create_screen_view.dart';
export '../widgets/page_views/receive_create_screen_view.dart';

/// Public page boundary for [ReceiveCreateView].
///
/// The page keeps the original screen API stable while delegating the
/// existing rendering and presentation state to the view component.
///
/// Example:
///
/// ```dart
/// const ReceiveCreateScreen()
/// ```
class ReceiveCreateScreen extends ReceiveCreateView {
  const ReceiveCreateScreen({super.onSubmit, super.key});
}
