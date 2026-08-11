import 'package:flutter/material.dart';

import '../../../../shared/presentation/controllers/form_controller.dart';
import '../../domain/domain.dart';
import '../widgets/integrations_view.dart';

class IntegrationsScreen extends StatefulWidget {
  final List<IntegrationDefinition> integrations;

  const IntegrationsScreen({required this.integrations, super.key});

  @override
  State<IntegrationsScreen> createState() => _IntegrationsScreenState();
}

class _IntegrationsScreenState extends State<IntegrationsScreen> {
  late final FormController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FormController(
      initial: {
        'state': {
          for (final item in widget.integrations) item.id: item.connected,
        },
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
  Widget build(BuildContext context) => IntegrationsView(
    integrations: widget.integrations,
    controller: _controller,
  );
}
