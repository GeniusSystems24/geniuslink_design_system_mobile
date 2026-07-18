part of 'banking_cash_screens.dart';

class DepositDetailScreen extends StatelessWidget {
  const DepositDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Deposit Receipt'),
      body: MScroll([
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.secondary, 0x14), border: Border.all(color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.secondary, 0x40)), borderRadius: BorderRadius.circular(12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Eyebrow('Deposit Receipt · DEP-2024-0182', color: SuperMaterialThemeData.of(context).colorScheme.secondary, size: 10),
          SizedBox(height: 10),
          Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
            Text('+120,000.00 ', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 30, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).colorScheme.secondary, letterSpacing: -0.5)),
            Text('SAR', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
          ]),
        ]),
      ),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Details', children: [
        BKV('Method', 'Cash'), BKV('Deposited To', 'Bank · NCB Main (1100)'),
        BKV('Value Date', 'Dec 19, 2025', mono: true), BKV('Reference', 'CTR-9920', mono: true),
        BKV('Status', 'Cleared'),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Posted Journal', pad: 16, children: [
        JournalPreview(rows: [
          ('Bank · NCB Main (1100)', '120,000.00', null),
          ('Cash Box (1001)', null, '120,000.00'),
        ]),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Audit', children: [
        AuditGrid(rows: [
          ('Created By', 'Layla Ahmed', false),
          ('Created At', 'Dec 19, 09:42', true),
        ]),
      ]),
      MBtn('Back', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => context.goTo('more')),
    ]),
    );
  }
}
