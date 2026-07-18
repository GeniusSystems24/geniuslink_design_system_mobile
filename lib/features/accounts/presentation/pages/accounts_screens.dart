// ============================================================
// VIEW — Accounts feature (ports MobileAccounts)
// list · createAccount · accountDetail · createGroup · groupDetail
// ============================================================

import 'package:flutter/material.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';

import '../widgets/widgets.dart';
export '../widgets/widgets.dart';
part 'accounts_screen.dart';

final _accounts = [
  ('1001', 'Cash Box', 'الصندوق', '42,500.00', false),
  ('1100', 'Bank · NCB Main', 'البنك الأهلي', '186,420.00', false),
  ('1200', 'Inventory (WIP)', 'مخزون', '54,890.00', false),
  ('2001', 'Accounts Payable', 'الموردون', '-23,140.00', true),
  ('4001', 'Sales Revenue', 'المبيعات', '-89,200.00', true),
];
