part of 'contacts_screens.dart';

class ContactDetailScreen extends StatelessWidget {
  final _ContactKind kind;
  const ContactDetailScreen._(this.kind, {super.key});
  factory ContactDetailScreen.customer() => ContactDetailScreen._(_customer);
  factory ContactDetailScreen.supplier() => ContactDetailScreen._(_supplier);
  @override
  Widget build(BuildContext context) {
    final d = kind;
    final c = d.rows.first;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: '${d.label} Detail'),
      body: MScroll([
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Outstanding ${d.balanceLabel}', subtitle: '${c.$6} orders · since Apr 2024', trailing: const Pill('Active'), children: [
        Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Text('SAR', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 14, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
          const SizedBox(width: 8),
          Text(c.$5, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 32, fontWeight: FontWeight.w700, color: d.tone(context), letterSpacing: -0.6)),
        ]),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: '${d.label} Information', children: [
        KV('Code', c.$1, mono: true), KV('City', c.$4), const KV('Contact Person', 'Ahmed K.'),
        const KV('Phone', '+966 55 124 9020', mono: true),
        KV('Control Account', d.label == 'Customer' ? '1300 — A/R' : '2001 — A/P'), const KV('Payment Terms', 'Net 30'),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.tertiary, title: 'Transaction History', subtitle: 'Recent invoices and payments', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < d.history.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i < d.history.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                child: Row(children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(d.history[i].$1, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).colorScheme.primary)),
                    const SizedBox(height: 2),
                    Text('${d.history[i].$2} · ${d.history[i].$4}', style: TextStyle(fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                  ])),
                  Text(d.history[i].$3, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13.5, fontWeight: FontWeight.w600, color: d.history[i].$3.startsWith('+') ? SuperMaterialThemeData.of(context).colorScheme.secondary : SuperMaterialThemeData.of(context).colorScheme.error)),
                ]),
              ),
          ]),
        ),
      ]),
      const Row(children: [
        Expanded(child: MBtn('Edit', variant: MBtnVariant.secondary, icon: 'edit', full: true)),
        SizedBox(width: 10),
        Expanded(child: MBtn('Archive', variant: MBtnVariant.danger, icon: 'trash', full: true)),
      ]),
    ]),
    );
  }
}
