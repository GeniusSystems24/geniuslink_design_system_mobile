part of 'reports_screens.dart';

// componentized-by: dismantle_more_reports_settings_stores.py
/// Route/page boundary for the BalanceSheet feature view.
///
/// The screen preserves the existing public navigation API and delegates UI
/// composition to its corresponding `*View` widget.
///
/// Example:
///
/// ```dart
/// const BalanceSheetScreen()
/// ```
class BalanceSheetScreen extends StatelessWidget {
  const BalanceSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BalanceSheetView(key: key);
  }
}
