// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
part of 'currencies_screens.dart';

/// Public page boundary for [CurrencyDetailView].
///
/// The page keeps the original screen API stable while delegating the
/// existing rendering and presentation state to the view component.
///
/// Example:
///
/// ```dart
/// CurrencyDetailScreen(
///   currency: currency,
/// )
/// ```
class CurrencyDetailScreen extends CurrencyDetailView {
  const CurrencyDetailScreen({required super.currency, super.key});
}
