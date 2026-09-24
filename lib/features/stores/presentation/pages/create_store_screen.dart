part of 'stores_screens.dart';

// componentized-by: dismantle_more_reports_settings_stores.py
/// Route/page boundary for the CreateStore feature view.
///
/// The screen preserves the existing public navigation API and delegates UI
/// composition to its corresponding `*View` widget.
///
/// Example:
///
/// ```dart
/// const CreateStoreScreen()
/// ```
class CreateStoreScreen extends StatelessWidget {
  const CreateStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CreateStoreView(key: key);
  }
}
