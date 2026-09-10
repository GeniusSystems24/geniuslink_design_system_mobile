import 'package:flutter/material.dart';

import '../../../../shared/presentation/controllers/form_controller.dart';
import '../../domain/domain.dart';
import '../widgets/role_editor_view.dart';

/// Route/page boundary for the RoleEditor feature view.
///
/// The screen preserves the existing public navigation API and delegates UI
/// composition to its corresponding `*View` widget.
///
/// Example:
///
/// ```dart
/// RoleEditorScreen(
///   modules: modules,
///   initialAccess: initialAccess,
/// )
/// ```
class RoleEditorScreen extends StatefulWidget {
  final List<RoleModuleDefinition> modules;
  final Map<String, RoleAccess> initialAccess;

  const RoleEditorScreen({
    required this.modules,
    this.initialAccess = const {},
    super.key,
  });

  @override
  State<RoleEditorScreen> createState() => _RoleEditorScreenState();
}

class _RoleEditorScreenState extends State<RoleEditorScreen> {
  late final FormController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FormController(
      initial: {
        'perms': {
          for (final module in widget.modules)
            module.id: (widget.initialAccess[module.id] ?? const RoleAccess())
                .toList(),
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
  Widget build(BuildContext context) =>
      RoleEditorView(modules: widget.modules, controller: _controller);
}
