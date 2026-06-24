// ============================================================
// VIEW — Products & Inventory operations (ports MobileInventory)
// productsList · productDetail · createProduct · issueDetail
// receiveCreate · receiveDetail · transferCreate · transferDetail · adjustment
// ============================================================

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';
import '../../../../design_system/adapters/inventory/m_inv_kit.dart';
import '../../../../workspace/presentation/controllers/nav_controller.dart';

const _products = [
  ('STL-44021', 'Structural Steel I-Beam', 'Steel', 'PCS', 142, 'in'),
  ('CMT-90112', 'Portland Cement Type I', 'Cement', 'BAG', 1820, 'in'),
  ('AGG-21044', 'Coarse Aggregate 20mm', 'Aggregate', 'TON', 46, 'low'),
  ('RBR-71203', 'Reinforcement Bar #6', 'Steel', 'PCS', 0, 'out'),
  ('PLY-30022', 'Plywood Sheet 18mm', 'Timber', 'SHT', 312, 'in'),
  ('PNT-55310', 'Epoxy Floor Coating', 'Finishing', 'L', 88, 'in'),
];

PillTone _statusTone(String s) => s == 'in' ? PillTone.success : (s == 'low' ? PillTone.warning : PillTone.danger);
String _statusLabel(String s) => s == 'in' ? 'In Stock' : (s == 'low' ? 'Low' : 'Out');

class ProductsListScreen extends StatefulWidget {
  final NavController nav;
  const ProductsListScreen({super.key, required this.nav});
  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  String _cat = 'All';
  @override
  Widget build(BuildContext context) {
    const cats = ['All', 'Steel', 'Cement', 'Aggregate', 'Timber', 'Finishing'];
    final rows = _cat == 'All' ? _products : _products.where((p) => p.$3 == _cat).toList();
    return MScroll([
      Container(
        height: 44, padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(color: M.input, border: Border.all(color: M.borderStrong), borderRadius: BorderRadius.circular(10)),
        child: const Row(children: [Icon(Icons.search_rounded, size: 16, color: M.fg3), SizedBox(width: 10), Text('Search product or SKU…', style: TextStyle(color: M.fg3, fontSize: 14, fontFamily: M.body))]),
      ),
      SizedBox(
        height: 32,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: cats.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (_, i) {
            final on = cats[i] == _cat;
            return GestureDetector(
              onTap: () => setState(() => _cat = cats[i]),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                alignment: Alignment.center,
                decoration: BoxDecoration(color: on ? M.blue : M.input, border: Border.all(color: on ? M.blue : M.border), borderRadius: BorderRadius.circular(999)),
                child: Text(cats[i].toUpperCase(), style: TextStyle(fontFamily: M.body, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: on ? Colors.white : M.fg3)),
              ),
            );
          },
        ),
      ),
      MCard(pad: 8, children: [
        for (int i = 0; i < rows.length; i++)
          GestureDetector(
            onTap: () => widget.nav.go('productDetail'),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
              decoration: BoxDecoration(border: i < rows.length - 1 ? const Border(bottom: BorderSide(color: M.border)) : null),
              child: Row(children: [
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(rows[i].$2, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
                    const SizedBox(height: 3),
                    Row(children: [
                      Text(rows[i].$1, style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)),
                      const Text('  ·  ', style: TextStyle(color: M.fg4, fontSize: 11)),
                      Text(rows[i].$3, style: const TextStyle(fontSize: 11, color: M.fg3, fontFamily: M.body)),
                    ]),
                  ]),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(text: '${rows[i].$5} ', style: TextStyle(fontFamily: M.mono, fontSize: 13, fontWeight: FontWeight.w600, color: rows[i].$5 == 0 ? M.red : (rows[i].$6 == 'low' ? M.orange : M.fg1))),
                    TextSpan(text: rows[i].$4, style: const TextStyle(fontFamily: M.mono, fontSize: 10, color: M.fg3)),
                  ])),
                  const SizedBox(height: 4),
                  Pill(_statusLabel(rows[i].$6), tone: _statusTone(rows[i].$6)),
                ]),
              ]),
            ),
          ),
      ]),
    ]);
  }
}

class ProductDetailScreen extends StatelessWidget {
  final NavController nav;
  const ProductDetailScreen({super.key, required this.nav});
  @override
  Widget build(BuildContext context) {
    const byStore = [('ST-001', 'Downtown Central', 88, '39,600.00'), ('ST-002', 'King Fahd Warehouse', 42, '18,900.00'), ('ST-003', 'Jeddah Showroom', 12, '5,400.00')];
    const moves = [('INV-ISS-0089', 'Issue', '−12', 'Dec 18'), ('INV-REC-0241', 'Receive', '+32', 'Dec 16'), ('INV-TRF-0117', 'Transfer', '±18', 'Dec 14')];
    return MScroll([
      MCard(marker: M.green, title: 'Stock Summary', sub: 'Aggregated across all stores', right: const Pill('In Stock'), children: [
        GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: NeverScrollableScrollPhysics(), mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 2.0, children: [
          Mini(label: 'Total On Hand', value: '142', sub: 'PCS', hi: true),
          Mini(label: 'Stock Value', value: '63,900', sub: 'SAR'),
          Mini(label: 'Avg Unit Cost', value: '450.00', sub: 'SAR'),
          Mini(label: 'Reorder Level', value: '50', sub: 'PCS'),
        ]),
      ]),
      const MCard(marker: M.blue, title: 'Product Information', children: [
        KV('SKU', 'STL-44021', mono: true), KV('Barcode', '6 281000 044021', mono: true),
        KV('Category', 'Steel'), KV('Unit', 'PCS'), KV('Selling Price', '540.00 SAR'), KV('VAT Rate', '15%'),
      ]),
      MCard(marker: M.green, title: 'Stock by Store', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < byStore.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i < byStore.length - 1 ? const Border(bottom: BorderSide(color: M.border)) : null),
                child: Row(children: [
                  SizedBox(width: 54, child: Text(byStore[i].$1, style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3))),
                  Expanded(child: Text(byStore[i].$2, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body))),
                  Text('${byStore[i].$3}', style: const TextStyle(fontFamily: M.mono, fontSize: 13, color: M.fg2)),
                  const SizedBox(width: 14),
                  Text(byStore[i].$4, style: const TextStyle(fontFamily: M.mono, fontSize: 13, fontWeight: FontWeight.w600, color: M.fg1)),
                ]),
              ),
          ]),
        ),
      ]),
      MCard(marker: M.orange, title: 'Recent Movements', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < moves.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i < moves.length - 1 ? const Border(bottom: BorderSide(color: M.border)) : null),
                child: Row(children: [
                  Expanded(child: Text(moves[i].$1, style: const TextStyle(fontFamily: M.mono, fontSize: 12, color: M.blue))),
                  Text(moves[i].$2, style: const TextStyle(fontSize: 12, color: M.fg3, fontFamily: M.body)),
                  const SizedBox(width: 14),
                  SizedBox(width: 44, child: Text(moves[i].$3, textAlign: TextAlign.right, style: TextStyle(fontFamily: M.mono, fontSize: 13, fontWeight: FontWeight.w600, color: moves[i].$3.startsWith('+') ? M.green : (moves[i].$3.startsWith('−') ? M.red : M.fg2)))),
                  const SizedBox(width: 10),
                  SizedBox(width: 44, child: Text(moves[i].$4, textAlign: TextAlign.right, style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3))),
                ]),
              ),
          ]),
        ),
      ]),
      MBtn('Back to Products', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => nav.back('productsList')),
    ]);
  }
}

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MScroll([
      const ISection(icon: 'box', title: 'Product Definition', sub: 'SKU, names and classification', marker: M.blue, children: [
        IField(label: 'SKU', placeholder: 'e.g. STL-44021', mono: true, required: true),
        IField(label: 'Barcode', placeholder: 'Scan or type', mono: true, icon: 'scan'),
        IField(label: 'Name English', placeholder: 'e.g. Structural Steel I-Beam', required: true),
        IField(label: 'الاسم بالعربية', placeholder: 'مثال: كمرة فولاذية', ar: true, required: true),
        IField(label: 'Category', value: 'Steel', select: true),
        IField(label: 'Unit of Measure', value: 'PCS', select: true),
      ]),
      const ISection(icon: 'swap', title: 'Costing & Pricing', marker: M.green, children: [
        IField(label: 'Unit Cost (SAR)', placeholder: '0.00', mono: true),
        IField(label: 'Selling Price (SAR)', placeholder: '0.00', mono: true),
        IField(label: 'VAT Rate', value: '15%', select: true),
      ]),
      const ISection(icon: 'store', title: 'Inventory Settings', marker: M.orange, children: [
        IField(label: 'Reorder Level', placeholder: 'e.g. 50', mono: true),
        IField(label: 'Default Store', value: 'Downtown Central', select: true),
        IField(label: 'Opening Stock', placeholder: '0', mono: true),
        UploadBox(),
      ]),
      const ActionRow(primary: 'Create Product'),
    ]);
  }
}

class IssueDetailScreen extends StatelessWidget {
  final NavController nav;
  const IssueDetailScreen({super.key, required this.nav});
  @override
  Widget build(BuildContext context) {
    return MScroll([
      MCard(marker: M.green, title: 'Issued Value', sub: 'INV-ISS-2024-0089 · Dec 18, 2025', right: const Pill('Posted'), children: const [
        Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Text('USD', style: TextStyle(fontFamily: M.mono, fontSize: 14, color: M.fg3)),
          SizedBox(width: 8),
          Text('5,400.00', style: TextStyle(fontFamily: M.mono, fontSize: 32, fontWeight: FontWeight.w700, color: M.fg1, letterSpacing: -0.6)),
        ]),
      ]),
      const MCard(marker: M.blue, title: 'Issue Information', children: [
        KV('Serial No', 'INV-ISS-2024-0089', mono: true), KV('Store', 'Downtown Central'),
        KV('Customer', 'Project A-92'), KV('Currency', 'USD — US Dollar'),
      ]),
      const MCard(marker: M.green, title: 'Accounting Distribution', pad: 16, children: [
        _DistRow(account: '1200 — Inventory (WIP)', side: 'Debit', amount: '+5,400.00', last: false),
        _DistRow(account: '5001 — Cost of Goods Sold', side: 'Credit', amount: '−5,400.00', last: true),
      ]),
      MBtn('Back to Operations', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => nav.back('more')),
    ]);
  }
}

class _DistRow extends StatelessWidget {
  final String account, side, amount;
  final bool last;
  const _DistRow({required this.account, required this.side, required this.amount, this.last = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(border: last ? null : const Border(bottom: BorderSide(color: M.border))),
      child: Row(children: [
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(account, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
            const SizedBox(height: 4),
            Pill(side, tone: side == 'Debit' ? PillTone.info : PillTone.danger),
          ]),
        ),
        Text(amount, style: TextStyle(fontFamily: M.mono, fontSize: 13.5, fontWeight: FontWeight.w600, color: amount.startsWith('+') ? M.green : M.red)),
      ]),
    );
  }
}

class ReceiveCreateScreen extends StatelessWidget {
  const ReceiveCreateScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MScroll([
      const ISection(icon: 'box', title: 'Receive Details', marker: M.blue, children: [
        IField(label: 'Serial No', value: 'INV-REC-2024-0241', mono: true, locked: true),
        IField(label: 'Currency', value: 'SAR — Saudi Riyal', select: true),
        IField(label: 'Receiving Store', placeholder: 'Search store…', icon: 'store', required: true),
        IField(label: 'Supplier Account', placeholder: 'e.g. ABC Trading Co.', required: true),
      ]),
      const ISection(icon: 'cart', title: 'Inventory Items', sub: '2 lines · received into stock', marker: M.green, children: [
        Scanner(),
        ProductRow(name: 'Portland Cement Type I', sku: 'CMT-90112', qty: 400, price: '24.50', total: '9,800.00', currency: ''),
        ProductRow(name: 'Structural Steel I-Beam', sku: 'STL-44021', qty: 32, price: '450.00', total: '14,400.00', currency: '', last: true),
        AddProductBtn(),
      ]),
      const ISection(icon: 'swap', title: 'Accounting Distribution', marker: M.green, children: [
        _DistRow(account: '1200 — Inventory (WIP)', side: 'Debit', amount: '+24,200.00', last: false),
        _DistRow(account: '2001 — Accounts Payable', side: 'Credit', amount: '−24,200.00', last: true),
        _BalancedRow(value: '24,200.00'),
      ]),
      const ISection(icon: 'doc', title: 'Notes & Docs', marker: M.orange, children: [
        ITextarea(label: 'Receipt Notes', placeholder: 'PO number, delivery note, inspection results…'),
        UploadBox(),
      ]),
      const ActionRow(primary: 'Receive Inventory'),
    ]);
  }
}

class _BalancedRow extends StatelessWidget {
  final String value;
  const _BalancedRow({required this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: M.borderStrong, width: 2))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Eyebrow('Balanced · Diff 0.00', color: M.green, size: 11),
        Text(value, style: const TextStyle(fontFamily: M.mono, fontSize: 15, fontWeight: FontWeight.w700, color: M.fg1)),
      ]),
    );
  }
}

class ReceiveDetailScreen extends StatelessWidget {
  final NavController nav;
  const ReceiveDetailScreen({super.key, required this.nav});
  @override
  Widget build(BuildContext context) {
    const items = [('Portland Cement Type I', '400 BAG × 24.50', '9,800.00'), ('Structural Steel I-Beam', '32 PCS × 450.00', '14,400.00')];
    return MScroll([
      MCard(marker: M.green, title: 'Received Value', sub: 'INV-REC-2024-0241 · Dec 16, 2025', right: const Pill('Posted'), children: const [
        Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Text('SAR', style: TextStyle(fontFamily: M.mono, fontSize: 14, color: M.fg3)),
          SizedBox(width: 8),
          Text('+24,200.00', style: TextStyle(fontFamily: M.mono, fontSize: 32, fontWeight: FontWeight.w700, color: M.green, letterSpacing: -0.6)),
        ]),
      ]),
      const MCard(marker: M.blue, title: 'Receipt Information', children: [
        KV('Serial No', 'INV-REC-2024-0241', mono: true), KV('Receiving Store', 'King Fahd Warehouse'),
        KV('Supplier', 'ABC Trading Co.'), KV('PO Reference', 'PO-2024-1182', mono: true),
      ]),
      MCard(marker: M.green, title: 'Items', sub: '2 lines · 432 units', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < items.length; i++) _ItemLine(item: items[i], last: i == items.length - 1),
          ]),
        ),
      ]),
      const MCard(marker: M.orange, title: 'Audit Information', children: [
        AuditGridLite(rows: [('Received By', 'Layla A. (ID: 12)', false), ('Received At', 'Dec 16, 14:32', true), ('Linked Journal', 'JV-2024-0241', true), ('Audit Hash', 'b3e1…a072', true)]),
      ]),
      MBtn('Back to List', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => nav.back('more')),
    ]);
  }
}

class _ItemLine extends StatelessWidget {
  final (String, String, String) item;
  final bool last;
  const _ItemLine({required this.item, required this.last});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(border: last ? null : const Border(bottom: BorderSide(color: M.border))),
      child: Row(children: [
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(item.$1, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
            const SizedBox(height: 2),
            Text(item.$2, style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)),
          ]),
        ),
        Text(item.$3, style: const TextStyle(fontFamily: M.mono, fontSize: 14, fontWeight: FontWeight.w600, color: M.fg1)),
      ]),
    );
  }
}

/// A lightweight 2-col audit grid (kept here to avoid bank-kit dependency).
class AuditGridLite extends StatelessWidget {
  final List<(String, String, bool)> rows;
  const AuditGridLite({super.key, required this.rows});
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 4.2,
      children: [
        for (final r in rows)
          Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
            Eyebrow(r.$1, color: M.fg3, size: 9.5),
            const SizedBox(height: 5),
            Text(r.$2, style: TextStyle(fontSize: 12.5, color: M.fg1, fontFamily: r.$3 ? M.mono : M.body)),
          ]),
      ],
    );
  }
}

class TransferCreateScreen extends StatelessWidget {
  const TransferCreateScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MScroll([
      const ISection(icon: 'box', title: 'Transfer Details', marker: M.blue, children: [
        IField(label: 'Serial No', value: 'INV-TRF-2024-0117', mono: true, locked: true),
        IField(label: 'Currency', value: 'SAR — Saudi Riyal', select: true),
        IField(label: 'From Store', placeholder: 'Search origin warehouse…', icon: 'store', required: true),
        IField(label: 'To Store', placeholder: 'Search destination…', icon: 'pin', required: true),
      ]),
      const ISection(icon: 'cart', title: 'Products', marker: M.blue, children: [
        Scanner(),
        ProductRow(name: 'Coarse Aggregate 20mm', sku: 'AGG-21044', qty: 18, price: '125.00', total: '2,250.00', currency: ''),
        ProductRow(name: 'Reinforcement Bar #6', sku: 'RBR-71203', qty: 240, price: '78.00', total: '18,720.00', currency: '', last: true),
        AddProductBtn(),
      ]),
      const ISection(icon: 'doc', title: 'Notes & Docs', marker: M.orange, children: [
        ITextarea(label: 'Notes', placeholder: 'Enter transfer notes or internal instructions…'),
        UploadBox(),
      ]),
      const ActionRow(primary: 'Transfer Inventory'),
    ]);
  }
}

class TransferDetailScreen extends StatelessWidget {
  final NavController nav;
  const TransferDetailScreen({super.key, required this.nav});
  @override
  Widget build(BuildContext context) {
    const items = [('Coarse Aggregate 20mm', '18 TON × 125.00', '2,250.00'), ('Reinforcement Bar #6', '240 PCS × 78.00', '18,720.00')];
    return MScroll([
      MCard(marker: M.blue, title: 'In Transit', right: const Pill('In Transit', tone: PillTone.warning), children: [
        const Padding(padding: EdgeInsets.only(bottom: 2), child: Text('INV-TRF-2024-0117', style: TextStyle(fontFamily: M.mono, fontSize: 12, color: M.blue))),
        _TransferFlowCard(tone: M.orange, label: 'From Store', store: 'ST-001 · Downtown Central', ar: 'متجر وسط المدينة', delta: '−54,892 SAR', deltaColor: M.red),
        Transform.translate(
          offset: const Offset(0, -6),
          child: Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: M.blue, shape: BoxShape.circle, boxShadow: [BoxShadow(color: tint(M.blue, 0x99), blurRadius: 18, offset: const Offset(0, 6))]),
            child: const Icon(Icons.keyboard_arrow_down_rounded, size: 22, color: Colors.white),
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -6),
          child: const _TransferFlowCard(tone: M.green, label: 'To Store', store: 'ST-002 · King Fahd Warehouse', ar: 'مستودع الملك فهد', delta: '+54,892 SAR', deltaColor: M.green),
        ),
      ]),
      MCard(marker: M.green, title: 'Items in Transit', sub: '2 lines · 258 units', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < items.length; i++) _ItemLine(item: items[i], last: i == items.length - 1),
          ]),
        ),
      ]),
      const MCard(marker: M.blue, title: 'Logistics & Tracking', children: [
        KV('Carrier', 'Plate 4892-RKD'), KV('Driver', 'Mohammed S.'), KV('Expected Arrival', 'Dec 20, 2025', mono: true),
      ]),
      MBtn('Back to List', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => nav.back('transferList')),
    ]);
  }
}

class _TransferFlowCard extends StatelessWidget {
  final Color tone, deltaColor;
  final String label, store, ar, delta;
  const _TransferFlowCard({required this.tone, required this.label, required this.store, required this.ar, required this.delta, required this.deltaColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: tint(tone, 0x0F), border: Border.all(color: tint(tone, 0x40)), borderRadius: BorderRadius.circular(10)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: 4, height: 56, decoration: BoxDecoration(color: tone, borderRadius: BorderRadius.circular(12))),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Eyebrow(label, color: tone, size: 9.5),
            const SizedBox(height: 6),
            Text(store, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
            Directionality(textDirection: TextDirection.rtl, child: Text(ar, style: const TextStyle(fontFamily: M.arabic, fontSize: 12, color: M.fg3))),
            Container(
              margin: const EdgeInsets.only(top: 10), padding: const EdgeInsets.only(top: 10), width: double.infinity,
              decoration: const BoxDecoration(border: Border(top: BorderSide(color: M.border))),
              child: Text(delta, style: TextStyle(fontFamily: M.mono, fontSize: 11.5, fontWeight: FontWeight.w600, color: deltaColor)),
            ),
          ]),
        ),
      ]),
    );
  }
}

class AdjustmentScreen extends StatelessWidget {
  const AdjustmentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const items = [
      ('STL-44021', 'Structural Steel I-Beam', 142, 140, 'Damaged · 2 units'),
      ('CMT-90112', 'Portland Cement Type I', 1820, 1834, 'Receiving miscount · +14'),
      ('AGG-21044', 'Coarse Aggregate 20mm', 48, 46, 'Spillage · 2 tons'),
    ];
    return MScroll([
      const ISection(icon: 'box', title: 'Adjustment Details', marker: M.blue, children: [
        IField(label: 'Serial No', value: 'INV-ADJ-2024-0058', mono: true, locked: true),
        IField(label: 'Reason', value: 'Physical Stock Count', select: true),
        IField(label: 'Store', placeholder: 'Search store…', icon: 'store', required: true),
        IField(label: 'Count Date', placeholder: 'mm/dd/yyyy', mono: true, icon: 'calendar'),
      ]),
      const MCard(marker: M.orange, title: 'Variance Summary', sub: 'Net financial impact of this reconciliation', children: [
        Row(children: [
          Expanded(child: Mini(label: 'Lines Adjusted', value: '3')),
          SizedBox(width: 12),
          Expanded(child: Mini(label: 'Net Adjustment', value: '−307.00', sub: 'SAR')),
        ]),
      ]),
      MCard(marker: M.green, title: 'Adjustment Lines', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < items.length; i++) _AdjLine(item: items[i], last: i == items.length - 1),
          ]),
        ),
      ]),
      const ISection(icon: 'doc', title: 'Documentation & Approval', marker: M.orange, children: [
        ITextarea(label: 'Adjustment Notes', placeholder: 'Auditor name, witness, count session reference…'),
        UploadBox(),
        InfoNote('Adjustments above 1,000 SAR require dual approval. This entry posts to the audit log immediately and notifies the controller.'),
      ]),
      const ActionRow(primary: 'Post Adjustment'),
    ]);
  }
}

class _AdjLine extends StatelessWidget {
  final (String, String, int, int, String) item;
  final bool last;
  const _AdjLine({required this.item, required this.last});
  @override
  Widget build(BuildContext context) {
    final delta = item.$4 - item.$3;
    final pos = delta > 0;
    final tone = delta == 0 ? M.fg2 : (pos ? M.green : M.red);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(border: last ? null : const Border(bottom: BorderSide(color: M.border))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(item.$2, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
              const SizedBox(height: 2),
              Text('${item.$1} · ${item.$5}', style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)),
            ]),
          ),
          Text('${pos ? '+' : ''}$delta', style: TextStyle(fontFamily: M.mono, fontSize: 15, fontWeight: FontWeight.w700, color: tone)),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          Text.rich(TextSpan(children: [const TextSpan(text: 'System ', style: TextStyle(color: M.fg3)), TextSpan(text: '${item.$3}', style: const TextStyle(color: M.fg2))], style: const TextStyle(fontFamily: M.mono, fontSize: 11))),
          const SizedBox(width: 16),
          Text.rich(TextSpan(children: [const TextSpan(text: 'Counted ', style: TextStyle(color: M.fg3)), TextSpan(text: '${item.$4}', style: const TextStyle(color: M.fg1, fontWeight: FontWeight.w600))], style: const TextStyle(fontFamily: M.mono, fontSize: 11))),
        ]),
      ]),
    );
  }
}
