part of 'settings_platform_screens.dart';

class BackupScreen extends StatelessWidget {
  const BackupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormCubit>(
      create: (_) => FormCubit(initial: const {
        'auto': true,
        'scope': {'Ledger': true, 'Inventory': true, 'Contacts': true, 'Documents': false},
      }, onSubmit: (_) async {}),
      child: const BackupView(),
    );
  }
}
