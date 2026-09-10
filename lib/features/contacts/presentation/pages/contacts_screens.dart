// ============================================================
// VIEW — Customers & Suppliers (ports MobileContacts)
// customersList · customerDetail · createCustomer
// suppliersList · supplierDetail · createSupplier
// ============================================================

import 'package:flutter/material.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';
import '../../domain/domain.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

part 'contact_list_screen.dart';
part 'create_contact_screen.dart';
part 'contact_detail_screen.dart';

part '../widgets/page_views/contact_detail_screen_view.dart';
part '../widgets/page_views/contact_list_screen_view.dart';
part '../widgets/page_views/create_contact_screen_view.dart';
String contactSingularLabel(ContactType type) =>
    type == ContactType.supplier ? 'Supplier' : 'Customer';
String contactPluralLabel(ContactType type) =>
    type == ContactType.supplier ? 'Suppliers' : 'Customers';
String contactBalanceLabel(ContactType type) =>
    type == ContactType.supplier ? 'Payable' : 'Receivable';
String formatContactDate(DateTime value) =>
    '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';

Color contactTone(BuildContext context, ContactKind kind) {
  final colors = SuperMaterialThemeData.of(context).colorScheme;
  return kind.isSupplier ? colors.error : colors.secondary;
}

PillTone contactStatusTone(ContactStatus status) => switch (status) {
  ContactStatus.active => PillTone.success,
  ContactStatus.pending => PillTone.warning,
  ContactStatus.inactive => PillTone.neutral,
};

String formatContactAmount(double amount, {bool signed = false}) {
  final absolute = amount.abs().toStringAsFixed(2);
  final parts = absolute.split('.');
  final digits = parts.first;
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
    buffer.write(digits[i]);
  }
  final sign = signed ? (amount >= 0 ? '+' : '−') : (amount < 0 ? '−' : '');
  return '$sign${buffer.toString()}.${parts.last}';
}
