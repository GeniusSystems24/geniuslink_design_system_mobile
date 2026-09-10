import 'package:flutter/material.dart';

import '../../../../shared/presentation/controllers/form_controller.dart';
import '../../domain/domain.dart';
import '../widgets/notifications_view.dart';

/// Route/page boundary for the Notifications feature view.
///
/// The screen preserves the existing public navigation API and delegates UI
/// composition to its corresponding `*View` widget.
///
/// Example:
///
/// ```dart
/// NotificationsScreen(
///   categories: categories,
///   channels: channels,
///   initialPreferences: initialPreferences,
/// )
/// ```
class NotificationsScreen extends StatefulWidget {
  final List<NotificationCategory> categories;
  final List<NotificationChannel> channels;
  final Map<String, Set<NotificationChannel>> initialPreferences;

  const NotificationsScreen({
    required this.categories,
    required this.channels,
    this.initialPreferences = const {},
    super.key,
  });

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late final FormController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FormController(
      initial: {
        'prefs': {
          for (final category in widget.categories)
            category.id: [
              for (final channel in widget.channels)
                widget.initialPreferences[category.id]?.contains(channel) ??
                    false,
            ],
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
  Widget build(BuildContext context) => NotificationsView(
    categories: widget.categories,
    channels: widget.channels,
    controller: _controller,
  );
}
