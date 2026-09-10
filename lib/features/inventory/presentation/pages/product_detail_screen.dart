// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
import '../widgets/page_views/product_detail_screen_view.dart';
export '../widgets/page_views/product_detail_screen_view.dart';

/// Public page boundary for [ProductDetailView].
///
/// The page keeps the original screen API stable while delegating the
/// existing rendering and presentation state to the view component.
///
/// Example:
///
/// ```dart
/// ProductDetailScreen(
///   detail: detail,
/// )
/// ```
class ProductDetailScreen extends ProductDetailView {
  const ProductDetailScreen({required super.detail, super.key});
}
