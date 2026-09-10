part of 'settings_org_screens.dart';

// componentized-by: dismantle_more_reports_settings_stores.py
/// Route/page boundary for the CurrenciesSettings feature view.
///
/// The screen preserves the existing public navigation API and delegates UI
/// composition to its corresponding `*View` widget.
///
/// Example:
///
/// ```dart
/// const CurrenciesSettingsScreen()
/// ```
class CurrenciesSettingsScreen extends StatelessWidget {

  const CurrenciesSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CurrenciesSettingsView(
        key: key,
      );
  }
}
