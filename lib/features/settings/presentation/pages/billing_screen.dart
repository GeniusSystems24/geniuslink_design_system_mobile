part of 'settings_platform_screens.dart';

class BillingScreen extends StatelessWidget {
  const BillingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const usage = [('Users', 6.0, 25.0, ''), ('Transactions · MTD', 4120.0, 100000.0, ''), ('Storage', 2.4, 50.0, ' GB')];
    const plans = [('Starter', '0', 'free', ['1 workspace', '3 users', '500 entries/mo'], false), ('Business', '349', '/mo', ['Unlimited entries', '25 users', 'All integrations'], true), ('Enterprise', 'Custom', '', ['SSO & SAML', 'Dedicated support', 'Audit retention 10y'], false)];
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Billing'),
      body: MScroll([
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Current Plan', trailing: const Pill('Active'), children: [
        Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Text('Business', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.headlineMedium?.fontFamily, fontWeight: FontWeight.w700, fontSize: 22, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
          const SizedBox(width: 10),
          Text.rich(TextSpan(children: [TextSpan(text: '349.00 SAR', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 14, color: SuperMaterialThemeData.of(context).superTheme.fg2)), TextSpan(text: '/mo', style: TextStyle(fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3))])),
        ]),
        Text('Renews Jan 1, 2026', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
        Column(children: [
          for (final u in usage) BillingUsageBar(label: u.$1, val: u.$2, max: u.$3, unit: u.$4),
        ]),
      ]),
      for (final p in plans)
        Container(
          decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.surface, border: Border.all(color: p.$5 ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(18),
          child: Stack(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Text(p.$1, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
              const SizedBox(height: 14),
              Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
                Text(p.$2, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 26, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).superTheme.fg1, letterSpacing: -0.5)),
                const SizedBox(width: 4),
                Text(p.$3, style: TextStyle(fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
              ]),
              const SizedBox(height: 14),
              for (final f in p.$4)
                Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(children: [Icon(MIcons.of('check'), size: 14, color: SuperMaterialThemeData.of(context).colorScheme.secondary), const SizedBox(width: 8), Text(f, style: TextStyle(fontSize: 12.5, color: SuperMaterialThemeData.of(context).superTheme.fg2, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily))])),
              const SizedBox(height: 14),
              MBtn(p.$5 ? 'Current Plan' : (p.$1 == 'Enterprise' ? 'Contact Sales' : 'Upgrade'), variant: p.$5 ? MBtnVariant.secondary : MBtnVariant.primary, full: true),
            ]),
            if (p.$5) PositionedDirectional(top: 0, end: 0, child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.primary, 0x24), borderRadius: BorderRadius.circular(4)), child: Text('CURRENT', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w700, letterSpacing: 0.6, color: SuperMaterialThemeData.of(context).colorScheme.primary, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)))),
          ]),
        ),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.tertiary, title: 'Recent Invoices', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (final inv in const [('INV-GL-2025-012', 'Dec 01', '349.00'), ('INV-GL-2025-011', 'Nov 01', '349.00'), ('INV-GL-2025-010', 'Oct 01', '349.00')])
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
                child: Row(children: [
                  Expanded(child: Text(inv.$1, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).colorScheme.primary))),
                  Text(inv.$2, style: TextStyle(fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                  const SizedBox(width: 12),
                  Text(inv.$3, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
                  const SizedBox(width: 10),
                  const Pill('Paid'),
                ]),
              ),
          ]),
        ),
      ]),
    ]),
    );
  }
}
