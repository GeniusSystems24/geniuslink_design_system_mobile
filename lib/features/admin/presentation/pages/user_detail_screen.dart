part of 'users_screens.dart';

// componentized-by: dismantle_admin_auth_banking_pages.py
/// Page boundary for the user-detail experience.
///
/// The screen owns page-level lifecycle/state and delegates visual composition
/// to presentation widgets under `presentation/widgets`.
///
/// Example:
///
/// ```dart
/// const UserDetailScreen()
/// ```
class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  bool _twofa = true;

  @override
  Widget build(BuildContext context) {
    return UserDetailView(
      twoFactorEnabled: _twofa,
      onTwoFactorChanged: (value) => setState(() => _twofa = value),
    );
  }
}
