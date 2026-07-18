part of 'settings_platform_screens.dart';

class WebhooksScreen extends StatelessWidget {
  const WebhooksScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormCubit>(
      create: (_) => FormCubit(initial: const {
        'hooks': [
          ['erp.acme.sa/hooks/postings', 'journal.posted,deposit.created', true, '200 · 2m'],
          ['api.najd.io/gl/inventory', 'inventory.adjusted,transfer.created', true, '200 · 1h'],
          ['hooks.slack.com/services/T0…', 'approval.requested', false, '410 · 3d'],
        ]
      }, onSubmit: (_) async {}),
      child: const WebhooksView(),
    );
  }
}
