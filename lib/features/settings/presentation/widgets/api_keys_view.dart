// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';
import '../../../../shared/presentation/controllers/form_controller.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

class ApiKeysView extends StatelessWidget {
  final FormController controller;

  const ApiKeysView({required this.controller, super.key});
  @override
  Widget build(BuildContext context) {
    final form = controller;
    return ListenableBuilder(
      listenable: form,
      builder: (context, _) {
        final fstate = form.state;
        final keys = [
          for (final k in (fstate.value<List>('keys') ?? const []))
            List<Object>.from(k as List),
        ];
        List<List<Object>> clone() => [
          for (final k in keys) List<Object>.from(k),
        ];
        void toggleReveal(int i) {
          final n = clone();
          n[i][4] = !(n[i][4] as bool);
          form.setField('keys', n);
        }

        void revoke(int i) {
          final n = clone()..removeAt(i);
          form.setField('keys', n);
        }

        var accentColor = SuperMaterialThemeData.of(
          context,
        ).colorScheme.secondary;
        return Scaffold(
          backgroundColor: SuperMaterialThemeData.of(
            context,
          ).colorScheme.surface,
          appBar: SuperAppBar(title: const Text('API Keys'), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
          body: MScroll([
            InfoNote(
              "A key's secret is shown only once at creation. Revoke and re-issue anytime.",
              tone: SuperMaterialThemeData.of(context).colorScheme.tertiary,
            ),
            SuperSectionCard2(
              title: '${keys.length} Active Keys',

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
                        for (int i = 0; i < keys.length; i++)
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              border: i < keys.length - 1
                                  ? Border(
                                      bottom: BorderSide(
                                        color: SuperMaterialThemeData.of(
                                          context,
                                        ).superTheme.border,
                                      ),
                                    )
                                  : null,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      keys[i][0] as String,
                                      style: TextStyle(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w600,
                                        color: SuperMaterialThemeData.of(
                                          context,
                                        ).superTheme.fg1,
                                        fontFamily: SuperMaterialThemeData.of(
                                          context,
                                        ).textTheme.bodyMedium?.fontFamily,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => revoke(i),
                                      child: Text(
                                        'Revoke',
                                        style: TextStyle(
                                          color: SuperMaterialThemeData.of(
                                            context,
                                          ).colorScheme.error,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: SuperMaterialThemeData.of(
                                            context,
                                          ).textTheme.bodyMedium?.fontFamily,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        keys[i][4] as bool
                                            ? '${keys[i][1]}_4d9e1c7b22f0'
                                            : '${keys[i][1]}••••••••',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: SuperMaterialThemeData.of(
                                            context,
                                          ).textTheme.bodyMedium?.fontFamily,
                                          fontSize: 11.5,
                                          color: SuperMaterialThemeData.of(
                                            context,
                                          ).superTheme.fg2,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => toggleReveal(i),
                                      child: Text(
                                        keys[i][4] as bool ? 'Hide' : 'Reveal',
                                        style: TextStyle(
                                          color: SuperMaterialThemeData.of(
                                            context,
                                          ).colorScheme.primary,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: SuperMaterialThemeData.of(
                                            context,
                                          ).textTheme.bodyMedium?.fontFamily,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${keys[i][2]} · used ${keys[i][3]}',
                                  style: TextStyle(
                                    fontFamily: SuperMaterialThemeData.of(
                                      context,
                                    ).textTheme.bodyMedium?.fontFamily,
                                    fontSize: 10.5,
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).superTheme.fg3,
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
            const MBtn('Create Key', icon: 'plus', full: true),
          ]),
        );
      },
    );
  }
}
