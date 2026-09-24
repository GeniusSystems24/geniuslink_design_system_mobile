import 'package:flutter/material.dart';
import '../../../../shared/presentation/controllers/form_controller.dart';
import '../../../../design_system/kit.dart';
import '../../domain/domain.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

/// Reusable presentation view for `NotificationsScreen`.
///
/// The owning screen manages route/lifecycle concerns while this widget
/// renders the feature UI from the values/controllers supplied by its caller.
///
/// Example:
///
/// ```dart
/// // Supply the constructor arguments required by the view.
/// NotificationsView(/* ... */)
/// ```
class NotificationsView extends StatelessWidget {
  final List<NotificationCategory> categories;
  final List<NotificationChannel> channels;
  final FormController controller;

  const NotificationsView({
    required this.categories,
    required this.channels,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final form = controller;
    return ListenableBuilder(
      listenable: form,
      builder: (context, _) {
        final state = form.state;
        final raw = Map<String, dynamic>.from(
          state.value<Map>('prefs') ?? const {},
        );
        final prefs = {
          for (final category in categories)
            category.id: List<bool>.from(
              raw[category.id] as List? ??
                  List<bool>.filled(channels.length, false),
            ),
        };
        void toggle(String categoryId, int channelIndex) {
          final next = {
            for (final entry in prefs.entries) entry.key: [...entry.value],
          };
          next[categoryId]![channelIndex] = !next[categoryId]![channelIndex];
          form.setField('prefs', next);
        }

        var accentColor = SuperMaterialThemeData.of(
          context,
        ).colorScheme.primary;
        return Scaffold(
          backgroundColor: SuperMaterialThemeData.of(
            context,
          ).colorScheme.surface,
          appBar: SuperAppBar(
            title: const Text('Notifications'),
            actions: const [AppLanguageToggleButton(), AppThemeToggleButton()],
          ),
          body: MScroll([
            SuperSectionCard2(
              title: 'Preferences',
              subtitle: 'Toggle a channel per category',
              initiallyExpanded: true,
              accentColor: accentColor,

              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: SuperMaterialThemeData.of(
                                  context,
                                ).superTheme.border,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Spacer(),
                              for (final channel in channels)
                                SizedBox(
                                  width: 50,
                                  child: Center(
                                    child: Text(
                                      _channelLabel(channel).toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 9,
                                        letterSpacing: 0.4,
                                        color: SuperMaterialThemeData.of(
                                          context,
                                        ).superTheme.fg3,
                                        fontFamily: SuperMaterialThemeData.of(
                                          context,
                                        ).textTheme.bodyMedium?.fontFamily,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        for (
                          int categoryIndex = 0;
                          categoryIndex < categories.length;
                          categoryIndex++
                        )
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              border: categoryIndex < categories.length - 1
                                  ? Border(
                                      bottom: BorderSide(
                                        color: SuperMaterialThemeData.of(
                                          context,
                                        ).superTheme.border,
                                      ),
                                    )
                                  : null,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        categories[categoryIndex].title,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: SuperMaterialThemeData.of(
                                            context,
                                          ).superTheme.fg1,
                                          fontFamily: SuperMaterialThemeData.of(
                                            context,
                                          ).textTheme.bodyMedium?.fontFamily,
                                        ),
                                      ),
                                      const SizedBox(height: 1),
                                      Text(
                                        categories[categoryIndex].description,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: SuperMaterialThemeData.of(
                                            context,
                                          ).superTheme.fg3,
                                          fontFamily: SuperMaterialThemeData.of(
                                            context,
                                          ).textTheme.bodyMedium?.fontFamily,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                for (
                                  int channelIndex = 0;
                                  channelIndex < channels.length;
                                  channelIndex++
                                )
                                  SizedBox(
                                    width: 50,
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () => toggle(
                                          categories[categoryIndex].id,
                                          channelIndex,
                                        ),
                                        child: Container(
                                          width: 26,
                                          height: 26,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color:
                                                prefs[categories[categoryIndex]
                                                    .id]![channelIndex]
                                                ? SuperMaterialThemeData.of(
                                                    context,
                                                  ).colorScheme.primary
                                                : SuperMaterialThemeData.of(
                                                    context,
                                                  ).superTheme.inputBg,
                                            border: Border.all(
                                              color:
                                                  prefs[categories[categoryIndex]
                                                      .id]![channelIndex]
                                                  ? SuperMaterialThemeData.of(
                                                      context,
                                                    ).colorScheme.primary
                                                  : SuperMaterialThemeData.of(
                                                      context,
                                                    ).superTheme.borderStrong,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              7,
                                            ),
                                          ),
                                          child:
                                              prefs[categories[categoryIndex]
                                                  .id]![channelIndex]
                                              ? const Icon(
                                                  Icons.check_rounded,
                                                  size: 14,
                                                  color: Colors.white,
                                                )
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            MBtn(
              'Save Preferences',
              icon: 'check',
              full: true,
              onTap: form.submit,
            ),
          ]),
        );
      },
    );
  }

  String _channelLabel(NotificationChannel channel) => switch (channel) {
    NotificationChannel.email => 'Email',
    NotificationChannel.inApp => 'In-app',
    NotificationChannel.sms => 'SMS',
  };
}
