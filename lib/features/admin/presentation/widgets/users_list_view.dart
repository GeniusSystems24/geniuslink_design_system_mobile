// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';
import '../../../../core/bloc/list_cubit.dart';
import '../../domain/domain.dart';

import 'user_session_banner.dart';

PillTone userTone(UserAccountStatus status) => switch (status) {
      UserAccountStatus.active => PillTone.success,
      UserAccountStatus.pending => PillTone.warning,
      UserAccountStatus.inactive => PillTone.neutral,
    };

Color userRoleColor(BuildContext context, String role) {
  final colors = SuperMaterialThemeData.of(context).colorScheme;
  final theme = SuperMaterialThemeData.of(context).superTheme;
  return switch (role) {
    'Administrator' => colors.primary,
    'Accountant' => colors.tertiary,
    'Controller' => colors.secondary,
    _ => theme.fg3,
  };
}

class UsersListView extends StatelessWidget {
  const UsersListView({super.key});
  @override
  Widget build(BuildContext context) {
    const roles = ['All', 'Administrator', 'Controller', 'Accountant', 'Store Manager', 'Viewer'];
    final cubit = context.read<ListCubit<UserSummary>>();
    return BlocBuilder<ListCubit<UserSummary>, ListState<UserSummary>>(
      builder: (context, state) {
        final visible = state.results;
        final role = (state.filters['role'] as String?) ?? 'All';
        return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Users')),
      body: MScroll([
          SearchInput(placeholder: 'Search name or email…', value: state.query, onChange: cubit.setQuery),
          Segmented(options: roles, value: role, onChange: (v) => cubit.setFilter('role', v)),
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
                  for (int i = 0; i < visible.length; i++)
                    GestureDetector(
                      onTap: () => context.goTo('userDetail'),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        decoration: BoxDecoration(border: i < visible.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                        child: Row(children: [
                          Avatar(visible[i].name, size: 38),
                          const SizedBox(width: 12),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(visible[i].name, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                            const SizedBox(height: 2),
                            Text(visible[i].email, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                            const SizedBox(height: 4),
                            Row(children: [
                              Container(width: 6, height: 6, decoration: BoxDecoration(color: userRoleColor(context, visible[i].role), shape: BoxShape.circle)),
                              const SizedBox(width: 6),
                              Text(visible[i].role, style: TextStyle(fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                            ]),
                          ])),
                          Pill(visible[i].status.label, tone: userTone(visible[i].status)),
                        ]),
                      ),
                    ),
                  if (visible.isEmpty) Padding(padding: const EdgeInsets.symmetric(vertical: 36), child: Center(child: Text('No users match.', style: TextStyle(color: SuperMaterialThemeData.of(context).superTheme.fg3, fontSize: 13, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)))),
                ],
          ),
        ),
          const UserSessionBanner(),
        ]),
    );
      },
    );
  }
}
