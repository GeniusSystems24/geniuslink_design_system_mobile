// ============================================================
// VIEW — Currencies & Configuration (ports MobileCurrencies)
// currenciesList · createCurrency · currencyDetail
// exchangeRateSetup · fiscalYearSetup
// ============================================================

import 'package:flutter/material.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';

import '../widgets/widgets.dart';
export '../widgets/widgets.dart';
part 'currencies_list_screen.dart';
part 'create_currency_screen.dart';
part 'currency_detail_screen.dart';
part 'exchange_rate_setup_screen.dart';
part 'fiscal_year_setup_screen.dart';

final _currencies = [
  ('SAR', 'Saudi Riyal', '﷼', '1.000000', true, 'active'),
  ('USD', 'US Dollar', '\$', '3.750200', false, 'active'),
  ('EUR', 'Euro', '€', '4.082100', false, 'active'),
  ('GBP', 'British Pound', '£', '4.761000', false, 'active'),
  ('AED', 'UAE Dirham', 'د.إ', '1.020800', false, 'active'),
  ('KWD', 'Kuwaiti Dinar', 'د.ك', '12.18000', false, 'inactive'),
];
