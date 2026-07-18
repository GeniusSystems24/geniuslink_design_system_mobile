part of 'settings_platform_screens.dart';

class IntegrationsScreen extends StatelessWidget {
  const IntegrationsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final init = <String, bool>{};
    final groups = _integrationGroups(context);
    for (final g in groups) { for (final it in g.$3) { init[it.$1] = it.$4; } }
    return BlocProvider<FormCubit>(
      create: (_) => FormCubit(initial: {'state': init}, onSubmit: (_) async {}),
      child: const IntegrationsView(),
    );
  }
}
