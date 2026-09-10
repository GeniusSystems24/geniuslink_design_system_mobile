// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
part of 'currencies_screens.dart';

/// Public page boundary for [CurrenciesListView].
///
/// The page keeps the original screen API stable while delegating the
/// existing rendering and presentation state to the view component.
///
/// Example:
///
/// ```dart
/// CurrenciesListScreen(
///   currencies: currencies,
/// )
/// ```
class CurrenciesListScreen extends CurrenciesListView {
  const CurrenciesListScreen({
    required super.currencies,
    super.onCurrencySelected,
    super.key,
  });
}
