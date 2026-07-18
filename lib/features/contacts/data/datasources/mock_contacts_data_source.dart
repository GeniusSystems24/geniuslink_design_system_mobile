import '../../domain/domain.dart';

abstract final class MockContactsDataSource {
  static final customer = ContactKind(
    type: ContactType.customer,
    controlAccount: '1300 — Accounts Receivable',
    contacts: const [
      ContactSummary(code: 'CUST-102', name: 'Riyadh Construction Co.', arabicName: 'شركة الرياض للإنشاءات', city: 'Riyadh', balance: 24500, orderCount: 18, status: ContactStatus.active),
      ContactSummary(code: 'CUST-118', name: 'Najd Developers', arabicName: 'مطوّرو نجد', city: 'Riyadh', balance: 8200, orderCount: 6, status: ContactStatus.active),
      ContactSummary(code: 'CUST-134', name: 'Coastal Projects LLC', arabicName: 'مشاريع الساحل', city: 'Jeddah', balance: 0, orderCount: 2, status: ContactStatus.active),
      ContactSummary(code: 'CUST-141', name: 'Eastern Build Group', arabicName: 'مجموعة البناء الشرقية', city: 'Dammam', balance: 52140, orderCount: 31, status: ContactStatus.active),
      ContactSummary(code: 'CUST-150', name: 'Madinah Estates', arabicName: 'عقارات المدينة', city: 'Madinah', balance: 0, orderCount: 0, status: ContactStatus.pending),
    ],
    history: [
      ContactTransaction(reference: 'INV-2024-0412', description: 'Sales invoice', amount: 12400, occurredAt: DateTime(2025, 12, 14)),
      ContactTransaction(reference: 'DEP-2024-0182', description: 'Payment received', amount: -5000, occurredAt: DateTime(2025, 12, 18)),
      ContactTransaction(reference: 'INV-2024-0388', description: 'Sales invoice', amount: 17100, occurredAt: DateTime(2025, 12, 2)),
    ],
  );

  static final supplier = ContactKind(
    type: ContactType.supplier,
    controlAccount: '2001 — Accounts Payable',
    contacts: const [
      ContactSummary(code: 'SUP-201', name: 'Global Steel Imports LLC', arabicName: 'الاستيراد العالمي للصلب', city: 'London', balance: 12000, orderCount: 9, status: ContactStatus.active),
      ContactSummary(code: 'SUP-210', name: 'Saudi Cement Company', arabicName: 'شركة الأسمنت السعودية', city: 'Riyadh', balance: 34890, orderCount: 22, status: ContactStatus.active),
      ContactSummary(code: 'SUP-218', name: 'Gulf Aggregates', arabicName: 'حصى الخليج', city: 'Dammam', balance: 4200, orderCount: 14, status: ContactStatus.active),
      ContactSummary(code: 'SUP-225', name: 'Timber & Ply Trading', arabicName: 'تجارة الأخشاب', city: 'Jeddah', balance: 0, orderCount: 5, status: ContactStatus.inactive),
    ],
    history: [
      ContactTransaction(reference: 'PO-2024-0211', description: 'Purchase order', amount: 12000, occurredAt: DateTime(2025, 12, 10)),
      ContactTransaction(reference: 'EXT-2024-0311', description: 'Wire payment', amount: -12000, occurredAt: DateTime(2025, 12, 18)),
      ContactTransaction(reference: 'PO-2024-0198', description: 'Purchase order', amount: 34890, occurredAt: DateTime(2025, 11, 28)),
    ],
  );
}
