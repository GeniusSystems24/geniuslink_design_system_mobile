part of 'banking_cash_screens.dart';

// componentized-by: dismantle_admin_auth_banking_pages.py
/// Banking page boundary for the create withdrawal flow.
///
/// The screen owns page-level lifecycle/state and delegates visual composition
/// to presentation widgets under `presentation/widgets`.
///
/// Example:
///
/// ```dart
/// const CreateWithdrawalScreen()
/// ```
class CreateWithdrawalScreen extends StatelessWidget {
  const CreateWithdrawalScreen({super.key});

  @override
  Widget build(BuildContext context) => const CreateWithdrawalView();
}
