// ============================================================
// VIEW — Settings hub + Organization (ports MobileSettings)
// settingsHub · setCompany · setFinancial · setTaxes
// setCurrencies · setNumbering · setBranches
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';
import '../../../../core/bloc/form_cubit.dart';

import '../widgets/widgets.dart';
export '../widgets/widgets.dart';
part 'settings_hub_screen.dart';
part 'company_profile_screen.dart';
part 'financial_settings_screen.dart';
part 'taxes_settings_screen.dart';
part 'currencies_settings_screen.dart';
part 'numbering_screen.dart';
part 'branches_stores_screen.dart';

class _NavItem {
  final String id, label, icon, desc;
  const _NavItem(this.id, this.label, this.icon, this.desc);
}

final _settingsNav = [
  ('Organization', [
    _NavItem('setCompany', 'Company Profile', 'building', 'Legal name, logo, address, tax IDs'),
    _NavItem('setFinancial', 'Financial', 'globe', 'Base currency, fiscal year'),
    _NavItem('setTaxes', 'Taxes', 'percent', 'VAT / GST rules'),
    _NavItem('setCurrencies', 'Currencies', 'swap', 'Exchange rates'),
    _NavItem('setNumbering', 'Numbering', 'doc', 'Document prefixes'),
    _NavItem('setBranches', 'Branches & Stores', 'store', 'Locations & warehouses'),
  ]),
  ('Workspace', [_NavItem('tenants', 'Workspaces', 'switch2', 'Switch or manage organizations')]),
  ('Team & Security', [
    _NavItem('usersList', 'Users', 'user', 'Members & invites'),
    _NavItem('rolesList', 'Roles & Permissions', 'settings', 'Access per module'),
    _NavItem('auditLog', 'Audit Log', 'lock', 'Activity trail'),
  ]),
  ('Platform', [
    _NavItem('setIntegrations', 'Integrations', 'plug', 'Banking, e-commerce, email'),
    _NavItem('setWebhooks', 'Webhooks', 'link', 'Event subscriptions'),
    _NavItem('setApiKeys', 'API Keys', 'key', 'Access tokens'),
    _NavItem('setNotifications', 'Notifications', 'bell2', 'Email & in-app alerts'),
    _NavItem('setBilling', 'Billing & Plan', 'card', 'Subscription'),
    _NavItem('setBackup', 'Backup & Export', 'database', 'Export & snapshots'),
  ]),
];
