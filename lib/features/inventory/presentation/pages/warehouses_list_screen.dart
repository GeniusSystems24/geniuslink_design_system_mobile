// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
import '../widgets/page_views/warehouses_list_screen_view.dart';
export '../widgets/page_views/warehouses_list_screen_view.dart';

/// Public page boundary for [WarehousesListView].
///
/// The page keeps the original screen API stable while delegating the
/// existing rendering and presentation state to the view component.
///
/// Example:
///
/// ```dart
/// const WarehousesListScreen()
/// ```
class WarehousesListScreen extends WarehousesListView {
  const WarehousesListScreen({super.key});
}
