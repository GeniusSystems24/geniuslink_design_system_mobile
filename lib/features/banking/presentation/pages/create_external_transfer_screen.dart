part of 'banking_transfer_screens.dart';

// componentized-by: dismantle_admin_auth_banking_pages.py
/// Banking page boundary for the create external transfer flow.
///
/// The screen owns page-level lifecycle/state and delegates visual composition
/// to presentation widgets under `presentation/widgets`.
///
/// Example:
///
/// ```dart
/// const CreateExternalTransferScreen()
/// ```
class CreateExternalTransferScreen extends StatelessWidget {
  const CreateExternalTransferScreen({super.key});

  @override
  Widget build(BuildContext context) => const CreateExternalTransferView();
}
