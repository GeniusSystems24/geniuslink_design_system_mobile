
import 'package:flutter/material.dart';

import 'package:gl_mobile_app/app/router/navigation_extensions.dart';
import 'package:gl_mobile_app/design_system/kit.dart';

import '../../domain/domain.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductDetail detail;

  const ProductDetailScreen({required this.detail, super.key});

  @override
  Widget build(BuildContext context) {
    final product = detail.product;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Product Detail'),
      body: MScroll([
        MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Stock Summary', subtitle: 'Aggregated across all stores', trailing: Pill(_stockLabel(product.status), tone: _stockTone(product.status)), children: [
          GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 2, children: [
            Mini(label: 'Total On Hand', value: '${detail.totalOnHand}', sub: product.unit, hi: true),
            Mini(label: 'Stock Value', value: SuperFormat.number(detail.stockValue, decimals: 0), sub: 'SAR'),
            Mini(label: 'Avg Unit Cost', value: SuperFormat.number(detail.averageUnitCost, decimals: 2), sub: 'SAR'),
            Mini(label: 'Reorder Level', value: '${detail.reorderLevel}', sub: product.unit),
          ]),
        ]),
        MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Product Information', children: [
          KV('SKU', product.sku, mono: true),
          KV('Barcode', detail.barcode, mono: true),
          KV('Category', product.category),
          KV('Unit', product.unit),
          KV('Selling Price', '${SuperFormat.number(detail.sellingPrice, decimals: 2)} SAR'),
          KV('VAT Rate', '${(detail.vatRate * 100).toStringAsFixed(0)}%'),
        ]),
        MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Stock by Store', pad: 8, children: [
          Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Column(children: [
            for (int i = 0; i < detail.stockByStore.length; i++)
              Container(padding: const EdgeInsets.symmetric(vertical: 12), decoration: BoxDecoration(border: i < detail.stockByStore.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null), child: Row(children: [
                SizedBox(width: 54, child: Text(detail.stockByStore[i].storeCode, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3))),
                Expanded(child: Text(detail.stockByStore[i].storeName, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily))),
                Text('${detail.stockByStore[i].quantity}', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, color: SuperMaterialThemeData.of(context).superTheme.fg2)),
                const SizedBox(width: 14),
                Text(SuperFormat.number(detail.stockByStore[i].value, decimals: 2), style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
              ])),
          ])),
        ]),
        MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.tertiary, title: 'Recent Movements', pad: 8, children: [
          Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Column(children: [
            for (int i = 0; i < detail.recentMovements.length; i++)
              Container(padding: const EdgeInsets.symmetric(vertical: 12), decoration: BoxDecoration(border: i < detail.recentMovements.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null), child: Row(children: [
                Expanded(child: Text(detail.recentMovements[i].reference, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).colorScheme.primary))),
                Text(_movementLabel(detail.recentMovements[i].type), style: TextStyle(fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                const SizedBox(width: 14),
                SizedBox(width: 44, child: Text(_quantityLabel(detail.recentMovements[i]), textAlign: TextAlign.right, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, fontWeight: FontWeight.w600, color: detail.recentMovements[i].quantityDelta > 0 ? SuperMaterialThemeData.of(context).colorScheme.secondary : detail.recentMovements[i].quantityDelta < 0 ? SuperMaterialThemeData.of(context).colorScheme.error : SuperMaterialThemeData.of(context).superTheme.fg2))),
                const SizedBox(width: 10),
                SizedBox(width: 70, child: Text(_dateLabel(detail.recentMovements[i].occurredAt), textAlign: TextAlign.right, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3))),
              ])),
          ])),
        ]),
        MBtn('Back to Products', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => context.goTo('productsList')),
      ]),
    );
  }

  String _stockLabel(InventoryStockStatus status) => switch (status) { InventoryStockStatus.inStock => 'In Stock', InventoryStockStatus.lowStock => 'Low Stock', InventoryStockStatus.outOfStock => 'Out of Stock' };
  PillTone _stockTone(InventoryStockStatus status) => switch (status) { InventoryStockStatus.inStock => PillTone.success, InventoryStockStatus.lowStock => PillTone.warning, InventoryStockStatus.outOfStock => PillTone.danger };
  String _movementLabel(InventoryMovementType type) => switch (type) { InventoryMovementType.issue => 'Issue', InventoryMovementType.receive => 'Receive', InventoryMovementType.transfer => 'Transfer', InventoryMovementType.adjustment => 'Adjustment' };
  String _quantityLabel(InventoryMovement movement) => movement.type == InventoryMovementType.transfer ? '±${movement.quantityDelta.abs()}' : '${movement.quantityDelta > 0 ? '+' : '−'}${movement.quantityDelta.abs()}';
  String _dateLabel(DateTime value) => '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
}
