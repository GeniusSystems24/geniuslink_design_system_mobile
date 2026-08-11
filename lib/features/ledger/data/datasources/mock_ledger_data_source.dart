import '../../domain/domain.dart';

abstract final class MockLedgerDataSource {
  static const accounts = <LedgerAccount>[
    LedgerAccount(code: '1100', name: 'Bank · NCB Main', category: 'Assets'),
    LedgerAccount(code: '1101', name: 'Bank · Al Rajhi', category: 'Assets'),
    LedgerAccount(
      code: '1200',
      name: 'Accounts Receivable',
      category: 'Assets',
    ),
    LedgerAccount(code: '1300', name: 'Inventory', category: 'Assets'),
    LedgerAccount(code: '1500', name: 'Fixed Assets', category: 'Assets'),
    LedgerAccount(
      code: '2100',
      name: 'Accounts Payable',
      category: 'Liabilities',
    ),
    LedgerAccount(code: '2200', name: 'VAT Payable', category: 'Liabilities'),
    LedgerAccount(code: '3001', name: 'Owner Capital', category: 'Equity'),
    LedgerAccount(code: '3100', name: 'Retained Earnings', category: 'Equity'),
    LedgerAccount(code: '4001', name: 'Sales Revenue', category: 'Revenue'),
    LedgerAccount(
      code: '5001',
      name: 'Cost of Goods Sold',
      category: 'Expenses',
    ),
    LedgerAccount(code: '6001', name: 'Salaries Expense', category: 'Expenses'),
    LedgerAccount(code: '6100', name: 'Rent Expense', category: 'Expenses'),
    LedgerAccount(code: '6200', name: 'Bank Charges', category: 'Expenses'),
    LedgerAccount(
      code: '6300',
      name: 'Depreciation Expense',
      category: 'Expenses',
    ),
  ];

  static final entries = <JournalEntrySummary>[
    JournalEntrySummary(
      reference: 'JV-2024-0226',
      description: 'Mixed sale & revenue recognition',
      amount: 3400,
      status: JournalEntryStatus.posted,
      occurredAt: DateTime(2025, 12, 18),
      lines: const [
        JournalLine(
          account: LedgerAccount(
            code: '1100',
            name: 'Bank · NCB Main',
            category: 'Assets',
          ),
          side: JournalSide.debit,
          amount: 6600,
        ),
        JournalLine(
          account: LedgerAccount(
            code: '4001',
            name: 'Sales Revenue',
            category: 'Revenue',
          ),
          side: JournalSide.credit,
          amount: 6000,
        ),
        JournalLine(
          account: LedgerAccount(
            code: '2200',
            name: 'VAT Payable',
            category: 'Liabilities',
          ),
          side: JournalSide.credit,
          amount: 600,
        ),
      ],
    ),
    JournalEntrySummary(
      reference: 'JV-2024-0225',
      description: 'Depreciation — December',
      amount: 1250,
      status: JournalEntryStatus.draft,
      occurredAt: DateTime(2025, 12, 18),
    ),
    JournalEntrySummary(
      reference: 'JV-2024-0224',
      description: 'Payroll accrual',
      amount: 48900,
      status: JournalEntryStatus.posted,
      occurredAt: DateTime(2025, 12, 17),
    ),
    JournalEntrySummary(
      reference: 'JV-2024-0223',
      description: 'FX revaluation — USD',
      amount: 2140,
      status: JournalEntryStatus.posted,
      occurredAt: DateTime(2025, 12, 16),
    ),
    JournalEntrySummary(
      reference: 'JV-2024-0222',
      description: 'Bank charges',
      amount: 320,
      status: JournalEntryStatus.posted,
      occurredAt: DateTime(2025, 12, 15),
    ),
  ];
}
