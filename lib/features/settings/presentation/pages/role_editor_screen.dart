
part of 'settings_team_screens.dart';

class RoleEditorScreen extends StatelessWidget {
  final List<RoleModuleDefinition> modules;
  final Map<String, RoleAccess> initialAccess;

  const RoleEditorScreen({required this.modules, this.initialAccess = const {}, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormCubit>(
      create: (_) => FormCubit(initial: {'perms': {for (final module in modules) module.id: (initialAccess[module.id] ?? const RoleAccess()).toList()}}, onSubmit: (_) async {}),
      child: RoleEditorView(modules: modules),
    );
  }
}
