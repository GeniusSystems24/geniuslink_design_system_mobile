// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';
import '../../../../shared/presentation/controllers/form_controller.dart';

import 'platform_toggle.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

/// Reusable presentation view for `BackupScreen`.
///
/// The owning screen manages route/lifecycle concerns while this widget
/// renders the feature UI from the values/controllers supplied by its caller.
///
/// Example:
///
/// ```dart
/// // Supply the constructor arguments required by the view.
/// BackupView(/* ... */)
/// ```
class BackupView extends StatelessWidget {
  final FormController controller;

  const BackupView({required this.controller, super.key});
  @override
  Widget build(BuildContext context) {
    final form = controller;
    return ListenableBuilder(
      listenable: form,
      builder: (context, _) {
        final fstate = form.state;
        final auto = fstate.value<bool>('auto') ?? true;
        final scope = Map<String, bool>.from(
          fstate.value<Map>('scope') ?? const {},
        );
        void toggleScope(String k) =>
            form.setField('scope', {...scope, k: !(scope[k] ?? false)});
        var trailing = const Pill('Healthy');
        var accentColor = SuperMaterialThemeData.of(
          context,
        ).colorScheme.secondary;
        var accentColor2 = SuperMaterialThemeData.of(
          context,
        ).colorScheme.tertiary;
        var marker = SuperMaterialThemeData.of(context).colorScheme.primary;
        var icon = MIcons.of('download');
        return Scaffold(
          backgroundColor: SuperMaterialThemeData.of(
            context,
          ).colorScheme.surface,
          appBar: SuperAppBar(
            title: const Text('Backup'),
            actions: const [AppLanguageToggleButton(), AppThemeToggleButton()],
          ),
          body: MScroll([
            SuperSectionCard2(
              trailing: trailing,
              title: 'Automatic Backups',

              initiallyExpanded: true,
              accentColor: accentColor,

              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Daily encrypted snapshot',
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
                            const SizedBox(height: 3),
                            Text(
                              'Last · Dec 19 03:00 · 248 MB',
                              style: TextStyle(
                                fontFamily: SuperMaterialThemeData.of(
                                  context,
                                ).textTheme.bodyMedium?.fontFamily,
                                fontSize: 11,
                                color: SuperMaterialThemeData.of(
                                  context,
                                ).superTheme.fg3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PlatformToggle(
                        on: auto,
                        onTap: () => form.setField('auto', !auto),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SuperSectionCard2(
              title: 'Manual Export',
              subtitle: 'Download a portable copy',
              initiallyExpanded: true,
              accentColor: marker,
              icon: icon,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 7),
                        child: Eyebrow('Data Scope'),
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 4.4,
                        children: [
                          for (final k in scope.keys)
                            GestureDetector(
                              onTap: () => toggleScope(k),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 11,
                                ),
                                decoration: BoxDecoration(
                                  color: scope[k]!
                                      ? superCoreTint(
                                          SuperMaterialThemeData.of(
                                            context,
                                          ).colorScheme.primary,
                                          0x1F,
                                        )
                                      : SuperMaterialThemeData.of(
                                          context,
                                        ).superTheme.inputBg,
                                  border: Border.all(
                                    color: scope[k]!
                                        ? SuperMaterialThemeData.of(
                                            context,
                                          ).colorScheme.primary
                                        : SuperMaterialThemeData.of(
                                            context,
                                          ).superTheme.border,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 18,
                                      height: 18,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: scope[k]!
                                            ? SuperMaterialThemeData.of(
                                                context,
                                              ).colorScheme.primary
                                            : Colors.transparent,
                                        border: Border.all(
                                          color: scope[k]!
                                              ? SuperMaterialThemeData.of(
                                                  context,
                                                ).colorScheme.primary
                                              : SuperMaterialThemeData.of(
                                                  context,
                                                ).superTheme.borderStrong,
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: scope[k]!
                                          ? const Icon(
                                              Icons.check_rounded,
                                              size: 12,
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                    const SizedBox(width: 9),
                                    Text(
                                      k,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: SuperMaterialThemeData.of(
                                          context,
                                        ).superTheme.fg1,
                                        fontFamily: SuperMaterialThemeData.of(
                                          context,
                                        ).textTheme.bodyMedium?.fontFamily,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const TSelect(
                    label: 'Format',
                    value: 'CSV (zipped)',
                    options: ['CSV (zipped)', 'JSON', 'Excel (XLSX)'],
                  ),
                  const MBtn('Generate Export', icon: 'download', full: true),
                ],
              ),
            ),
            SuperSectionCard2(
              title: 'Export History',

              initiallyExpanded: true,
              accentColor: accentColor2,

              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        for (final f in const [
                          ('full-export-2025-12-15.zip', '248 MB · Dec 15'),
                          ('ledger-q4-2025.csv', '12 MB · Dec 02'),
                          ('contacts-2025-11.json', '1.1 MB · Nov 20'),
                        ])
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
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
                                Icon(
                                  MIcons.of('doc'),
                                  size: 16,
                                  color: SuperMaterialThemeData.of(
                                    context,
                                  ).colorScheme.primary,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    f.$1,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: SuperMaterialThemeData.of(
                                        context,
                                      ).textTheme.bodyMedium?.fontFamily,
                                      fontSize: 11.5,
                                      color: SuperMaterialThemeData.of(
                                        context,
                                      ).superTheme.fg1,
                                    ),
                                  ),
                                ),
                                Text(
                                  f.$2,
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
                                const SizedBox(width: 10),
                                Icon(
                                  MIcons.of('download'),
                                  size: 15,
                                  color: SuperMaterialThemeData.of(
                                    context,
                                  ).superTheme.fg3,
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: superCoreTint(
                  SuperMaterialThemeData.of(context).colorScheme.error,
                  0x0F,
                ),
                border: Border.all(
                  color: superCoreTint(
                    SuperMaterialThemeData.of(context).colorScheme.error,
                    0x4D,
                  ),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delete workspace',
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
                        const SizedBox(height: 2),
                        Text(
                          '30-day grace period.',
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
                  const MBtn(
                    'Delete',
                    variant: MBtnVariant.danger,
                    icon: 'trash',
                  ),
                ],
              ),
            ),
          ]),
        );
      },
    );
  }
}
