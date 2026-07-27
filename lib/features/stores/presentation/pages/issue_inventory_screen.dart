part of 'stores_screens.dart';

class IssueInventoryScreen extends StatelessWidget {
  const IssueInventoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Issue Inventory')),
      body: MScroll([
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Issue Details', children: const [
        MField(label: 'Serial No', value: 'INV-ISS-2024-0089', mono: true),
        MField(label: 'Store', placeholder: 'Search store…', required: true),
        MField(label: 'Currency', value: 'USD — US Dollar'),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Items', subtitle: '1 line · 12 units', children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.bg, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(8)),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Structural Steel', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                const SizedBox(height: 2),
                Text('12 PCS × 450.00', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
              ]),
            ),
            Text('5,400.00', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 15, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
          ]),
        ),
        _dashedAdd(context, 'scan', 'Scan to Add Item'),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Total', children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Eyebrow('Total Value', color: SuperMaterialThemeData.of(context).superTheme.fg3, size: 12),
          Text.rich(TextSpan(children: [
            TextSpan(text: '5,400.00 ', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 24, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
            TextSpan(text: 'USD', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
          ])),
        ]),
      ]),
      const MBtn('Issue Inventory', icon: 'check', full: true),
    ]),
    );
  }

  static Widget _dashedAdd(BuildContext context, String icon, String label) => Container(
        height: 44,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: DottedBorderBox(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(MIcons.of(icon), size: 16, color: SuperMaterialThemeData.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(color: SuperMaterialThemeData.of(context).colorScheme.primary, fontWeight: FontWeight.w600, fontSize: 13, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
          ]),
        ),
      );
}
