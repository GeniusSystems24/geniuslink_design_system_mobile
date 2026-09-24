part of 'reports_screens.dart';

// componentized-by: dismantle_more_reports_settings_stores.py
/// Route/page boundary for the IncomeStatement feature view.
///
/// The screen preserves the existing public navigation API and delegates UI
/// composition to its corresponding `*View` widget.
///
/// Example:
///
/// ```dart
/// const IncomeStatementScreen()
/// ```
class IncomeStatementScreen extends StatelessWidget {
  const IncomeStatementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IncomeStatementView(key: key);
  }
}
