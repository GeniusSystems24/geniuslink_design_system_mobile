// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
import '../widgets/page_views/create_product_screen_view.dart';
export '../widgets/page_views/create_product_screen_view.dart';

/// Public page boundary for [CreateProductView].
///
/// The page keeps the original screen API stable while delegating the
/// existing rendering and presentation state to the view component.
///
/// Example:
///
/// ```dart
/// const CreateProductScreen()
/// ```
class CreateProductScreen extends CreateProductView {
  const CreateProductScreen({super.key});
}
