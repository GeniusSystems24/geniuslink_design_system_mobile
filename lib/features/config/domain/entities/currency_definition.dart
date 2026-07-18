
import 'package:equatable/equatable.dart';

enum CurrencyStatus { active, inactive }

class CurrencyRate extends Equatable {
  final DateTime effectiveAt;
  final double rate;
  final String source;

  const CurrencyRate({required this.effectiveAt, required this.rate, required this.source});

  @override
  List<Object?> get props => [effectiveAt, rate, source];
}

class CurrencyDefinition extends Equatable {
  final String code;
  final String name;
  final String? localizedName;
  final String symbol;
  final double exchangeRate;
  final bool isBase;
  final CurrencyStatus status;
  final int decimalPlaces;
  final String source;
  final List<CurrencyRate> rateHistory;

  const CurrencyDefinition({
    required this.code,
    required this.name,
    required this.symbol,
    required this.exchangeRate,
    this.localizedName,
    this.isBase = false,
    this.status = CurrencyStatus.active,
    this.decimalPlaces = 2,
    this.source = 'Manual',
    this.rateHistory = const [],
  });

  @override
  List<Object?> get props => [code, name, localizedName, symbol, exchangeRate, isBase, status, decimalPlaces, source, rateHistory];
}
