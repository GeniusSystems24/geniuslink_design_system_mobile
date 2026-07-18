import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final _open = <String>{'steel'};
  @override
  Widget build(BuildContext context) {
    final tree = [
      ('steel', 'CAT-001', 'Steel', 412, '1,820,420', [('CAT-001-01', 'Reinforcement Bars', 88), ('CAT-001-02', 'Structural Beams', 142), ('CAT-001-03', 'Steel Plates', 64)]),
      ('cement', 'CAT-002', 'Cement & Mortars', 96, '188,640', [('CAT-002-01', 'Ordinary Portland', 42), ('CAT-002-02', 'Sulfate Resistant', 28)]),
      ('agg', 'CAT-003', 'Aggregates', 64, '142,800', <(String, String, int)>[]),
      ('timber', 'CAT-004', 'Timber & Wood', 184, '484,210', [('CAT-004-01', 'Sawn Lumber', 92), ('CAT-004-02', 'Plywood', 92)]),
      ('finish', 'CAT-005', 'Finishing Materials', 128, '184,390', <(String, String, int)>[]),
    ];
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Categories'),
      body: MScroll([
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Category Tree', subtitle: '5 top-level groups', pad: 8, children: [
        for (final node in tree) ...[
          GestureDetector(
            onTap: () => setState(() => _open.contains(node.$1) ? _open.remove(node.$1) : _open.add(node.$1)),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
              child: Row(children: [
                Container(
                  width: 22, height: 22, alignment: Alignment.center,
                  decoration: BoxDecoration(color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.primary, 0x1F), borderRadius: BorderRadius.circular(6)),
                  child: Icon(node.$6.isNotEmpty ? (_open.contains(node.$1) ? Icons.keyboard_arrow_down_rounded : Icons.chevron_right_rounded) : Icons.description_outlined, size: 13, color: SuperMaterialThemeData.of(context).colorScheme.primary),
                ),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(node.$3, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                  const SizedBox(height: 2),
                  Text('${node.$2} · ${node.$4} SKUs', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10.5, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                ])),
                Text(node.$5, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
              ]),
            ),
          ),
          if (_open.contains(node.$1))
            for (final ch in node.$6)
              Padding(
                padding: const EdgeInsets.only(left: 36, right: 4, top: 2, bottom: 12),
                child: Row(children: [
                  Icon(MIcons.of('doc'), size: 11, color: SuperMaterialThemeData.of(context).superTheme.fg4),
                  const SizedBox(width: 10),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(ch.$2, style: TextStyle(fontSize: 12.5, color: SuperMaterialThemeData.of(context).superTheme.fg2, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                    Text(ch.$1, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10, color: SuperMaterialThemeData.of(context).superTheme.fg4)),
                  ])),
                  Text('${ch.$3}', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                ]),
              ),
        ],
      ]),
      ISection(icon: 'briefcase', title: 'New Category', sub: 'Quick inline form', marker: SuperMaterialThemeData.of(context).colorScheme.secondary, defaultOpen: false, children: const [
        IField(label: 'Code', placeholder: 'e.g. CAT-006', mono: true, required: true),
        IField(label: 'Parent', value: '— Top Level —', select: true),
        IField(label: 'Name (English)', placeholder: 'e.g. Adhesives & Sealants', required: true),
        IField(label: 'الاسم بالعربية', placeholder: 'مثال: لاصقات', ar: true, required: true),
        ActionRow(primary: 'Create Category'),
      ]),
    ]),
    );
  }
}
