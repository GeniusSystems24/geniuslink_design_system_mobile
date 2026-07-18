// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../design_system/kit.dart';
import '../../../../core/bloc/form_cubit.dart';
import '../../../../workspace/presentation/bloc/tenant_cubit.dart';
import '../../../../workspace/presentation/bloc/tenant_state.dart';


const roleEditorModules = [
  'Accounts',
  'Stores',
  'Inventory',
  'Banking',
  'Ledger',
  'Reports',
  'Customers',
  'Suppliers',
  'Users',
  'Settings',
];

List<(String, Color)> roleEditorColumns(BuildContext context) {
  final colors = SuperMaterialThemeData.of(context).colorScheme;
  return [
    ('View', colors.secondary),
    ('Edit', colors.primary),
    ('Delete', colors.error),
  ];
}

class RoleEditorView extends StatelessWidget {
  const RoleEditorView({super.key});
  @override
  Widget build(BuildContext context) {
    final form = context.read<FormCubit>();
    return BlocBuilder<FormCubit, FormData>(
      builder: (context, state) {
        final perms = {for (final e in (state.value<Map>('perms') ?? const {}).entries) e.key as String: List<bool>.from(e.value as List)};
        final cols = roleEditorColumns(context);
        void toggle(String mod, int ci) {
          final n = {for (final e in perms.entries) e.key: [...e.value]};
          n[mod]![ci] = !n[mod]![ci];
          form.setField('perms', n);
        }
        return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Role Editor'),
      body: MScroll([
          MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Accountant', subtitle: '2 members assigned', children: [
            TInput(label: 'Role Name', defaultValue: 'Accountant'),
          ]),
          MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Permission Matrix', subtitle: 'Tap a cell to toggle access', pad: 8, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
                  child: Row(children: [
                    Expanded(child: Eyebrow('Module', color: SuperMaterialThemeData.of(context).superTheme.fg3, size: 9.5)),
                    for (final c in cols) SizedBox(width: 44, child: Center(child: Text(c.$1.toUpperCase(), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 9, letterSpacing: 0.4, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)))),
                  ]),
                ),
                for (int i = 0; i < roleEditorModules.length; i++)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(border: i < roleEditorModules.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                    child: Row(children: [
                      Expanded(child: Text(roleEditorModules[i], style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily))),
                      for (int ci = 0; ci < cols.length; ci++)
                        SizedBox(
                          width: 44,
                          child: Center(
                            child: GestureDetector(
                              onTap: () => toggle(roleEditorModules[i], ci),
                              child: Container(
                                width: 28, height: 28, alignment: Alignment.center,
                                decoration: BoxDecoration(color: perms[roleEditorModules[i]]![ci] ? cols[ci].$2 : SuperMaterialThemeData.of(context).superTheme.inputBg, border: Border.all(color: perms[roleEditorModules[i]]![ci] ? cols[ci].$2 : SuperMaterialThemeData.of(context).superTheme.borderStrong), borderRadius: BorderRadius.circular(7)),
                                child: perms[roleEditorModules[i]]![ci] ? const Icon(Icons.check_rounded, size: 15, color: Colors.white) : null,
                              ),
                            ),
                          ),
                        ),
                    ]),
                  ),
              ]),
            ),
          ]),
          MBtn('Save Role', icon: 'check', full: true, onTap: form.submit),
        ]),
    );
      },
    );
  }
}
