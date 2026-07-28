
import 'package:flutter/material.dart';

import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';
import '../../domain/domain.dart';

PillTone _statusTone(InventoryStockStatus status) => switch (status) {
  InventoryStockStatus.inStock => PillTone.success,
  InventoryStockStatus.lowStock => PillTone.warning,
  InventoryStockStatus.outOfStock => PillTone.danger,
};

String _statusLabel(InventoryStockStatus status) => switch (status) {
  InventoryStockStatus.inStock => 'In Stock',
  InventoryStockStatus.lowStock => 'Low',
  InventoryStockStatus.outOfStock => 'Out',
};

class ProductsListScreen extends StatefulWidget {
  final List<ProductSummary> products;
  final ValueChanged<ProductSummary>? onProductSelected;

  const ProductsListScreen({required this.products, this.onProductSelected, super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  String _category = 'All';

  @override
  Widget build(BuildContext context) {
    final categories = <String>{'All', ...widget.products.map((p) => p.category)}.toList();
    final rows = _category == 'All' ? widget.products : widget.products.where((product) => product.category == _category).toList();
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Products')),
      body: MScroll([
        Container(height: 44, padding: const EdgeInsets.symmetric(horizontal: 14), decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.inputBg, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.borderStrong), borderRadius: BorderRadius.circular(10)), child: Row(children: [Icon(Icons.search_rounded, size: 16, color: SuperMaterialThemeData.of(context).superTheme.fg3), const SizedBox(width: 10), Text('Search product or SKU…', style: TextStyle(color: SuperMaterialThemeData.of(context).superTheme.fg3, fontSize: 14, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily))])),
        SizedBox(height: 32, child: ListView.separated(scrollDirection: Axis.horizontal, itemCount: categories.length, separatorBuilder: (_, _) => const SizedBox(width: 8), itemBuilder: (_, i) {
          final selected = categories[i] == _category;
          return GestureDetector(onTap: () => setState(() => _category = categories[i]), child: Container(padding: const EdgeInsets.symmetric(horizontal: 14), alignment: Alignment.center, decoration: BoxDecoration(color: selected ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.inputBg, border: Border.all(color: selected ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(999)), child: Text(categories[i].toUpperCase(), style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: selected ? Colors.white : SuperMaterialThemeData.of(context).superTheme.fg3))));
        })),
        SuperSectionCard2(
      trailing: (null),
      title: "",
      subtitle: (null),
      initiallyExpanded: true,
      accentColor: (null),
      icon: null,
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
            for (int i = 0; i < rows.length; i++)
              GestureDetector(
                onTap: () {
                  final callback = widget.onProductSelected;
                  if (callback != null) {
                    callback(rows[i]);
                  } else {
                    context.goTo('productDetail');
                  }
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
                  decoration: BoxDecoration(border: i < rows.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                  child: Row(children: [
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(rows[i].name, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                      const SizedBox(height: 3),
                      Row(children: [Text(rows[i].sku, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3)), Text('  ·  ', style: TextStyle(color: SuperMaterialThemeData.of(context).superTheme.fg4, fontSize: 11)), Text(rows[i].category, style: TextStyle(fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily))]),
                    ])),
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Text.rich(TextSpan(children: [TextSpan(text: '${rows[i].onHand} ', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, fontWeight: FontWeight.w600, color: rows[i].status == InventoryStockStatus.outOfStock ? SuperMaterialThemeData.of(context).colorScheme.error : rows[i].status == InventoryStockStatus.lowStock ? SuperMaterialThemeData.of(context).colorScheme.tertiary : SuperMaterialThemeData.of(context).superTheme.fg1)), TextSpan(text: rows[i].unit, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10, color: SuperMaterialThemeData.of(context).superTheme.fg3))])),
                      const SizedBox(height: 4),
                      Pill(_statusLabel(rows[i].status), tone: _statusTone(rows[i].status)),
                    ]),
                  ]),
                ),
              ),
          ],
      ),
    ),
      ]),
    );
  }
}
