
part of 'settings_platform_screens.dart';

class IntegrationsScreen extends StatelessWidget {
  final List<IntegrationDefinition> integrations;

  const IntegrationsScreen({required this.integrations, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormCubit>(
      create: (_) => FormCubit(initial: {'state': {for (final item in integrations) item.id: item.connected}}, onSubmit: (_) async {}),
      child: IntegrationsView(integrations: integrations),
    );
  }
}
