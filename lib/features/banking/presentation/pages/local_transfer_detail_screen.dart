part of 'banking_transfer_screens.dart';

// componentized-by: dismantle_admin_auth_banking_pages.py
/// Banking page boundary for the local transfer detail flow.
///
/// The screen owns page-level lifecycle/state and delegates visual composition
/// to presentation widgets under `presentation/widgets`.
///
/// Example:
///
/// ```dart
/// const LocalTransferDetailScreen()
/// ```
class LocalTransferDetailScreen extends StatelessWidget {
  const LocalTransferDetailScreen({super.key});

  @override
  Widget build(BuildContext context) => const LocalTransferDetailView();
}
