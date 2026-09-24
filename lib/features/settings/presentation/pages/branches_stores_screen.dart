part of 'settings_org_screens.dart';

// componentized-by: dismantle_more_reports_settings_stores.py
/// Route/page boundary for the BranchesStores feature view.
///
/// The screen preserves the existing public navigation API and delegates UI
/// composition to its corresponding `*View` widget.
///
/// Example:
///
/// ```dart
/// const BranchesStoresScreen()
/// ```
class BranchesStoresScreen extends StatelessWidget {
  const BranchesStoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BranchesStoresView(key: key);
  }
}
