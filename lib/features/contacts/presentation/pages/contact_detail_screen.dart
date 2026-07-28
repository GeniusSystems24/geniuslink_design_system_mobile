part of 'contacts_screens.dart';

class ContactDetailScreen extends StatelessWidget {
  final ContactKind kind;
  final int contactIndex;
  const ContactDetailScreen({
    required this.kind,
    this.contactIndex = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final d = kind;
    if (d.contacts.isEmpty) {
      return Scaffold(
        backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
        appBar: SuperAppBar(title: Text('${contactSingularLabel(d.type)} Detail')),
        body: Center(
          child: Text(
            'No ${contactSingularLabel(d.type).toLowerCase()} data available.',
            style: TextStyle(
              color: SuperMaterialThemeData.of(context).superTheme.fg3,
              fontFamily: SuperMaterialThemeData.of(context)
                  .textTheme
                  .bodyMedium
                  ?.fontFamily,
            ),
          ),
        ),
      );
    }
    final safeIndex = contactIndex < 0
        ? 0
        : (contactIndex >= d.contacts.length ? d.contacts.length - 1 : contactIndex);
    final c = d.contacts[safeIndex];
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var trailing = const Pill('Active');
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: Text('${contactSingularLabel(d.type)} Detail')),
      body: MScroll([
      SuperSectionCard2(
      trailing: trailing,
      title: 'Outstanding ${contactBalanceLabel(d.type)}',
      subtitle: '${c.orderCount} orders · since Apr 2024',
      initiallyExpanded: true,
      accentColor: accentColor2,
      icon: null,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
            Text('SAR', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 14, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
            const SizedBox(width: 8),
            Text(formatContactAmount(c.balance), style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 32, fontWeight: FontWeight.w700, color: contactTone(context, d), letterSpacing: -0.6)),
          ]),
        ],
      ),
    ),
      SuperSectionCard2(
      trailing: (null),
      title: '${contactSingularLabel(d.type)} Information',
      subtitle: (null),
      initiallyExpanded: true,
      accentColor: accentColor3,
      icon: null,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          KV('Code', c.code, mono: true), KV('City', c.city), const KV('Contact Person', 'Ahmed K.'),
          const KV('Phone', '+966 55 124 9020', mono: true),
          KV('Control Account', d.controlAccount), const KV('Payment Terms', 'Net 30'),
        ],
      ),
    ),
      SuperSectionCard2(
      trailing: (null),
      title: 'Transaction History',
      subtitle: 'Recent invoices and payments',
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
              for (int i = 0; i < d.history.length; i++)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(border: i < d.history.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                  child: Row(children: [
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(d.history[i].reference, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).colorScheme.primary)),
                      const SizedBox(height: 2),
                      Text('${d.history[i].description} · ${formatContactDate(d.history[i].occurredAt)}', style: TextStyle(fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                    ])),
                    Text(formatContactAmount(d.history[i].amount, signed: true), style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13.5, fontWeight: FontWeight.w600, color: d.history[i].amount >= 0 ? SuperMaterialThemeData.of(context).colorScheme.secondary : SuperMaterialThemeData.of(context).colorScheme.error)),
                  ]),
                ),
            ]),
          ),
        ],
      ),
    ),
      const Row(children: [
        Expanded(child: MBtn('Edit', variant: MBtnVariant.secondary, icon: 'edit', full: true)),
        SizedBox(width: 10),
        Expanded(child: MBtn('Archive', variant: MBtnVariant.danger, icon: 'trash', full: true)),
      ]),
    ]),
    );
  }
}
