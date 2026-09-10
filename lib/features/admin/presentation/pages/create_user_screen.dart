part of 'users_screens.dart';

// componentized-by: dismantle_admin_auth_banking_pages.py
/// Page boundary for inviting a new user.
///
/// The screen owns page-level lifecycle/state and delegates visual composition
/// to presentation widgets under `presentation/widgets`.
///
/// Example:
///
/// ```dart
/// const CreateUserScreen()
/// ```
class CreateUserScreen extends StatelessWidget {
  const CreateUserScreen({super.key});

  @override
  Widget build(BuildContext context) => const CreateUserView();
}
