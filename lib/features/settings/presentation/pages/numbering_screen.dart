part of 'settings_org_screens.dart';

// componentized-by: dismantle_more_reports_settings_stores.py
/// Route/page boundary for the Numbering feature view.
///
/// The screen preserves the existing public navigation API and delegates UI
/// composition to its corresponding `*View` widget.
///
/// Example:
///
/// ```dart
/// const NumberingScreen()
/// ```
class NumberingScreen extends StatelessWidget {

  const NumberingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NumberingView(
        key: key,
      );
  }
}
