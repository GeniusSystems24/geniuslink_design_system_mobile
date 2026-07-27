part of 'banking_transfer_screens.dart';

class LocalTransferDetailScreen extends StatelessWidget {
  const LocalTransferDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Local Transfer Detail')),
      body: MScroll([
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Inter-Account Settlement', trailing: const Pill('Posted'), children: [
        Text('TR-2024-9042 · Dec 18, 2025', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).colorScheme.primary)),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Flow', pad: 16, children: [
        FromToFlow(
          from: const FlowCardData(label: 'From', title: 'Bank · NCB Main', subtitle: '1100', meta: 'Balance after  ·  136,420.00'),
          to: FlowCardData(label: 'To', title: 'Bank · Al Rajhi', subtitle: '1101', meta: 'Balance after  ·  56,240.00', metaColor: SuperMaterialThemeData.of(context).colorScheme.secondary),
        ),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Amount', children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Eyebrow('Transferred', color: SuperMaterialThemeData.of(context).superTheme.fg3, size: 11),
          Text.rich(TextSpan(children: [
            TextSpan(text: '50,000.00 ', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 24, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
            TextSpan(text: 'SAR', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
          ])),
        ]),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Audit', children: const [
        AuditGrid(rows: [('Created By', 'Layla Ahmed', false), ('Created At', 'Dec 18, 14:02', true)]),
      ]),
      MBtn('Back', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => context.goTo('more')),
    ]),
    );
  }
}
