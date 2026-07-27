part of 'banking_cash_screens.dart';

class WithdrawalDetailScreen extends StatelessWidget {
  const WithdrawalDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Withdrawal Voucher')),
      body: MScroll([
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.error, 0x14), border: Border.all(color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.error, 0x40)), borderRadius: BorderRadius.circular(12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Eyebrow('Withdrawal Voucher · WD-2024-0311', color: SuperMaterialThemeData.of(context).colorScheme.error, size: 10),
            const Pill('Approved'),
          ]),
          const SizedBox(height: 10),
          Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
            Text('−12,045.00 ', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 30, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).colorScheme.error, letterSpacing: -0.5)),
            Text('SAR', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
          ]),
        ]),
      ),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Details', children: const [
        BKV('Method', 'Wire Transfer'), BKV('Payee', 'Global Steel Imports'),
        BKV('From', 'Bank · NCB Main (1100)'), BKV('Value Date', 'Dec 19, 2025', mono: true),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Posted Journal', pad: 16, children: const [
        JournalPreview(rows: [
          ('Cost of Goods Sold (5001)', '12,045.00', null),
          ('Bank · NCB Main (1100)', null, '12,045.00'),
        ]),
      ]),
      MBtn('Back', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => context.goTo('more')),
    ]),
    );
  }
}
