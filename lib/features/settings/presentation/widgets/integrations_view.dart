import 'package:flutter/material.dart';

import '../../../../shared/presentation/controllers/form_controller.dart';
import '../../../../design_system/kit.dart';
import '../../domain/domain.dart';
import 'platform_mono_text.dart';
import 'platform_toggle.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

/// Reusable presentation view for `IntegrationsScreen`.
///
/// The owning screen manages route/lifecycle concerns while this widget
/// renders the feature UI from the values/controllers supplied by its caller.
///
/// Example:
///
/// ```dart
/// // Supply the constructor arguments required by the view.
/// IntegrationsView(/* ... */)
/// ```
class IntegrationsView extends StatelessWidget {
  final List<IntegrationDefinition> integrations;
  final FormController controller;

  const IntegrationsView({
    required this.integrations,
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
        final values = Map<String, bool>.from(
          state.value<Map>('state') ?? const {},
        );
        void toggle(String id) =>
            form.setField('state', {...values, id: !(values[id] ?? false)});
        return Scaffold(
          backgroundColor: SuperMaterialThemeData.of(
            context,
          ).colorScheme.surface,
          appBar: SuperAppBar(
            title: const Text('Integrations'),
            actions: const [AppLanguageToggleButton(), AppThemeToggleButton()],
          ),
          body: MScroll([
            for (final category in IntegrationCategory.values)
              if (integrations.any((item) => item.category == category))
                SuperSectionCard2(
                  title: _categoryLabel(category),

                  initiallyExpanded: true,
                  accentColor: _categoryColor(context, category),

                  padding: EdgeInsets.all(8),
                  child: SuperGrid(
                    scope: SuperGridScope.current,
                    children: [
                      SuperGridCell(
                        mobile: 4,
                        tablet: 8,
                        desktop: 12,
                        large: 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              for (final item in integrations.where(
                                (item) => item.category == category,
                              ))
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
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
                                      PlatformMonoText(
                                        name: item.name,
                                        tone: _categoryColor(context, category),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.name,
                                              style: TextStyle(
                                                fontSize: 13.5,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    SuperMaterialThemeData.of(
                                                      context,
                                                    ).superTheme.fg1,
                                                fontFamily:
                                                    SuperMaterialThemeData.of(
                                                          context,
                                                        )
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.fontFamily,
                                              ),
                                            ),
                                            const SizedBox(height: 1),
                                            Text(
                                              item.description,
                                              style: TextStyle(
                                                fontSize: 11.5,
                                                color:
                                                    SuperMaterialThemeData.of(
                                                      context,
                                                    ).superTheme.fg3,
                                                fontFamily:
                                                    SuperMaterialThemeData.of(
                                                          context,
                                                        )
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.fontFamily,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (values[item.id] == true)
                                        const Padding(
                                          padding: EdgeInsets.only(right: 8),
                                          child: Pill('On'),
                                        ),
                                      PlatformToggle(
                                        on: values[item.id] ?? false,
                                        onTap: () => toggle(item.id),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          ]),
        );
      },
    );
  }

  String _categoryLabel(IntegrationCategory category) => switch (category) {
    IntegrationCategory.accounting => 'Accounting',
    IntegrationCategory.payments => 'Payments',
    IntegrationCategory.operations => 'Operations',
  };
  Color _categoryColor(BuildContext context, IntegrationCategory category) =>
      switch (category) {
        IntegrationCategory.accounting => SuperMaterialThemeData.of(
          context,
        ).colorScheme.primary,
        IntegrationCategory.payments => SuperMaterialThemeData.of(
          context,
        ).colorScheme.secondary,
        IntegrationCategory.operations => SuperMaterialThemeData.of(
          context,
        ).colorScheme.tertiary,
      };
}
