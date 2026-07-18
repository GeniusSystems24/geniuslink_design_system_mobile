import 'package:equatable/equatable.dart';

enum PermissionLevel { none, view, edit, full }

class RolePermissionMatrix extends Equatable {
  final List<String> roles;
  final List<String> modules;
  final Map<String, List<PermissionLevel>> values;

  const RolePermissionMatrix({
    required this.roles,
    required this.modules,
    required this.values,
  });

  factory RolePermissionMatrix.defaults() => const RolePermissionMatrix(
        roles: ['Admin', 'Controller', 'Accountant', 'Manager', 'Viewer'],
        modules: ['Accounts', 'Stores', 'Inventory', 'Banking', 'Ledger', 'Reports', 'Users'],
        values: {
          'Accounts': [PermissionLevel.full, PermissionLevel.edit, PermissionLevel.edit, PermissionLevel.view, PermissionLevel.view],
          'Stores': [PermissionLevel.full, PermissionLevel.edit, PermissionLevel.view, PermissionLevel.edit, PermissionLevel.view],
          'Inventory': [PermissionLevel.full, PermissionLevel.edit, PermissionLevel.edit, PermissionLevel.edit, PermissionLevel.view],
          'Banking': [PermissionLevel.full, PermissionLevel.full, PermissionLevel.edit, PermissionLevel.none, PermissionLevel.none],
          'Ledger': [PermissionLevel.full, PermissionLevel.full, PermissionLevel.edit, PermissionLevel.view, PermissionLevel.view],
          'Reports': [PermissionLevel.full, PermissionLevel.full, PermissionLevel.view, PermissionLevel.view, PermissionLevel.view],
          'Users': [PermissionLevel.full, PermissionLevel.view, PermissionLevel.none, PermissionLevel.none, PermissionLevel.none],
        },
      );

  PermissionLevel levelFor(String module, int roleIndex) => values[module]![roleIndex];

  RolePermissionMatrix cycle(String module, int roleIndex) {
    final nextValues = {
      for (final entry in values.entries) entry.key: List<PermissionLevel>.of(entry.value),
    };
    const levels = PermissionLevel.values;
    final current = nextValues[module]![roleIndex];
    nextValues[module]![roleIndex] = levels[(current.index + 1) % levels.length];
    return RolePermissionMatrix(roles: roles, modules: modules, values: nextValues);
  }

  @override
  List<Object?> get props => [roles, modules, values];
}
