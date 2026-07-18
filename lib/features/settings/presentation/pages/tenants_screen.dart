part of 'settings_team_screens.dart';

class TenantsScreen extends StatelessWidget {
  const TenantsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final tenants = [(9, 'Al-Rashid Trading Co.', 'Administrator', 'Business', 6, SuperMaterialThemeData.of(context).colorScheme.primary), (14, 'Najd Holdings', 'Controller', 'Enterprise', 28, SuperMaterialThemeData.of(context).colorScheme.secondary), (22, 'Coastal Logistics', 'Accountant', 'Starter', 3, SuperMaterialThemeData.of(context).colorScheme.tertiary)];
    return BlocBuilder<TenantCubit, TenantState>(
      buildWhen: (a, b) => a.activeTenantId != b.activeTenantId,
      builder: (context, tstate) {
        final activeId = tstate.activeTenantId;
        return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Workspaces'),
      body: MScroll([
          for (final t in tenants)
            MCard(children: [
              Row(children: [
                Container(width: 44, height: 44, alignment: Alignment.center, decoration: BoxDecoration(color: superCoreTint(t.$6, 0x1F), borderRadius: BorderRadius.circular(11)), child: Icon(MIcons.of('building'), size: 22, color: t.$6)),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Flexible(child: Text(t.$2, style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily))),
                    if (t.$1.toString() == activeId) const Padding(padding: EdgeInsets.only(left: 8), child: Pill('Current')),
                  ]),
                  const SizedBox(height: 3),
                  Text('Tenant ${t.$1} · ${t.$3} · ${t.$5} members', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                ])),
                Pill(t.$4, tone: t.$4 == 'Enterprise' ? PillTone.info : (t.$4 == 'Business' ? PillTone.success : PillTone.neutral)),
              ]),
              if (t.$1.toString() == activeId)
                const MBtn('Manage Workspace', variant: MBtnVariant.secondary, icon: 'settings', full: true)
              else
                MBtn('Switch to this Workspace', icon: 'switch2', full: true, onTap: () => context.read<TenantCubit>().switchTo(t.$1.toString())),
            ]),
          const MBtn('New Workspace', icon: 'plus', full: true),
        ]),
    );
      },
    );
  }
}
