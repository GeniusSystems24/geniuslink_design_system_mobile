// ============================================================
// VIEW — Journal feature (ports MobileJournal)
// journalList · createJournalEntry · journalEntryDetail
// ============================================================

import 'package:flutter/material.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';

import '../widgets/widgets.dart';
export '../widgets/widgets.dart';
part 'journal_list_screen.dart';
part 'create_journal_entry_screen.dart';
part 'journal_entry_detail_screen.dart';

// Chart-of-accounts corpus for the journal-line account picker (MSuggest).
final _coa = <(String, String)>[
  ('1100', 'Bank · NCB Main'), ('1101', 'Bank · Al Rajhi'), ('1200', 'Accounts Receivable'),
  ('1300', 'Inventory'), ('1500', 'Fixed Assets'), ('2100', 'Accounts Payable'),
  ('2200', 'VAT Payable'), ('3001', 'Owner Capital'), ('3100', 'Retained Earnings'),
  ('4001', 'Sales Revenue'), ('5001', 'Cost of Goods Sold'), ('6001', 'Salaries Expense'),
  ('6100', 'Rent Expense'), ('6200', 'Bank Charges'), ('6300', 'Depreciation Expense'),
];

final _entries = [
  ('JV-2024-0226', 'Mixed sale & revenue recognition', '3,400.00', 'Posted', 'Dec 18'),
  ('JV-2024-0225', 'Depreciation — December', '1,250.00', 'Draft', 'Dec 18'),
  ('JV-2024-0224', 'Payroll accrual', '48,900.00', 'Posted', 'Dec 17'),
  ('JV-2024-0223', 'FX revaluation — USD', '2,140.00', 'Posted', 'Dec 16'),
  ('JV-2024-0222', 'Bank charges', '320.00', 'Posted', 'Dec 15'),
];
