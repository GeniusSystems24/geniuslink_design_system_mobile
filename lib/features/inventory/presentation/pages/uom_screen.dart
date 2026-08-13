import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';

class UomScreen extends StatefulWidget {
  const UomScreen({super.key});
  @override
  State<UomScreen> createState() => _UomScreenState();
}

class _UomScreenState extends State<UomScreen> {
  String _active = 'count';
  @override
  Widget build(BuildContext context) {
    final groups = {
      'count': (
        'Count',
        'PCS',
        SuperMaterialThemeData.of(context).colorScheme.primary,
        [
          ('PCS', 'Piece', '1', true),
          ('DZN', 'Dozen', '12', false),
          ('BOX', 'Box', '24', false),
          ('CTN', 'Carton', '144', false),
          ('PLT', 'Pallet', '600', false),
        ],
      ),
      'weight': (
        'Weight',
        'KG',
        SuperMaterialThemeData.of(context).colorScheme.secondary,
        [
          ('G', 'Gram', '0.001', false),
          ('KG', 'Kilogram', '1', true),
          ('TON', 'Tonne', '1000', false),
          ('BAG', 'Bag 50kg', '50', false),
        ],
      ),
      'length': (
        'Length',
        'M',
        SuperMaterialThemeData.of(context).colorScheme.tertiary,
        [
          ('CM', 'Centimeter', '0.01', false),
          ('M', 'Meter', '1', true),
          ('KM', 'Kilometer', '1000', false),
        ],
      ),
      'volume': (
        'Volume',
        'L',
        SuperMaterialThemeData.of(context).colorScheme.primary,
        [
          ('ML', 'Milliliter', '0.001', false),
          ('L', 'Liter', '1', true),
          ('M3', 'Cubic Meter', '1000', false),
        ],
      ),
    };
    final cur = groups[_active]!;
    var accentColor = cur.$3;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Units of Measure')),
      body: MScroll([
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 2.1,
          children: [
            for (final e in groups.entries)
              GestureDetector(
                onTap: () => setState(() => _active = e.key),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _active == e.key
                        ? superCoreTint(e.value.$3, 0x14)
                        : SuperMaterialThemeData.of(context).superTheme.surface,
                    border: Border.all(
                      color: _active == e.key
                          ? e.value.$3
                          : SuperMaterialThemeData.of(
                              context,
                            ).superTheme.border,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Eyebrow(
                        e.value.$1,
                        color: SuperMaterialThemeData.of(
                          context,
                        ).superTheme.fg3,
                        size: 10,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${e.value.$4.length} units',
                        style: TextStyle(
                          fontFamily: SuperMaterialThemeData.of(
                            context,
                          ).textTheme.bodyMedium?.fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: e.value.$3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'base · ${e.value.$2}',
                        style: TextStyle(
                          fontFamily: SuperMaterialThemeData.of(
                            context,
                          ).textTheme.bodyMedium?.fontFamily,
                          fontSize: 11,
                          color: SuperMaterialThemeData.of(
                            context,
                          ).superTheme.fg3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        SuperSectionCard2(
          
          title: '${cur.$1} Units',
          subtitle: 'Convert to base ${cur.$2}',
          initiallyExpanded: true,
          accentColor: accentColor,
          
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    for (int i = 0; i < cur.$4.length; i++)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        decoration: BoxDecoration(
                          border: i < cur.$4.length - 1
                              ? Border(
                                  bottom: BorderSide(
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).superTheme.border,
                                  ),
                                )
                              : null,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 50,
                              child: Text(
                                cur.$4[i].$1,
                                style: TextStyle(
                                  fontFamily: SuperMaterialThemeData.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontFamily,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: cur.$4[i].$4
                                      ? cur.$3
                                      : SuperMaterialThemeData.of(
                                          context,
                                        ).superTheme.fg2,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                cur.$4[i].$2,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: SuperMaterialThemeData.of(
                                    context,
                                  ).superTheme.fg1,
                                  fontFamily: SuperMaterialThemeData.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontFamily,
                                ),
                              ),
                            ),
                            Text(
                              '×${cur.$4[i].$3}',
                              style: TextStyle(
                                fontFamily: SuperMaterialThemeData.of(
                                  context,
                                ).textTheme.bodyMedium?.fontFamily,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: SuperMaterialThemeData.of(
                                  context,
                                ).superTheme.fg2,
                              ),
                            ),
                            if (cur.$4[i].$4)
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Pill('Base', tone: PillTone.info),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
