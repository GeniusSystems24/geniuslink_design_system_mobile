part of 'settings_org_screens.dart';

class SettingsHubScreen extends StatelessWidget {
  final List<SettingsNavigationSection> sections;

  const SettingsHubScreen({
    this.sections = defaultSettingsNavigation,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Settings')),
      body: MScroll([
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        child: Row(children: [
          Container(width: 40, height: 40, alignment: Alignment.center, decoration: BoxDecoration(color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.primary, 0x1F), borderRadius: BorderRadius.circular(10)), child: Icon(MIcons.of('building'), size: 20, color: SuperMaterialThemeData.of(context).colorScheme.primary)),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Al-Rashid Trading Co.', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
            Text('Tenant 9 · GeniusLink ERP', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
          ]),
        ]),
      ),
      for (final section in sections)
        MCard(title: section.title, accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, pad: 8, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(children: [
              for (int i = 0; i < section.items.length; i++)
                GestureDetector(
                  onTap: () => context.goTo(section.items[i].routeId),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(border: i < section.items.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                    child: Row(children: [
                      Container(width: 34, height: 34, alignment: Alignment.center, decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.inputBg, borderRadius: BorderRadius.circular(8)), child: Icon(MIcons.of(section.items[i].iconName), size: 16, color: SuperMaterialThemeData.of(context).superTheme.fg2)),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(section.items[i].label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                        const SizedBox(height: 1),
                        Text(section.items[i].description, style: TextStyle(fontSize: 11.5, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                      ])),
                      Icon(MIcons.of('chevR'), size: 16, color: SuperMaterialThemeData.of(context).superTheme.fg4),
                    ]),
                  ),
                ),
            ]),
          ),
        ]),
    ]),
    );
  }
}
