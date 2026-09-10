part of 'settings_team_screens.dart';

// componentized-by: dismantle_more_reports_settings_stores.py
/// Route/page boundary for the RolesList feature view.
///
/// The screen preserves the existing public navigation API and delegates UI
/// composition to its corresponding `*View` widget.
///
/// Example:
///
/// ```dart
/// const RolesListScreen()
/// ```
class RolesListScreen extends StatelessWidget {

  const RolesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RolesListView(
        key: key,
      );
  }
}
