import 'package:flutter/material.dart';
import '../../../../shared/presentation/controllers/form_controller.dart';
import '../../../../design_system/kit.dart';
import '../../domain/domain.dart';

class RoleEditorView extends StatelessWidget {
  final List<RoleModuleDefinition> modules;
  final FormController controller;

  const RoleEditorView({
    required this.modules,
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
        final permissions = {
          for (final entry in (state.value<Map>('perms') ?? const {}).entries)
            entry.key as String: List<bool>.from(entry.value as List),
        };
        final columns = <(String, Color)>[
          ('View', SuperMaterialThemeData.of(context).colorScheme.secondary),
          ('Edit', SuperMaterialThemeData.of(context).colorScheme.primary),
          ('Delete', SuperMaterialThemeData.of(context).colorScheme.error),
        ];
        void toggle(String moduleId, int columnIndex) {
          final next = {
            for (final entry in permissions.entries)
              entry.key: [...entry.value],
          };
          next[moduleId]![columnIndex] = !next[moduleId]![columnIndex];
          form.setField('perms', next);
        }

        var accentColor = SuperMaterialThemeData.of(
          context,
        ).colorScheme.secondary;
        var accentColor2 = SuperMaterialThemeData.of(
          context,
        ).colorScheme.primary;
        return Scaffold(
          backgroundColor: SuperMaterialThemeData.of(
            context,
          ).colorScheme.surface,
          appBar: SuperAppBar(title: const Text('Role Editor')),
          body: MScroll([
            SuperSectionCard2(
              
              title: 'Accountant',
              subtitle: '2 members assigned',
              initiallyExpanded: true,
              accentColor: accentColor2,
              
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  TInput(label: 'Role Name', defaultValue: 'Accountant'),
                ],
              ),
            ),
            SuperSectionCard2(
              
              title: 'Permission Matrix',
              subtitle: 'Tap a cell to toggle access',
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
                              Expanded(
                                child: Eyebrow(
                                  'Module',
                                  color: SuperMaterialThemeData.of(
                                    context,
                                  ).superTheme.fg3,
                                  size: 9.5,
                                ),
                              ),
                              for (final column in columns)
                                SizedBox(
                                  width: 44,
                                  child: Center(
                                    child: Text(
                                      column.$1.toUpperCase(),
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
                        for (int i = 0; i < modules.length; i++)
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              border: i < modules.length - 1
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
                                  child: Text(
                                    modules[i].name,
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
                                ),
                                for (
                                  int columnIndex = 0;
                                  columnIndex < columns.length;
                                  columnIndex++
                                )
                                  SizedBox(
                                    width: 44,
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () =>
                                            toggle(modules[i].id, columnIndex),
                                        child: Container(
                                          width: 28,
                                          height: 28,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color:
                                                permissions[modules[i]
                                                    .id]![columnIndex]
                                                ? columns[columnIndex].$2
                                                : SuperMaterialThemeData.of(
                                                    context,
                                                  ).superTheme.inputBg,
                                            border: Border.all(
                                              color:
                                                  permissions[modules[i]
                                                      .id]![columnIndex]
                                                  ? columns[columnIndex].$2
                                                  : SuperMaterialThemeData.of(
                                                      context,
                                                    ).superTheme.borderStrong,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              7,
                                            ),
                                          ),
                                          child:
                                              permissions[modules[i]
                                                  .id]![columnIndex]
                                              ? const Icon(
                                                  Icons.check_rounded,
                                                  size: 15,
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
            MBtn('Save Role', icon: 'check', full: true, onTap: form.submit),
          ]),
        );
      },
    );
  }
}
