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
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Product Detail')),
      body: MScroll([
      MCard(accentColor: SuperTokens.success, title: 'Stock Summary', subtitle: 'Aggregated across all stores', trailing: const Pill('In Stock'), children: [
        GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 2.0, children: const [
          Mini(label: 'Total On Hand', value: '142', sub: 'PCS', hi: true),
          Mini(label: 'Stock Value', value: '63,900', sub: 'SAR'),
          Mini(label: 'Avg Unit Cost', value: '450.00', sub: 'SAR'),
          Mini(label: 'Reorder Level', value: '50', sub: 'PCS'),
        ]),
      ]),
      const MCard(accentColor: SuperTokens.accent, title: 'Product Information', children: [
        KV('SKU', 'STL-44021', mono: true), KV('Barcode', '6 281000 044021', mono: true),
        KV('Category', 'Steel'), KV('Unit', 'PCS'), KV('Selling Price', '540.00 SAR'), KV('VAT Rate', '15%'),
      ]),
      MCard(accentColor: SuperTokens.success, title: 'Stock by Store', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < byStore.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i < byStore.length - 1 ? Border(bottom: BorderSide(color: SuperThemeData.dark.border)) : null),
                child: Row(children: [
                  SizedBox(width: 54, child: Text(byStore[i].$1, style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 11, color: SuperThemeData.dark.fg3))),
                  Expanded(child: Text(byStore[i].$2, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SuperThemeData.dark.fg1, fontFamily: SuperTokens.bodyFont))),
                  Text('${byStore[i].$3}', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 13, color: SuperThemeData.dark.fg2)),
                  const SizedBox(width: 14),
                  Text(byStore[i].$4, style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 13, fontWeight: FontWeight.w600, color: SuperThemeData.dark.fg1)),
                ]),
              ),
          ]),
        ),
      ]),
      MCard(accentColor: SuperTokens.warning, title: 'Recent Movements', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < moves.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i < moves.length - 1 ? Border(bottom: BorderSide(color: SuperThemeData.dark.border)) : null),
                child: Row(children: [
                  Expanded(child: Text(moves[i].$1, style: const TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 12, color: SuperTokens.accent))),
                  Text(moves[i].$2, style: TextStyle(fontSize: 12, color: SuperThemeData.dark.fg3, fontFamily: SuperTokens.bodyFont)),
                  const SizedBox(width: 14),
                  SizedBox(width: 44, child: Text(moves[i].$3, textAlign: TextAlign.right, style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 13, fontWeight: FontWeight.w600, color: moves[i].$3.startsWith('+') ? SuperTokens.success : (moves[i].$3.startsWith('−') ? SuperTokens.danger : SuperThemeData.dark.fg2)))),
                  const SizedBox(width: 10),
                  SizedBox(width: 44, child: Text(moves[i].$4, textAlign: TextAlign.right, style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 11, color: SuperThemeData.dark.fg3))),
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
