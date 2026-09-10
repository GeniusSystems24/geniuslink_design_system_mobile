// ============================================================
// VIEW — Reports & Dashboards (ports MobileReports)
// trialBalance · incomeStatement · balanceSheet
// inventoryValuation · auditLog
// ============================================================

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';

import '../widgets/widgets.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/shared/presentation/widgets/feature_page_scaffold.dart';
export '../widgets/widgets.dart';
part 'trial_balance_screen.dart';
part 'income_statement_screen.dart';
part 'balance_sheet_screen.dart';
part 'inventory_valuation_screen.dart';
part 'audit_log_screen.dart';

part '../widgets/audit_log_view.dart';
part '../widgets/balance_sheet_view.dart';
part '../widgets/income_statement_view.dart';
part '../widgets/inventory_valuation_view.dart';
part '../widgets/trial_balance_view.dart';
String _money(num n) {
  final v = n.abs().toStringAsFixed(2);
  final parts = v.split('.');
  final buf = StringBuffer();
  for (int i = 0; i < parts[0].length; i++) {
    if (i > 0 && (parts[0].length - i) % 3 == 0) buf.write(',');
    buf.write(parts[0][i]);
  }
  return '$buf.${parts[1]}';
}
