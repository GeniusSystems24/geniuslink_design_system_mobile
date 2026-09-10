import 'package:flutter/material.dart';

import '../../../../shared/presentation/controllers/form_controller.dart';
import '../widgets/backup_view.dart';

/// Route/page boundary for the Backup feature view.
///
/// The screen preserves the existing public navigation API and delegates UI
/// composition to its corresponding `*View` widget.
///
/// Example:
///
/// ```dart
/// const BackupScreen()
/// ```
class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});

  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  late final FormController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FormController(
      initial: const {
        'auto': true,
        'scope': {
          'Ledger': true,
          'Inventory': true,
          'Contacts': true,
          'Documents': false,
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
  Widget build(BuildContext context) => BackupView(controller: _controller);
}
