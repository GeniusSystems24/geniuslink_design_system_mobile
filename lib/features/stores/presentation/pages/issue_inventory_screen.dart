part of 'stores_screens.dart';

// componentized-by: dismantle_more_reports_settings_stores.py
/// Route/page boundary for the IssueInventory feature view.
///
/// The screen preserves the existing public navigation API and delegates UI
/// composition to its corresponding `*View` widget.
///
/// Example:
///
/// ```dart
/// const IssueInventoryScreen()
/// ```
class IssueInventoryScreen extends StatelessWidget {

  const IssueInventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IssueInventoryView(
        key: key,
      );
  }
}
