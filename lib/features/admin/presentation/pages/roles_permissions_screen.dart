import 'package:flutter/material.dart';

import '../../../../shared/presentation/controllers/form_controller.dart';
import '../../domain/domain.dart';
import '../widgets/roles_permissions_view.dart';

/// Page boundary that owns role-permission form-controller lifecycle.
///
/// The screen owns page-level lifecycle/state and delegates visual composition
/// to presentation widgets under `presentation/widgets`.
///
/// Example:
///
/// ```dart
/// const RolesPermissionsScreen()
/// ```
class RolesPermissionsScreen extends StatefulWidget {
  final String initialRole;
  final RolePermissionMatrix? initialMatrix;
  final Future<void> Function(RolePermissionMatrix matrix)? onSave;

  const RolesPermissionsScreen({
    this.initialRole = 'Admin',
    this.initialMatrix,
    this.onSave,
    super.key,
  });

  @override
  State<RolesPermissionsScreen> createState() => _RolesPermissionsScreenState();
}

class _RolesPermissionsScreenState extends State<RolesPermissionsScreen> {
  late final FormController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FormController(
      initial: {
        'role': widget.initialRole,
        'matrix': widget.initialMatrix ?? RolePermissionMatrix.defaults(),
      },
      onSubmit: (values) async {
        final matrix = values['matrix'];
        if (matrix is RolePermissionMatrix && widget.onSave != null) {
          await widget.onSave!(matrix);
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      RolesPermissionsView(controller: _controller);
}
