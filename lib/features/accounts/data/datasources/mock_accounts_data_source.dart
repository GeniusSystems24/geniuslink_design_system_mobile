import '../../domain/domain.dart';

/// Demo-only data source used by the application composition root.
abstract final class MockAccountsDataSource {

  static const list = <Account>[
    Account(code: '1001', name: 'Cash Box', localizedName: 'الصندوق', type: AccountType.asset, balance: 42500),
    Account(code: '1100', name: 'Bank · NCB Main', localizedName: 'البنك الأهلي', type: AccountType.asset, balance: 186420),
    Account(code: '1200', name: 'Inventory (WIP)', localizedName: 'مخزون', type: AccountType.asset, balance: 54890),
    Account(code: '2001', name: 'Accounts Payable', localizedName: 'الموردون', type: AccountType.liability, balance: -23140),
    Account(code: '4001', name: 'Sales Revenue', localizedName: 'المبيعات', type: AccountType.income, balance: -89200),
  ];

  static const chart = <AccountNode>[
    AccountNode(
      account: Account(code: '1000', name: 'Assets', type: AccountType.asset),
      children: [
        AccountNode(
          account: Account(code: '1001', name: 'Current Assets', type: AccountType.asset),
          children: [
            AccountNode(account: Account(code: '1010', name: 'Cash Box', type: AccountType.asset, balance: 42500)),
            AccountNode(account: Account(code: '1100', name: 'Bank · NCB Main', type: AccountType.asset, balance: 186420)),
            AccountNode(account: Account(code: '1200', name: 'Inventory (WIP)', type: AccountType.asset, balance: 54890)),
          ],
        ),
        AccountNode(
          account: Account(code: '1500', name: 'Fixed Assets', type: AccountType.asset),
          children: [
            AccountNode(account: Account(code: '1510', name: 'Equipment', type: AccountType.asset, balance: 98000)),
            AccountNode(account: Account(code: '1520', name: 'Vehicles', type: AccountType.asset, balance: 44000)),
          ],
        ),
      ],
    ),
    AccountNode(
      account: Account(code: '2000', name: 'Liabilities', type: AccountType.liability),
      children: [
        AccountNode(account: Account(code: '2001', name: 'Accounts Payable', type: AccountType.liability, balance: 23140)),
        AccountNode(account: Account(code: '2100', name: 'Long-Term Debt', type: AccountType.liability, balance: 80000)),
      ],
    ),
    AccountNode(
      account: Account(code: '3000', name: 'Equity', type: AccountType.equity),
      children: [
        AccountNode(account: Account(code: '3001', name: 'Owner Capital', type: AccountType.equity, balance: 260670)),
        AccountNode(account: Account(code: '3100', name: 'Retained Earnings', type: AccountType.equity, balance: 61980)),
      ],
    ),
  ];
}
