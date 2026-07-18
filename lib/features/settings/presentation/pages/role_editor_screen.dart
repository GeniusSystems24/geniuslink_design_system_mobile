part of 'settings_team_screens.dart';

class RoleEditorScreen extends StatelessWidget {
  const RoleEditorScreen({super.key});
  static const _modules = ['Accounts', 'Stores', 'Inventory', 'Banking', 'Ledger', 'Reports', 'Customers', 'Suppliers', 'Users', 'Settings'];
  static List<(String, Color)> _cols(BuildContext context) {
    final colors = SuperMaterialThemeData.of(context).colorScheme;
    return [('View', colors.secondary), ('Edit', colors.primary), ('Delete', colors.error)];
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormCubit>(
      create: (_) => FormCubit(initial: const {
        'perms': {
          'Accounts': [true, true, false], 'Stores': [true, true, false], 'Inventory': [true, true, true], 'Banking': [true, true, false],
          'Ledger': [true, true, false], 'Reports': [true, false, false], 'Customers': [true, true, false], 'Suppliers': [true, true, false],
          'Users': [true, false, false], 'Settings': [false, false, false],
        }
      }, onSubmit: (_) async {}),
      child: const RoleEditorView(),
    );
  }
}
