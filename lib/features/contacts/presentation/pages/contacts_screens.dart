// ============================================================
// VIEW — Customers & Suppliers (ports MobileContacts)
// customersList · customerDetail · createCustomer
// suppliersList · supplierDetail · createSupplier
// ============================================================

import 'package:flutter/material.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';

part 'contact_list_screen.dart';
part 'create_contact_screen.dart';
part 'contact_detail_screen.dart';

class _ContactKind {
  final String label, labelPl, balanceLabel, control;
  final bool supplier;
  final List<(String, String, String, String, String, int, String)> rows; // code,name,ar,city,balance,orders,status
  final List<(String, String, String, String)> history; // ref,desc,amount,when
  const _ContactKind(this.label, this.labelPl, this.balanceLabel, this.supplier, this.control, this.rows, this.history);

  Color tone(BuildContext context) {
    final colors = SuperMaterialThemeData.of(context).colorScheme;
    return supplier ? colors.error : colors.secondary;
  }
}

final _customer = _ContactKind('Customer', 'Customers', 'Receivable', false, '1300 — Accounts Receivable', [
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

final _supplier = _ContactKind('Supplier', 'Suppliers', 'Payable', true, '2001 — Accounts Payable', [
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
