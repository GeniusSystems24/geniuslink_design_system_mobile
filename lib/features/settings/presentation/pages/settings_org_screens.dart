// ============================================================
// VIEW — Settings hub + Organization (ports MobileSettings)
// settingsHub · setCompany · setFinancial · setTaxes
// setCurrencies · setNumbering · setBranches
// ============================================================

import 'package:flutter/material.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';
import '../models/models.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';

import 'package:gl_mobile_app/shared/presentation/widgets/feature_page_scaffold.dart';
export '../widgets/widgets.dart';
export 'financial_settings_screen.dart';
export 'taxes_settings_screen.dart';

part 'settings_hub_screen.dart';
part 'company_profile_screen.dart';
part 'currencies_settings_screen.dart';
part 'numbering_screen.dart';
part 'branches_stores_screen.dart';

part '../widgets/branches_stores_view.dart';
part '../widgets/company_profile_view.dart';
part '../widgets/currencies_settings_view.dart';
part '../widgets/numbering_view.dart';
part '../widgets/settings_hub_view.dart';
