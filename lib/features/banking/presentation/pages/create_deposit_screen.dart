part of 'banking_cash_screens.dart';

// componentized-by: dismantle_admin_auth_banking_pages.py
/// Banking page boundary for the create deposit flow.
///
/// The screen owns page-level lifecycle/state and delegates visual composition
/// to presentation widgets under `presentation/widgets`.
///
/// Example:
///
/// ```dart
/// const CreateDepositScreen()
/// ```
class CreateDepositScreen extends StatelessWidget {
  const CreateDepositScreen({super.key});

  @override
  Widget build(BuildContext context) => const CreateDepositView();
}
