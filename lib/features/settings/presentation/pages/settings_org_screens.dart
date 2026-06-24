// ============================================================
// VIEW — Settings hub + Organization (ports MobileSettings)
// settingsHub · setCompany · setFinancial · setTaxes
// setCurrencies · setNumbering · setBranches
// ============================================================

import 'package:flutter/material.dart';
import 'package:gl_mobile_app/design_system/adapters/inventory/m_inv_kit.dart';
import '../../../../design_system/kit.dart';
import '../../../../workspace/presentation/controllers/nav_controller.dart';

class _NavItem {
  final String id, label, icon, desc;
  const _NavItem(this.id, this.label, this.icon, this.desc);
}

const _settingsNav = [
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

class SettingsHubScreen extends StatelessWidget {
  final NavController nav;
  const SettingsHubScreen({super.key, required this.nav});
  @override
  Widget build(BuildContext context) {
    return MScroll([
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        child: Row(children: [
          Container(width: 40, height: 40, alignment: Alignment.center, decoration: BoxDecoration(color: tint(M.blue, 0x1F), borderRadius: BorderRadius.circular(10)), child: Icon(MIcons.of('building'), size: 20, color: M.blue)),
          const SizedBox(width: 12),
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Al-Rashid Trading Co.', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: M.fg1, fontFamily: M.body)),
            Text('Tenant 9 · GeniusLink ERP', style: TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)),
          ]),
        ]),
      ),
      for (final g in _settingsNav)
        MCard(title: g.$1, marker: M.blue, pad: 8, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(children: [
              for (int i = 0; i < g.$2.length; i++)
                GestureDetector(
                  onTap: () => nav.go(g.$2[i].id),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(border: i < g.$2.length - 1 ? const Border(bottom: BorderSide(color: M.border)) : null),
                    child: Row(children: [
                      Container(width: 34, height: 34, alignment: Alignment.center, decoration: BoxDecoration(color: M.input, borderRadius: BorderRadius.circular(8)), child: Icon(MIcons.of(g.$2[i].icon), size: 16, color: M.fg2)),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(g.$2[i].label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
                        const SizedBox(height: 1),
                        Text(g.$2[i].desc, style: const TextStyle(fontSize: 11.5, color: M.fg3, fontFamily: M.body)),
                      ])),
                      Icon(MIcons.of('chevR'), size: 16, color: M.fg4),
                    ]),
                  ),
                ),
            ]),
          ),
        ]),
    ]);
  }
}

class CompanyProfileScreen extends StatelessWidget {
  const CompanyProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MScroll([
      ISection(icon: 'building', title: 'Identity', sub: 'Names shown on documents', marker: M.blue, children: [
        Row(children: [
          Container(width: 64, height: 64, alignment: Alignment.center, decoration: BoxDecoration(color: M.input, border: Border.all(color: M.borderStrong), borderRadius: BorderRadius.circular(12)), child: Icon(MIcons.of('building'), size: 26, color: M.fg3)),
          const SizedBox(width: 14),
          const MBtn('Upload Logo', variant: MBtnVariant.secondary, icon: 'download'),
        ]),
        const TInput(label: 'Legal Name (English)', defaultValue: 'Al-Rashid Trading Co.', required: true),
        const TInput(label: 'الاسم القانوني', defaultValue: 'شركة الراشد التجارية', ar: true, required: true),
        const TInput(label: 'Trade Name', defaultValue: 'GeniusLink'),
        const TInput(label: 'Commercial Registration', defaultValue: '1010234567', mono: true),
      ]),
      const ISection(icon: 'pin', title: 'Registered Address', marker: M.green, children: [
        TSelect(label: 'Country', value: 'Saudi Arabia', options: ['Saudi Arabia', 'United Arab Emirates', 'Kuwait', 'Qatar']),
        TInput(label: 'City', defaultValue: 'Riyadh'),
        TInput(label: 'Street Address', defaultValue: 'King Fahd Rd, Olaya'),
        TInput(label: 'Postal Code', defaultValue: '12211', mono: true),
      ]),
      const ISection(icon: 'percent', title: 'Tax Registration', marker: M.orange, children: [
        TInput(label: 'VAT Number', defaultValue: '300123456700003', mono: true, required: true),
        TInput(label: 'Tax Identification No.', defaultValue: '9100234567', mono: true),
        TSelect(label: 'Tax Authority', value: 'ZATCA (Saudi Arabia)', options: ['ZATCA (Saudi Arabia)', 'FTA (UAE)', 'GAZT']),
      ]),
      const MBtn('Save Changes', icon: 'check', full: true),
    ]);
  }
}

class FinancialSettingsScreen extends StatefulWidget {
  const FinancialSettingsScreen({super.key});
  @override
  State<FinancialSettingsScreen> createState() => _FinancialSettingsScreenState();
}

class _FinancialSettingsScreenState extends State<FinancialSettingsScreen> {
  String _basis = 'accrual';
  @override
  Widget build(BuildContext context) {
    return MScroll([
      ISection(icon: 'globe', title: 'Currency & Calendar', marker: M.blue, children: [
        const TSelect(label: 'Base Currency', value: 'SAR — Saudi Riyal', options: ['SAR — Saudi Riyal', 'USD — US Dollar', 'AED — UAE Dirham']),
        const TSelect(label: 'Fiscal Year Start', value: 'January', options: ['January', 'April', 'July', 'October']),
        const TSelect(label: 'Rounding Precision', value: '2 decimals', options: ['0 decimals', '2 decimals', '3 decimals']),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(padding: EdgeInsets.only(bottom: 7), child: Eyebrow('Accounting Basis')),
          Row(children: [
            for (final e in const [('accrual', 'Accrual'), ('cash', 'Cash')]) ...[
              if (e.$1 == 'cash') const SizedBox(width: 8),
              Expanded(child: GestureDetector(
                onTap: () => setState(() => _basis = e.$1),
                child: Container(
                  padding: const EdgeInsets.all(12), alignment: Alignment.center,
                  decoration: BoxDecoration(color: _basis == e.$1 ? tint(M.blue, 0x1F) : M.input, border: Border.all(color: _basis == e.$1 ? M.blue : M.border), borderRadius: BorderRadius.circular(8)),
                  child: Text(e.$2.toUpperCase(), style: TextStyle(color: _basis == e.$1 ? M.blue : M.fg2, fontWeight: FontWeight.w700, fontSize: 12, letterSpacing: 0.4, fontFamily: M.body)),
                ),
              )),
            ],
          ]),
        ]),
      ]),
      const ISection(icon: 'ledger', title: 'Default Posting Accounts', marker: M.green, children: [
        TSelect(label: 'Retained Earnings', value: '3100 — Retained Earnings', options: ['3100 — Retained Earnings', '3001 — Owner Capital']),
        TSelect(label: 'Default Tax Account', value: '2200 — VAT Payable', options: ['2200 — VAT Payable', '1350 — VAT Receivable']),
      ]),
      const ISection(icon: 'lock', title: 'Posting Rules', marker: M.orange, children: [
        TSwitch(label: 'Lock postings to open periods only', defaultOn: true),
        TSwitch(label: 'Auto-update FX rates daily', defaultOn: true),
      ]),
      const MBtn('Save Changes', icon: 'check', full: true),
    ]);
  }
}

class TaxesSettingsScreen extends StatefulWidget {
  const TaxesSettingsScreen({super.key});
  @override
  State<TaxesSettingsScreen> createState() => _TaxesSettingsScreenState();
}

class _TaxesSettingsScreenState extends State<TaxesSettingsScreen> {
  final _rules = [
    ['Standard VAT', '15', 'VAT', 'Sales & Purchases', true],
    ['Zero-Rated', '0', 'VAT', 'Exports', true],
    ['Exempt', '0', 'VAT', 'Financial services', true],
    ['Withholding — Services', '5', 'WHT', 'Non-resident', false],
  ];
  @override
  Widget build(BuildContext context) {
    final active = _rules.where((r) => r[4] as bool).length;
    return MScroll([
      MCard(marker: M.green, title: 'Tax Rules', sub: '$active active · applied at line level', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < _rules.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i < _rules.length - 1 ? const Border(bottom: BorderSide(color: M.border)) : null),
                child: Row(children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Text(_rules[i][0] as String, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
                      const SizedBox(width: 8),
                      Pill(_rules[i][2] as String, tone: _rules[i][2] == 'VAT' ? PillTone.info : PillTone.warning),
                    ]),
                    const SizedBox(height: 3),
                    Text(_rules[i][3] as String, style: const TextStyle(fontSize: 11.5, color: M.fg3, fontFamily: M.body)),
                  ])),
                  Text('${_rules[i][1]}%', style: const TextStyle(fontFamily: M.mono, fontSize: 15, fontWeight: FontWeight.w700, color: M.fg1)),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => setState(() => _rules[i][4] = !(_rules[i][4] as bool)),
                    child: Container(
                      width: 42, height: 24,
                      decoration: BoxDecoration(color: _rules[i][4] as bool ? M.blue : M.input, border: Border.all(color: _rules[i][4] as bool ? M.blue : M.borderStrong), borderRadius: BorderRadius.circular(999)),
                      child: AnimatedAlign(duration: const Duration(milliseconds: 150), alignment: _rules[i][4] as bool ? Alignment.centerRight : Alignment.centerLeft, child: Container(width: 18, height: 18, margin: const EdgeInsets.symmetric(horizontal: 2), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle))),
                    ),
                  ),
                ]),
              ),
          ]),
        ),
      ]),
      MBtn('Add Tax Rule', variant: MBtnVariant.secondary, icon: 'plus', full: true, onTap: () => setState(() => _rules.add(['New Rule', '0', 'VAT', '—', false]))),
      const MBtn('Save Changes', icon: 'check', full: true),
    ]);
  }
}

class CurrenciesSettingsScreen extends StatelessWidget {
  const CurrenciesSettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const pairs = [('USD', 'US Dollar', '3.750200', true), ('EUR', 'Euro', '4.082100', true), ('GBP', 'British Pound', '4.761000', true), ('AED', 'UAE Dirham', '1.020800', false), ('KWD', 'Kuwaiti Dinar', '12.18000', false)];
    return MScroll([
      MCard(marker: M.blue, title: 'Base Currency', children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            const Text('SAR', style: TextStyle(fontFamily: M.mono, fontWeight: FontWeight.w700, fontSize: 15, color: M.fg1)),
            Container(margin: const EdgeInsets.only(left: 7), padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2), decoration: BoxDecoration(color: tint(M.blue, 0x24), borderRadius: BorderRadius.circular(4)), child: const Text('BASE', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w700, letterSpacing: 0.6, color: M.blue, fontFamily: M.body))),
          ]),
          const Text('Eff. Dec 18, 2025', style: TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)),
        ]),
        const MBtn('Pull ECB Feed', variant: MBtnVariant.secondary, icon: 'refresh', full: true),
      ]),
      MCard(marker: M.green, title: 'Rates per 1 SAR', sub: 'Auto pairs sync daily; manual editable', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < pairs.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i < pairs.length - 1 ? const Border(bottom: BorderSide(color: M.border)) : null),
                child: Row(children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Text(pairs[i].$1, style: const TextStyle(fontFamily: M.mono, fontSize: 13, fontWeight: FontWeight.w700, color: M.fg1)),
                      const SizedBox(width: 7),
                      Pill(pairs[i].$4 ? 'Auto' : 'Manual', tone: pairs[i].$4 ? PillTone.info : PillTone.neutral),
                    ]),
                    const SizedBox(height: 2),
                    Text(pairs[i].$2, style: const TextStyle(fontSize: 11.5, color: M.fg3, fontFamily: M.body)),
                  ])),
                  Container(
                    padding: pairs[i].$4 ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: pairs[i].$4 ? null : BoxDecoration(color: M.input, border: Border.all(color: M.borderStrong), borderRadius: BorderRadius.circular(6)),
                    child: Text(pairs[i].$3, style: const TextStyle(fontFamily: M.mono, fontSize: 14, fontWeight: FontWeight.w600, color: M.fg1)),
                  ),
                ]),
              ),
          ]),
        ),
      ]),
      const MBtn('Save Rates', icon: 'check', full: true),
    ]);
  }
}

class NumberingScreen extends StatelessWidget {
  const NumberingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const seqs = [('Sales Invoice', 'INV', '0412'), ('Journal Voucher', 'JV', '0227'), ('Deposit', 'DEP', '0183'), ('Purchase Order', 'PO', '0212'), ('Inventory Transfer', 'INV-TRF', '0118')];
    return MScroll([
      MCard(marker: M.blue, title: 'Document Sequences', sub: 'Format: PREFIX-YEAR-NUMBER', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < seqs.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i < seqs.length - 1 ? const Border(bottom: BorderSide(color: M.border)) : null),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(seqs[i].$1, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
                    Text('${seqs[i].$2}-2024-${seqs[i].$3}', style: const TextStyle(fontFamily: M.mono, fontSize: 12.5, fontWeight: FontWeight.w600, color: M.blue)),
                  ]),
                  const SizedBox(height: 8),
                  Row(children: [
                    Expanded(child: TInput(defaultValue: seqs[i].$2, mono: true)),
                    const SizedBox(width: 10),
                    Container(width: 90, height: 46, alignment: Alignment.center, decoration: BoxDecoration(color: M.input, border: Border.all(color: M.border), borderRadius: BorderRadius.circular(8)), child: Text('Next ${seqs[i].$3}', style: const TextStyle(fontFamily: M.mono, fontSize: 12, color: M.fg3))),
                  ]),
                ]),
              ),
          ]),
        ),
      ]),
      const MBtn('Save Changes', icon: 'check', full: true),
    ]);
  }
}

class BranchesStoresScreen extends StatelessWidget {
  const BranchesStoresScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const rows = [('ST-001', 'Downtown Central', 'وسط المدينة', 'Riyadh', 'Store', 'active'), ('ST-002', 'King Fahd Warehouse', 'مستودع الملك فهد', 'Riyadh', 'Warehouse', 'active'), ('ST-003', 'Jeddah Showroom', 'صالة عرض جدة', 'Jeddah', 'Store', 'active'), ('BR-010', 'Dammam Branch', 'فرع الدمام', 'Dammam', 'Branch', 'inactive')];
    return MScroll([
      MCard(pad: 8, children: [
        for (int i = 0; i < rows.length; i++)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
            decoration: BoxDecoration(border: i < rows.length - 1 ? const Border(bottom: BorderSide(color: M.border)) : null),
            child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(rows[i].$2, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
                Directionality(textDirection: TextDirection.rtl, child: Text(rows[i].$3, style: const TextStyle(fontFamily: M.arabic, fontSize: 12, color: M.fg3))),
                const SizedBox(height: 3),
                Row(children: [
                  Text(rows[i].$1, style: const TextStyle(fontFamily: M.mono, fontSize: 10.5, color: M.fg3)),
                  const Text('  ·  ', style: TextStyle(color: M.fg4, fontSize: 10.5)),
                  Text(rows[i].$4, style: const TextStyle(fontSize: 10.5, color: M.fg3, fontFamily: M.body)),
                ]),
              ])),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Pill(rows[i].$5, tone: rows[i].$5 == 'Warehouse' ? PillTone.info : (rows[i].$5 == 'Branch' ? PillTone.warning : PillTone.neutral)),
                const SizedBox(height: 5),
                Pill(rows[i].$6, tone: rows[i].$6 == 'active' ? PillTone.success : PillTone.neutral),
              ]),
            ]),
          ),
      ]),
      const MBtn('Add Branch', icon: 'plus', full: true),
    ]);
  }
}
