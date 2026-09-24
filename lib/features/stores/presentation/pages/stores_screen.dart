part of 'stores_screens.dart';

// componentized-by: dismantle_more_reports_settings_stores.py
/// Route/page boundary for the Stores feature view.
///
/// The screen preserves the existing public navigation API and delegates UI
/// composition to its corresponding `*View` widget.
///
/// Example:
///
/// ```dart
/// StoresScreen(
///   stores: stores,
///   onStoreSelected: onStoreSelected,
/// )
/// ```
class StoresScreen extends StatelessWidget {
  final List<StoreSummary> stores;
  final ValueChanged<StoreSummary>? onStoreSelected;

  const StoresScreen({required this.stores, this.onStoreSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return StoresView(
      key: key,
      stores: stores,
      onStoreSelected: onStoreSelected,
    );
  }
}
