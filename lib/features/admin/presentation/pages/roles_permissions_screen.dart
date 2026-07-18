part of 'users_screens.dart';

class RolesPermissionsScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return BlocProvider<FormCubit>(
      create: (_) => FormCubit(
        initial: {
          'role': initialRole,
          'matrix': initialMatrix ?? RolePermissionMatrix.defaults(),
        },
        onSubmit: (values) async {
          final matrix = values['matrix'];
          if (matrix is RolePermissionMatrix && onSave != null) {
            await onSave!(matrix);
          }
        },
      ),
      child: const RolesPermissionsView(),
    );
  }
}
