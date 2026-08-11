import 'package:equatable/equatable.dart';

enum JournalEntryStatus { posted, draft }

enum JournalSide { debit, credit }

class LedgerAccount extends Equatable {
  final String code;
  final String name;
  final String category;

  const LedgerAccount({
    required this.code,
    required this.name,
    required this.category,
  });

  @override
  List<Object?> get props => [code, name, category];
}

class JournalLine extends Equatable {
  final LedgerAccount account;
  final JournalSide side;
  final double amount;

  const JournalLine({
    required this.account,
    required this.side,
    required this.amount,
  });

  @override
  List<Object?> get props => [account, side, amount];
}

class JournalEntrySummary extends Equatable {
  final String reference;
  final String description;
  final double amount;
  final JournalEntryStatus status;
  final DateTime occurredAt;
  final List<JournalLine> lines;

  const JournalEntrySummary({
    required this.reference,
    required this.description,
    required this.amount,
    required this.status,
    required this.occurredAt,
    this.lines = const [],
  });

  @override
  List<Object?> get props => [
    reference,
    description,
    amount,
    status,
    occurredAt,
    lines,
  ];
}
