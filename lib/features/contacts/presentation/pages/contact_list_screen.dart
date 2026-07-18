part of 'contacts_screens.dart';

class ContactListScreen extends StatefulWidget {
  final _ContactKind kind;
  final String detailKey;
  const ContactListScreen._(this.kind, this.detailKey, {super.key});
  factory ContactListScreen.customers() => ContactListScreen._(_customer, 'customerDetail');
  factory ContactListScreen.suppliers() => ContactListScreen._(_supplier, 'supplierDetail');
  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  String _q = '';
  String _status = 'All';
  @override
  Widget build(BuildContext context) {
    final d = widget.kind;
    final ql = _q.trim().toLowerCase();
    final visible = d.rows.where((c) => (_status == 'All' || c.$7 == _status.toLowerCase()) && (ql.isEmpty || c.$2.toLowerCase().contains(ql) || c.$1.toLowerCase().contains(ql) || c.$3.contains(_q))).toList();
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: d.labelPl),
      body: MScroll([
      SearchInput(placeholder: 'Search ${d.labelPl.toLowerCase()}…', value: _q, onChange: (v) => setState(() => _q = v)),
      Segmented(options: const ['All', 'Active', 'Pending', 'Inactive'], value: _status, onChange: (v) => setState(() => _status = v)),
      MCard(pad: 8, children: [
        for (int i = 0; i < visible.length; i++)
          GestureDetector(
            onTap: () => context.goTo(widget.detailKey),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
              decoration: BoxDecoration(border: i < visible.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
              child: Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(visible[i].$2, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                  Directionality(textDirection: TextDirection.rtl, child: Text(visible[i].$3, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg3))),
                  const SizedBox(height: 3),
                  Row(children: [
                    Text(visible[i].$1, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10.5, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                    Text('  ·  ', style: TextStyle(color: SuperMaterialThemeData.of(context).superTheme.fg4, fontSize: 10.5)),
                    Text(visible[i].$4, style: TextStyle(fontSize: 10.5, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                  ]),
                ])),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(visible[i].$5, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, fontWeight: FontWeight.w600, color: double.parse(visible[i].$5.replaceAll(',', '')) == 0 ? SuperMaterialThemeData.of(context).superTheme.fg4 : d.tone(context))),
                  const SizedBox(height: 4),
                  Pill(visible[i].$7, tone: _kTone(visible[i].$7)),
                ]),
              ]),
            ),
          ),
        if (visible.isEmpty) Padding(padding: const EdgeInsets.symmetric(vertical: 36), child: Center(child: Text('No ${d.labelPl.toLowerCase()} match.', style: TextStyle(color: SuperMaterialThemeData.of(context).superTheme.fg3, fontSize: 13, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)))),
      ]),
    ]),
    );
  }
}
