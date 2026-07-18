import 'package:equatable/equatable.dart';

enum ContactType { customer, supplier }
enum ContactStatus { active, pending, inactive }

class ContactSummary extends Equatable {
  final String code;
  final String name;
  final String arabicName;
  final String city;
  final double balance;
  final int orderCount;
  final ContactStatus status;

  const ContactSummary({
    required this.code,
    required this.name,
    required this.arabicName,
    required this.city,
    required this.balance,
    required this.orderCount,
    required this.status,
  });

  @override
  List<Object?> get props => [code, name, arabicName, city, balance, orderCount, status];
}

class ContactTransaction extends Equatable {
  final String reference;
  final String description;
  final double amount;
  final DateTime occurredAt;

  const ContactTransaction({
    required this.reference,
    required this.description,
    required this.amount,
    required this.occurredAt,
  });

  @override
  List<Object?> get props => [reference, description, amount, occurredAt];
}

class ContactKind extends Equatable {
  final ContactType type;
  final String controlAccount;
  final List<ContactSummary> contacts;
  final List<ContactTransaction> history;

  const ContactKind({
    required this.type,
    required this.controlAccount,
    this.contacts = const [],
    this.history = const [],
  });

  bool get isSupplier => type == ContactType.supplier;

  @override
  List<Object?> get props => [type, controlAccount, contacts, history];
}
