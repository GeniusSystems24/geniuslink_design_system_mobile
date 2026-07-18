
import '../../domain/domain.dart';

abstract final class MockConfigDataSource {
  static final usdHistory = <CurrencyRate>[
    CurrencyRate(effectiveAt: DateTime(2025, 12, 18), rate: 3.7502, source: 'System · ECB feed'),
    CurrencyRate(effectiveAt: DateTime(2025, 12, 11), rate: 3.7514, source: 'System · ECB feed'),
    CurrencyRate(effectiveAt: DateTime(2025, 12, 4), rate: 3.7498, source: 'Layla A. (manual)'),
    CurrencyRate(effectiveAt: DateTime(2025, 11, 27), rate: 3.7521, source: 'System · ECB feed'),
  ];

  static final currencies = <CurrencyDefinition>[
    const CurrencyDefinition(code: 'SAR', name: 'Saudi Riyal', localizedName: 'ريال سعودي', symbol: '﷼', exchangeRate: 1, isBase: true),
    CurrencyDefinition(code: 'USD', name: 'US Dollar', localizedName: 'دولار أمريكي', symbol: r'$', exchangeRate: 3.7502, source: 'ECB Daily Feed', rateHistory: usdHistory),
    const CurrencyDefinition(code: 'EUR', name: 'Euro', symbol: '€', exchangeRate: 4.0821, source: 'ECB Daily Feed'),
    const CurrencyDefinition(code: 'GBP', name: 'British Pound', symbol: '£', exchangeRate: 4.761, source: 'ECB Daily Feed'),
    const CurrencyDefinition(code: 'AED', name: 'UAE Dirham', symbol: 'د.إ', exchangeRate: 1.0208),
    const CurrencyDefinition(code: 'KWD', name: 'Kuwaiti Dinar', symbol: 'د.ك', exchangeRate: 12.18, status: CurrencyStatus.inactive),
  ];
}
