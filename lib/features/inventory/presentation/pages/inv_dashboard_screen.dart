// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
import '../widgets/page_views/inv_dashboard_screen_view.dart';
export '../widgets/page_views/inv_dashboard_screen_view.dart';

/// Public page boundary for [InvDashboardView].
///
/// The page keeps the original screen API stable while delegating the
/// existing rendering and presentation state to the view component.
///
/// Example:
///
/// ```dart
/// const InvDashboardScreen()
/// ```
class InvDashboardScreen extends InvDashboardView {
  const InvDashboardScreen({super.key});
}
