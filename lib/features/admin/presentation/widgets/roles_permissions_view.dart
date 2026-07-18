// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../design_system/kit.dart';
import '../../../../core/bloc/form_cubit.dart';


final permissionOrder = ['none', 'view', 'edit', 'full'];

Map<String, (Color, String)> permissionMeta(BuildContext context) {
  final theme = SuperMaterialThemeData.of(context).superTheme;
  return {
    'full': (SuperMaterialThemeData.of(context).colorScheme.secondary, 'Full'),
    'edit': (SuperMaterialThemeData.of(context).colorScheme.primary, 'Edit'),
    'view': (theme.fg3, 'View'),
    'none': (theme.fg4, '—'),
  };
}

final roleModules = ['Accounts', 'Stores', 'Inventory', 'Banking', 'Ledger', 'Reports', 'Users'];
final roleNames = ['Admin', 'Controller', 'Accountant', 'Manager', 'Viewer'];

Map<String, List<String>> defaultPermissionsMatrix() => {
  'Accounts': ['full', 'edit', 'edit', 'view', 'view'],
  'Stores': ['full', 'edit', 'view', 'edit', 'view'],
  'Inventory': ['full', 'edit', 'edit', 'edit', 'view'],
  'Banking': ['full', 'full', 'edit', 'none', 'none'],
  'Ledger': ['full', 'full', 'edit', 'view', 'view'],
  'Reports': ['full', 'full', 'view', 'view', 'view'],
  'Users': ['full', 'view', 'none', 'none', 'none'],
};

class RolesPermissionsView extends StatelessWidget {
  const RolesPermissionsView({super.key});
  @override
  Widget build(BuildContext context) {
    final form = context.read<FormCubit>();
    return BlocBuilder<FormCubit, FormData>(
      builder: (context, state) {
        final role = state.value<String>('role') ?? 'Admin';
        final matrix = state.value<Map<String, List<String>>>('matrix') ?? defaultPermissionsMatrix();
        final ri = roleNames.indexOf(role);

        void cycle(String module) {
          final next = {for (final e in matrix.entries) e.key: [...e.value]};
          final cur = next[module]![ri];
          next[module]![ri] = permissionOrder[(permissionOrder.indexOf(cur) + 1) % permissionOrder.length];
          form.setField('matrix', next);
        }

        return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Roles & Permissions'),
      body: MScroll([
          MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Select Role', subtitle: "Tap a module's badge to cycle its access level", children: [
            Segmented(options: roleNames, value: role, onChange: (v) => form.setField('role', v)),
          ]),
          MCard(pad: 8, children: [
            for (int i = 0; i < roleModules.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
                decoration: BoxDecoration(border: i < roleModules.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(roleModules[i], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                  GestureDetector(
                    onTap: () => cycle(roleModules[i]),
                    child: () {
                      final lvl = matrix[roleModules[i]]![ri];
                      final meta = permissionMeta(context)[lvl]!;
                      final hasColor = lvl != 'none';
                      return Container(
                        constraints: const BoxConstraints(minWidth: 72),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(color: hasColor ? superCoreTint(meta.$1, 0x26) : Colors.transparent, border: hasColor ? null : Border.all(color: SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(999)),
                        child: Text(meta.$2.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.4, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, color: hasColor ? meta.$1 : SuperMaterialThemeData.of(context).superTheme.fg4)),
                      );
                    }(),
                  ),
                ]),
              ),
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Wrap(spacing: 18, runSpacing: 8, children: [
              for (final e in permissionMeta(context).entries)
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Container(width: 9, height: 9, decoration: BoxDecoration(color: e.key == 'none' ? Colors.transparent : e.value.$1, border: e.key == 'none' ? Border.all(color: SuperMaterialThemeData.of(context).superTheme.borderStrong) : null, shape: BoxShape.circle)),
                  const SizedBox(width: 7),
                  Text(e.value.$2 == '—' ? 'No access' : e.value.$2, style: TextStyle(fontSize: 11.5, color: SuperMaterialThemeData.of(context).superTheme.fg2, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                ]),
            ]),
          ),
          MBtn('Save Permissions', icon: 'check', full: true, onTap: form.submit),
        ]),
    );
      },
    );
  }
}
