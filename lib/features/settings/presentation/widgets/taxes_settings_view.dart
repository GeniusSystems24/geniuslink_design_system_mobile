// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';
import '../../../../shared/presentation/controllers/form_controller.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

/// Reusable presentation view for `TaxesSettingsScreen`.
///
/// The owning screen manages route/lifecycle concerns while this widget
/// renders the feature UI from the values/controllers supplied by its caller.
///
/// Example:
///
/// ```dart
/// // Supply the constructor arguments required by the view.
/// TaxesSettingsView(/* ... */)
/// ```
class TaxesSettingsView extends StatelessWidget {
  final FormController controller;

  const TaxesSettingsView({required this.controller, super.key});
  @override
  Widget build(BuildContext context) {
    final form = controller;
    return ListenableBuilder(
      listenable: form,
      builder: (context, _) {
        final state = form.state;
        final rules = [
          for (final r in (state.value<List>('rules') ?? const []))
            List<Object>.from(r as List),
        ];
        final active = rules.where((r) => r[4] as bool).length;
        List<List<Object>> clone() => [
          for (final r in rules) List<Object>.from(r),
        ];
        void toggle(int i) {
          final n = clone();
          n[i][4] = !(n[i][4] as bool);
          form.setField('rules', n);
        }

        void add() {
          final n = clone()..add(['New Rule', '0', 'VAT', '—', false]);
          form.setField('rules', n);
        }

        var accentColor = SuperMaterialThemeData.of(
          context,
        ).colorScheme.secondary;
        return Scaffold(
          backgroundColor: SuperMaterialThemeData.of(
            context,
          ).colorScheme.surface,
          appBar: SuperAppBar(
            title: const Text('Taxes'),
            actions: const [AppLanguageToggleButton(), AppThemeToggleButton()],
          ),
          body: MScroll([
            SuperSectionCard2(
              title: 'Tax Rules',
              subtitle: '$active active · applied at line level',
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
                        for (int i = 0; i < rules.length; i++)
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              border: i < rules.length - 1
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
                                      Row(
                                        children: [
                                          Text(
                                            rules[i][0] as String,
                                            style: TextStyle(
                                              fontSize: 13.5,
                                              fontWeight: FontWeight.w600,
                                              color: SuperMaterialThemeData.of(
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
                                          const SizedBox(width: 8),
                                          Pill(
                                            rules[i][2] as String,
                                            tone: rules[i][2] == 'VAT'
                                                ? PillTone.info
                                                : PillTone.warning,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        rules[i][3] as String,
                                        style: TextStyle(
                                          fontSize: 11.5,
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
                                Text(
                                  '${rules[i][1]}%',
                                  style: TextStyle(
                                    fontFamily: SuperMaterialThemeData.of(
                                      context,
                                    ).textTheme.bodyMedium?.fontFamily,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).superTheme.fg1,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                GestureDetector(
                                  onTap: () => toggle(i),
                                  child: Container(
                                    width: 42,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: rules[i][4] as bool
                                          ? SuperMaterialThemeData.of(
                                              context,
                                            ).colorScheme.primary
                                          : SuperMaterialThemeData.of(
                                              context,
                                            ).superTheme.inputBg,
                                      border: Border.all(
                                        color: rules[i][4] as bool
                                            ? SuperMaterialThemeData.of(
                                                context,
                                              ).colorScheme.primary
                                            : SuperMaterialThemeData.of(
                                                context,
                                              ).superTheme.borderStrong,
                                      ),
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: AnimatedAlign(
                                      duration: const Duration(
                                        milliseconds: 150,
                                      ),
                                      alignment: rules[i][4] as bool
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: Container(
                                        width: 18,
                                        height: 18,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 2,
                                        ),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
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
              'Add Tax Rule',
              variant: MBtnVariant.secondary,
              icon: 'plus',
              full: true,
              onTap: add,
            ),
            MBtn('Save Changes', icon: 'check', full: true, onTap: form.submit),
          ]),
        );
      },
    );
  }
}
