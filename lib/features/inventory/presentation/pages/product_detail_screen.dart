// ignore_for_file: public_member_api_docs, sort_constructors_first
// ============================================================
// VIEW — Products & Inventory operations (ports MobileInventory)
// productsList · productDetail · createProduct · issueDetail
// receiveCreate · receiveDetail · transferCreate · transferDetail · adjustment
// ============================================================

import 'package:flutter/material.dart';
import 'package:gl_mobile_app/app/router/navigation_extensions.dart';
import 'package:gl_mobile_app/design_system/kit.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const byStore = [('ST-001', 'Downtown Central', 88, '39,600.00'), ('ST-002', 'King Fahd Warehouse', 42, '18,900.00'), ('ST-003', 'Jeddah Showroom', 12, '5,400.00')];
    const moves = [('INV-ISS-0089', 'Issue', '−12', 'Dec 18'), ('INV-REC-0241', 'Receive', '+32', 'Dec 16'), ('INV-TRF-0117', 'Transfer', '±18', 'Dec 14')];
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Product Detail'),
      body: MScroll([
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Stock Summary', subtitle: 'Aggregated across all stores', trailing: const Pill('In Stock'), children: [
        GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 2.0, children: const [
          Mini(label: 'Total On Hand', value: '142', sub: 'PCS', hi: true),
          Mini(label: 'Stock Value', value: '63,900', sub: 'SAR'),
          Mini(label: 'Avg Unit Cost', value: '450.00', sub: 'SAR'),
          Mini(label: 'Reorder Level', value: '50', sub: 'PCS'),
        ]),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Product Information', children: [
        KV('SKU', 'STL-44021', mono: true), KV('Barcode', '6 281000 044021', mono: true),
        KV('Category', 'Steel'), KV('Unit', 'PCS'), KV('Selling Price', '540.00 SAR'), KV('VAT Rate', '15%'),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Stock by Store', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < byStore.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i < byStore.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                child: Row(children: [
                  SizedBox(width: 54, child: Text(byStore[i].$1, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3))),
                  Expanded(child: Text(byStore[i].$2, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily))),
                  Text('${byStore[i].$3}', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, color: SuperMaterialThemeData.of(context).superTheme.fg2)),
                  const SizedBox(width: 14),
                  Text(byStore[i].$4, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
                ]),
              ),
          ]),
        ),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.tertiary, title: 'Recent Movements', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < moves.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i < moves.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                child: Row(children: [
                  Expanded(child: Text(moves[i].$1, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).colorScheme.primary))),
                  Text(moves[i].$2, style: TextStyle(fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                  const SizedBox(width: 14),
                  SizedBox(width: 44, child: Text(moves[i].$3, textAlign: TextAlign.right, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, fontWeight: FontWeight.w600, color: moves[i].$3.startsWith('+') ? SuperMaterialThemeData.of(context).colorScheme.secondary : (moves[i].$3.startsWith('−') ? SuperMaterialThemeData.of(context).colorScheme.error : SuperMaterialThemeData.of(context).superTheme.fg2)))),
                  const SizedBox(width: 10),
                  SizedBox(width: 44, child: Text(moves[i].$4, textAlign: TextAlign.right, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3))),
                ]),
              ),
          ]),
        ),
      ]),
      MBtn('Back to Products', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => context.goTo('productsList')),
    ]),
    );
  }
}
