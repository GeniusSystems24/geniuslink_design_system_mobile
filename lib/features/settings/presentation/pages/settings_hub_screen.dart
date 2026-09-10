part of 'settings_org_screens.dart';

// componentized-by: dismantle_more_reports_settings_stores.py
/// Route/page boundary for the SettingsHub feature view.
///
/// The screen preserves the existing public navigation API and delegates UI
/// composition to its corresponding `*View` widget.
///
/// Example:
///
/// ```dart
/// SettingsHubScreen(
///   sections: sections,
/// )
/// ```
class SettingsHubScreen extends StatelessWidget {

  final List<SettingsNavigationSection> sections;

  const SettingsHubScreen({
    this.sections = defaultSettingsNavigation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsHubView(
        key: key,
        sections: sections,
      );
  }
}
