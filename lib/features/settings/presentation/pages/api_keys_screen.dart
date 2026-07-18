part of 'settings_platform_screens.dart';

class ApiKeysScreen extends StatelessWidget {
  const ApiKeysScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormCubit>(
      create: (_) => FormCubit(initial: const {
        'keys': [
          ['Production · Server', 'gl_live_8f2a', 'read, write', '2m ago', false],
          ['Reporting · Read-only', 'gl_live_3b71', 'read', 'Yesterday', false],
          ['Staging', 'gl_test_aa90', 'read, write', 'Never', false],
        ]
      }, onSubmit: (_) async {}),
      child: const ApiKeysView(),
    );
  }
}
