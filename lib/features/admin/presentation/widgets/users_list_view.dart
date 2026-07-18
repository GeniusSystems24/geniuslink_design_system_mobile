// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';
import '../../../../core/bloc/list_cubit.dart';

import 'user_session_banner.dart';

typedef UserRow = (int, String, String, String, String, Color);

PillTone userTone(String status) => status == 'active'
    ? PillTone.success
    : (status == 'pending' ? PillTone.warning : PillTone.neutral);

class UsersListView extends StatelessWidget {
  const UsersListView({super.key});
  @override
  Widget build(BuildContext context) {
    const roles = ['All', 'Administrator', 'Controller', 'Accountant', 'Store Manager', 'Viewer'];
    final cubit = context.read<ListCubit<UserRow>>();
    return BlocBuilder<ListCubit<UserRow>, ListState<UserRow>>(
      builder: (context, state) {
        final visible = state.results;
        final role = (state.filters['role'] as String?) ?? 'All';
        return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Users'),
      body: MScroll([
          SearchInput(placeholder: 'Search name or email…', value: state.query, onChange: cubit.setQuery),
          Segmented(options: roles, value: role, onChange: (v) => cubit.setFilter('role', v)),
          MCard(pad: 8, children: [
            for (int i = 0; i < visible.length; i++)
              GestureDetector(
                onTap: () => context.goTo('userDetail'),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  decoration: BoxDecoration(border: i < visible.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                  child: Row(children: [
                    Avatar(visible[i].$2, size: 38),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(visible[i].$2, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                      const SizedBox(height: 2),
                      Text(visible[i].$3, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                      const SizedBox(height: 4),
                      Row(children: [
                        Container(width: 6, height: 6, decoration: BoxDecoration(color: visible[i].$6, shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        Text(visible[i].$4, style: TextStyle(fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                      ]),
                    ])),
                    Pill(visible[i].$5, tone: userTone(visible[i].$5)),
                  ]),
                ),
              ),
            if (visible.isEmpty) Padding(padding: EdgeInsets.symmetric(vertical: 36), child: Center(child: Text('No users match.', style: TextStyle(color: SuperMaterialThemeData.of(context).superTheme.fg3, fontSize: 13, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)))),
          ]),
          const UserSessionBanner(),
        ]),
    );
      },
    );
  }
}
