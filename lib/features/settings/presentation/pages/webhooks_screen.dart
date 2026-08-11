import 'package:flutter/material.dart';

import '../../../../shared/presentation/controllers/form_controller.dart';
import '../widgets/webhooks_view.dart';

class WebhooksScreen extends StatefulWidget {
  const WebhooksScreen({super.key});

  @override
  State<WebhooksScreen> createState() => _WebhooksScreenState();
}

class _WebhooksScreenState extends State<WebhooksScreen> {
  late final FormController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FormController(
      initial: const {
        'hooks': [
          [
            'erp.acme.sa/hooks/postings',
            'journal.posted,deposit.created',
            true,
            '200 · 2m',
          ],
          [
            'api.najd.io/gl/inventory',
            'inventory.adjusted,transfer.created',
            true,
            '200 · 1h',
          ],
          [
            'hooks.slack.com/services/T0…',
            'approval.requested',
            false,
            '410 · 3d',
          ],
        ],
      },
      onSubmit: (_) async {},
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WebhooksView(controller: _controller);
}
