// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
import '../widgets/page_views/products_list_screen_view.dart';
export '../widgets/page_views/products_list_screen_view.dart';

/// Public page boundary for [ProductsListView].
///
/// The page keeps the original screen API stable while delegating the
/// existing rendering and presentation state to the view component.
///
/// Example:
///
/// ```dart
/// ProductsListScreen(
///   products: products,
/// )
/// ```
class ProductsListScreen extends ProductsListView {
  const ProductsListScreen({
    required super.products,
    super.onProductSelected,
    super.key,
  });
}
