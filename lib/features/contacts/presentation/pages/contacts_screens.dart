// ============================================================
// VIEW — Customers & Suppliers (ports MobileContacts)
// customersList · customerDetail · createCustomer
// suppliersList · supplierDetail · createSupplier
// ============================================================

import 'package:flutter/material.dart';
import '../../../../design_system/adapters/inventory/m_inv_kit.dart';
import '../../../../design_system/kit.dart';
import '../../../../workspace/presentation/controllers/nav_controller.dart';

class _ContactKind {
  final String label, labelPl, balanceLabel, control;
  final Color tone;
  final List<(String, String, String, String, String, int, String)> rows; // code,name,ar,city,balance,orders,status
  final List<(String, String, String, String)> history; // ref,desc,amount,when
  const _ContactKind(this.label, this.labelPl, this.balanceLabel, this.tone, this.control, this.rows, this.history);
}

const _customer = _ContactKind('Customer', 'Customers', 'Receivable', M.green, '1300 — Accounts Receivable', [
  ('CUST-102', 'Riyadh Construction Co.', 'شركة الرياض للإنشاءات', 'Riyadh', '24,500.00', 18, 'active'),
  ('CUST-118', 'Najd Developers', 'مطوّرو نجد', 'Riyadh', '8,200.00', 6, 'active'),
  ('CUST-134', 'Coastal Projects LLC', 'مشاريع الساحل', 'Jeddah', '0.00', 2, 'active'),
  ('CUST-141', 'Eastern Build Group', 'مجموعة البناء الشرقية', 'Dammam', '52,140.00', 31, 'active'),
  ('CUST-150', 'Madinah Estates', 'عقارات المدينة', 'Madinah', '0.00', 0, 'pending'),
], [
  ('INV-2024-0412', 'Sales invoice', '+12,400.00', 'Dec 14'),
  ('DEP-2024-0182', 'Payment received', '−5,000.00', 'Dec 18'),
  ('INV-2024-0388', 'Sales invoice', '+17,100.00', 'Dec 02'),
]);

const _supplier = _ContactKind('Supplier', 'Suppliers', 'Payable', M.red, '2001 — Accounts Payable', [
  ('SUP-201', 'Global Steel Imports LLC', 'الاستيراد العالمي للصلب', 'London', '12,000.00', 9, 'active'),
  ('SUP-210', 'Saudi Cement Company', 'شركة الأسمنت السعودية', 'Riyadh', '34,890.00', 22, 'active'),
  ('SUP-218', 'Gulf Aggregates', 'حصى الخليج', 'Dammam', '4,200.00', 14, 'active'),
  ('SUP-225', 'Timber & Ply Trading', 'تجارة الأخشاب', 'Jeddah', '0.00', 5, 'inactive'),
], [
  ('PO-2024-0211', 'Purchase order', '+12,000.00', 'Dec 10'),
  ('EXT-2024-0311', 'Wire payment', '−12,000.00', 'Dec 18'),
  ('PO-2024-0198', 'Purchase order', '+34,890.00', 'Nov 28'),
]);

PillTone _kTone(String s) => s == 'active' ? PillTone.success : (s == 'pending' ? PillTone.warning : PillTone.neutral);

class ContactListScreen extends StatefulWidget {
  final _ContactKind kind;
  final String detailKey;
  final NavController nav;
  const ContactListScreen._(this.kind, this.detailKey, this.nav, {super.key});
  factory ContactListScreen.customers(NavController nav) => ContactListScreen._(_customer, 'customerDetail', nav);
  factory ContactListScreen.suppliers(NavController nav) => ContactListScreen._(_supplier, 'supplierDetail', nav);
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
    return MScroll([
      SearchInput(placeholder: 'Search ${d.labelPl.toLowerCase()}…', value: _q, onChange: (v) => setState(() => _q = v)),
      Segmented(options: const ['All', 'Active', 'Pending', 'Inactive'], value: _status, onChange: (v) => setState(() => _status = v)),
      MCard(pad: 8, children: [
        for (int i = 0; i < visible.length; i++)
          GestureDetector(
            onTap: () => widget.nav.go(widget.detailKey),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
              decoration: BoxDecoration(border: i < visible.length - 1 ? const Border(bottom: BorderSide(color: M.border)) : null),
              child: Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(visible[i].$2, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
                  Directionality(textDirection: TextDirection.rtl, child: Text(visible[i].$3, style: const TextStyle(fontFamily: M.arabic, fontSize: 12, color: M.fg3))),
                  const SizedBox(height: 3),
                  Row(children: [
                    Text(visible[i].$1, style: const TextStyle(fontFamily: M.mono, fontSize: 10.5, color: M.fg3)),
                    const Text('  ·  ', style: TextStyle(color: M.fg4, fontSize: 10.5)),
                    Text(visible[i].$4, style: const TextStyle(fontSize: 10.5, color: M.fg3, fontFamily: M.body)),
                  ]),
                ])),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(visible[i].$5, style: TextStyle(fontFamily: M.mono, fontSize: 13, fontWeight: FontWeight.w600, color: double.parse(visible[i].$5.replaceAll(',', '')) == 0 ? M.fg4 : d.tone)),
                  const SizedBox(height: 4),
                  Pill(visible[i].$7, tone: _kTone(visible[i].$7)),
                ]),
              ]),
            ),
          ),
        if (visible.isEmpty) Padding(padding: const EdgeInsets.symmetric(vertical: 36), child: Center(child: Text('No ${d.labelPl.toLowerCase()} match.', style: const TextStyle(color: M.fg3, fontSize: 13, fontFamily: M.body)))),
      ]),
    ]);
  }
}

class CreateContactScreen extends StatelessWidget {
  final _ContactKind kind;
  const CreateContactScreen._(this.kind, {super.key});
  factory CreateContactScreen.customer() => const CreateContactScreen._(_customer);
  factory CreateContactScreen.supplier() => const CreateContactScreen._(_supplier);
  @override
  Widget build(BuildContext context) {
    final d = kind;
    return MScroll([
      ISection(icon: 'user', title: '${d.label} Identity', sub: 'Legal name and contact details', marker: M.blue, children: [
        TInput(label: 'Name English', placeholder: d.label == 'Customer' ? 'e.g. Riyadh Construction Co.' : 'e.g. Global Steel Imports LLC', required: true),
        const TInput(label: 'الاسم بالعربية', placeholder: 'مثال: شركة الرياض للإنشاءات', ar: true),
        const TInput(label: 'Contact Person', placeholder: 'e.g. Ahmed K.'),
        const TInput(label: 'Phone', placeholder: '+966 5X XXX XXXX', mono: true),
        const TInput(label: 'Email', placeholder: 'name@company.com'),
        const TInput(label: 'City', placeholder: 'e.g. Riyadh'),
      ]),
      ISection(icon: 'swap', title: 'Financial', sub: 'Linked control account and terms', marker: M.green, children: [
        TSelect(label: 'Control Account', value: d.control, options: [d.control]),
        const TSelect(label: 'Payment Terms', value: 'Net 30', options: ['Net 15', 'Net 30', 'Net 60', 'On Receipt']),
        const TInput(label: 'Tax / VAT Number', placeholder: '3XXXXXXXXXXXXX3', mono: true),
        const TInput(label: 'Credit Limit (SAR)', placeholder: 'e.g. 100,000.00', mono: true),
      ]),
      ISection(icon: 'doc', title: 'Notes', marker: M.orange, children: [
        ITextarea(label: 'Notes', placeholder: 'Internal notes about this ${d.label.toLowerCase()}…'),
      ]),
      Row(children: [
        const Expanded(child: MBtn('Cancel', variant: MBtnVariant.secondary, full: true)),
        const SizedBox(width: 10),
        Expanded(child: MBtn('Add ${d.label}', icon: 'check', full: true)),
      ]),
    ]);
  }
}

class ContactDetailScreen extends StatelessWidget {
  final _ContactKind kind;
  const ContactDetailScreen._(this.kind, {super.key});
  factory ContactDetailScreen.customer() => const ContactDetailScreen._(_customer);
  factory ContactDetailScreen.supplier() => const ContactDetailScreen._(_supplier);
  @override
  Widget build(BuildContext context) {
    final d = kind;
    final c = d.rows.first;
    return MScroll([
      MCard(marker: M.green, title: 'Outstanding ${d.balanceLabel}', sub: '${c.$6} orders · since Apr 2024', right: const Pill('Active'), children: [
        Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          const Text('SAR', style: TextStyle(fontFamily: M.mono, fontSize: 14, color: M.fg3)),
          const SizedBox(width: 8),
          Text(c.$5, style: TextStyle(fontFamily: M.mono, fontSize: 32, fontWeight: FontWeight.w700, color: d.tone, letterSpacing: -0.6)),
        ]),
      ]),
      MCard(marker: M.blue, title: '${d.label} Information', children: [
        KV('Code', c.$1, mono: true), KV('City', c.$4), const KV('Contact Person', 'Ahmed K.'),
        const KV('Phone', '+966 55 124 9020', mono: true),
        KV('Control Account', d.label == 'Customer' ? '1300 — A/R' : '2001 — A/P'), const KV('Payment Terms', 'Net 30'),
      ]),
      MCard(marker: M.orange, title: 'Transaction History', sub: 'Recent invoices and payments', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < d.history.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i < d.history.length - 1 ? const Border(bottom: BorderSide(color: M.border)) : null),
                child: Row(children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(d.history[i].$1, style: const TextStyle(fontFamily: M.mono, fontSize: 12, color: M.blue)),
                    const SizedBox(height: 2),
                    Text('${d.history[i].$2} · ${d.history[i].$4}', style: const TextStyle(fontSize: 12, color: M.fg3, fontFamily: M.body)),
                  ])),
                  Text(d.history[i].$3, style: TextStyle(fontFamily: M.mono, fontSize: 13.5, fontWeight: FontWeight.w600, color: d.history[i].$3.startsWith('+') ? M.green : M.red)),
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
    ]);
  }
}
