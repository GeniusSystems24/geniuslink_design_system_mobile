// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';
import '../../../../shared/presentation/controllers/form_controller.dart';
import '../../domain/domain.dart';

Map<PermissionLevel, (Color, String)> permissionMeta(BuildContext context) {
  final theme = SuperMaterialThemeData.of(context).superTheme;
  return {
    PermissionLevel.full: (
      SuperMaterialThemeData.of(context).colorScheme.secondary,
      'Full',
    ),
    PermissionLevel.edit: (
      SuperMaterialThemeData.of(context).colorScheme.primary,
      'Edit',
    ),
    PermissionLevel.view: (theme.fg3, 'View'),
    PermissionLevel.none: (theme.fg4, '—'),
  };
}

class RolesPermissionsView extends StatelessWidget {
  final FormController controller;

  const RolesPermissionsView({required this.controller, super.key});
  @override
  Widget build(BuildContext context) {
    final form = controller;
    return ListenableBuilder(
      listenable: form,
      builder: (context, _) {
        final state = form.state;
        final role = state.value<String>('role') ?? 'Admin';
        final matrix =
            state.value<RolePermissionMatrix>('matrix') ??
            RolePermissionMatrix.defaults();
        final selectedIndex = matrix.roles.indexOf(role);
        final ri = selectedIndex < 0 ? 0 : selectedIndex;

        void cycle(String module) {
          form.setField('matrix', matrix.cycle(module, ri));
        }

        var accentColor = SuperMaterialThemeData.of(
          context,
        ).colorScheme.primary;
        return Scaffold(
          backgroundColor: SuperMaterialThemeData.of(
            context,
          ).colorScheme.surface,
          appBar: SuperAppBar(title: const Text('Roles & Permissions')),
          body: MScroll([
            SuperSectionCard2(
              trailing: (null),
              title: 'Select Role',
              subtitle: "Tap a module's badge to cycle its access level",
              initiallyExpanded: true,
              accentColor: accentColor,
              icon: null,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Segmented(
                    options: matrix.roles,
                    value: role,
                    onChange: (v) => form.setField('role', v),
                  ),
                ],
              ),
            ),
            SuperSectionCard2(
              trailing: (null),
              title: "",
              subtitle: (null),
              initiallyExpanded: true,
              accentColor: (null),
              icon: null,
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < matrix.modules.length; i++)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 13,
                      ),
                      decoration: BoxDecoration(
                        border: i < matrix.modules.length - 1
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            matrix.modules[i],
                            style: TextStyle(
                              fontSize: 14,
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
                            onTap: () => cycle(matrix.modules[i]),
                            child: () {
                              final lvl = matrix.levelFor(
                                matrix.modules[i],
                                ri,
                              );
                              final meta = permissionMeta(context)[lvl]!;
                              final hasColor = lvl != PermissionLevel.none;
                              return Container(
                                constraints: const BoxConstraints(minWidth: 72),
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: hasColor
                                      ? superCoreTint(meta.$1, 0x26)
                                      : Colors.transparent,
                                  border: hasColor
                                      ? null
                                      : Border.all(
                                          color: SuperMaterialThemeData.of(
                                            context,
                                          ).superTheme.border,
                                        ),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  meta.$2.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.4,
                                    fontFamily: SuperMaterialThemeData.of(
                                      context,
                                    ).textTheme.bodyMedium?.fontFamily,
                                    color: hasColor
                                        ? meta.$1
                                        : SuperMaterialThemeData.of(
                                            context,
                                          ).superTheme.fg4,
                                  ),
                                ),
                              );
                            }(),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Wrap(
                spacing: 18,
                runSpacing: 8,
                children: [
                  for (final e in permissionMeta(context).entries)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 9,
                          height: 9,
                          decoration: BoxDecoration(
                            color: e.key == PermissionLevel.none
                                ? Colors.transparent
                                : e.value.$1,
                            border: e.key == PermissionLevel.none
                                ? Border.all(
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).superTheme.borderStrong,
                                  )
                                : null,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 7),
                        Text(
                          e.value.$2 == '—' ? 'No access' : e.value.$2,
                          style: TextStyle(
                            fontSize: 11.5,
                            color: SuperMaterialThemeData.of(
                              context,
                            ).superTheme.fg2,
                            fontFamily: SuperMaterialThemeData.of(
                              context,
                            ).textTheme.bodyMedium?.fontFamily,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            MBtn(
              'Save Permissions',
              icon: 'check',
              full: true,
              onTap: form.submit,
            ),
          ]),
        );
      },
    );
  }
}
