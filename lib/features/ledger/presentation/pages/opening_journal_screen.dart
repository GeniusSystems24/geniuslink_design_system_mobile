part of 'ledger_screens.dart';

class OpeningJournalScreen extends StatelessWidget {
  const OpeningJournalScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const lines = [
      ('Cash Box (1001)', '+5,000.00', true, 'Opening balance'),
      ('Capital Account (3001)', '-5,000.00', false, 'Owner investment'),
    ];
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Opening Journal')),
      body: MScroll([
      SuperSectionCard2(
      trailing: (null),
      title: 'Entry Details' ?? "",
      subtitle: (null),
      initiallyExpanded: true,
      accentColor: accentColor2,
      icon: null,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: const [
          MField(label: 'Serial No', value: 'JV-2024-0042', mono: true),
          MField(label: 'Currency', value: 'SAR — Saudi Riyal'),
          MField(label: 'Fiscal Year', value: '2024', mono: true),
        ],
      ),
    ),
      SuperSectionCard2(
      trailing: (null),
      title: 'Transfer Lines' ?? "",
      subtitle: '2 lines · balanced',
      initiallyExpanded: true,
      accentColor: accentColor,
      icon: null,
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(children: [
              for (int i = 0; i < lines.length; i++)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(border: i == lines.length - 1 ? null : Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(lines[i].$1, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                      Text(lines[i].$2, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 14, fontWeight: FontWeight.w600, color: lines[i].$3 ? SuperMaterialThemeData.of(context).colorScheme.secondary : SuperMaterialThemeData.of(context).colorScheme.error)),
                    ]),
                    const SizedBox(height: 3),
                    Text(lines[i].$4, style: TextStyle(fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                  ]),
                ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(border: Border(top: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.borderStrong, width: 2))),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Eyebrow('Balanced · Diff 0.00', color: SuperMaterialThemeData.of(context).colorScheme.secondary, size: 11),
                  Text('5,000.00', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 15, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
                ]),
              ),
            ]),
          ),
        ],
      ),
    ),
      const MBtn('Create Entry', icon: 'check', full: true),
    ]),
    );
  }
}
