import 'package:flutter/material.dart';

import '../../../../shared/presentation/controllers/form_controller.dart';
import '../widgets/api_keys_view.dart';

class ApiKeysScreen extends StatefulWidget {
  const ApiKeysScreen({super.key});

  @override
  State<ApiKeysScreen> createState() => _ApiKeysScreenState();
}

class _ApiKeysScreenState extends State<ApiKeysScreen> {
  late final FormController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FormController(
      initial: const {
        'keys': [
          [
            'Production · Server',
            'gl_live_8f2a',
            'read, write',
            '2m ago',
            false,
          ],
          ['Reporting · Read-only', 'gl_live_3b71', 'read', 'Yesterday', false],
          ['Staging', 'gl_test_aa90', 'read, write', 'Never', false],
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
  Widget build(BuildContext context) => ApiKeysView(controller: _controller);
}
