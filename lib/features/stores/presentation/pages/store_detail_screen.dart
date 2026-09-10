part of 'stores_screens.dart';

// componentized-by: dismantle_more_reports_settings_stores.py
/// Route/page boundary for the StoreDetail feature view.
///
/// The screen preserves the existing public navigation API and delegates UI
/// composition to its corresponding `*View` widget.
///
/// Example:
///
/// ```dart
/// StoreDetailScreen(
///   store: store,
/// )
/// ```
class StoreDetailScreen extends StatelessWidget {

  final StoreSummary store;

  const StoreDetailScreen({required this.store, super.key});

  @override
  Widget build(BuildContext context) {
    return StoreDetailView(
        key: key,
        store: store,
      );
  }
}
