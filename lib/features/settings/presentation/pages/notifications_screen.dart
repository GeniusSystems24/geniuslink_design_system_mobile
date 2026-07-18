
part of 'settings_platform_screens.dart';

class NotificationsScreen extends StatelessWidget {
  final List<NotificationCategory> categories;
  final List<NotificationChannel> channels;
  final Map<String, Set<NotificationChannel>> initialPreferences;

  const NotificationsScreen({required this.categories, required this.channels, this.initialPreferences = const {}, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormCubit>(
      create: (_) => FormCubit(initial: {'prefs': {for (final category in categories) category.id: [for (final channel in channels) initialPreferences[category.id]?.contains(channel) ?? false]}}, onSubmit: (_) async {}),
      child: NotificationsView(categories: categories, channels: channels),
    );
  }
}
