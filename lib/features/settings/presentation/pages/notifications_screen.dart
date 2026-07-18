part of 'settings_platform_screens.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormCubit>(
      create: (_) => FormCubit(initial: const {
        'prefs': [[true, true, false], [true, true, true], [true, true, false], [true, true, true], [true, false, false]]
      }, onSubmit: (_) async {}),
      child: const NotificationsView(),
    );
  }
}
