part of 'settings_platform_screens.dart';

// componentized-by: dismantle_more_reports_settings_stores.py
/// Route/page boundary for the Billing feature view.
///
/// The screen preserves the existing public navigation API and delegates UI
/// composition to its corresponding `*View` widget.
///
/// Example:
///
/// ```dart
/// const BillingScreen()
/// ```
class BillingScreen extends StatelessWidget {

  const BillingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BillingView(
        key: key,
      );
  }
}
