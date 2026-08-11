import 'package:equatable/equatable.dart';

enum AccountType { asset, liability, equity, income, expense }

/// Core chart-of-accounts entity. It has no Flutter or presentation dependency.
class Account extends Equatable {
  final String code;
  final String name;
  final AccountType type;
  final double balance;
  final String? localizedName;

  const Account({
    required this.code,
    required this.name,
    required this.type,
    this.balance = 0,
    this.localizedName,
  });

  @override
  List<Object?> get props => [code, name, type, balance, localizedName];
}

/// Domain tree node used to model the chart without depending on a UI tree kit.
class AccountNode extends Equatable {
  final Account account;
  final List<AccountNode> children;

  const AccountNode({required this.account, this.children = const []});

  bool get isLeaf => children.isEmpty;

  double get totalBalance => isLeaf
      ? account.balance
      : children.fold<double>(0, (sum, child) => sum + child.totalBalance);

  @override
  List<Object?> get props => [account, children];
}
