part of 'users_screens.dart';

class RolesPermissionsScreen extends StatelessWidget {
  const RolesPermissionsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormCubit>(
      create: (_) => FormCubit(
        initial: {'role': 'Admin', 'matrix': _defaultMatrix()},
        onSubmit: (_) async {}, // later: await rolesRepo.save(matrix)
      ),
      child: const RolesPermissionsView(),
    );
  }
}
