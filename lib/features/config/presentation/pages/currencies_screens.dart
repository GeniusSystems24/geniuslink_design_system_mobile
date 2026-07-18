// ============================================================
// VIEW — Currencies & Configuration (ports MobileCurrencies)
// currenciesList · createCurrency · currencyDetail
// exchangeRateSetup · fiscalYearSetup
// ============================================================

import 'package:flutter/material.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';

final _currencies = [
  ('SAR', 'Saudi Riyal', '﷼', '1.000000', true, 'active'),
  ('USD', 'US Dollar', '\$', '3.750200', false, 'active'),
  ('EUR', 'Euro', '€', '4.082100', false, 'active'),
  ('GBP', 'British Pound', '£', '4.761000', false, 'active'),
  ('AED', 'UAE Dirham', 'د.إ', '1.020800', false, 'active'),
  ('KWD', 'Kuwaiti Dinar', 'د.ك', '12.18000', false, 'inactive'),
];

class CurrenciesListScreen extends StatelessWidget {
  const CurrenciesListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, elevation: 0, title: const Text('Currencies')),
      body: MScroll([
      MCard(pad: 8, children: [
        for (int i = 0; i < _currencies.length; i++)
          GestureDetector(
            onTap: () => context.goTo('currencyDetail'),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
              decoration: BoxDecoration(border: i < _currencies.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
              child: Row(children: [
                Container(width: 40, height: 40, alignment: Alignment.center, decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.inputBg, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(10)), child: Text(_currencies[i].$3, style: TextStyle(fontSize: 18, color: SuperMaterialThemeData.of(context).superTheme.fg1))),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Text(_currencies[i].$1, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
                    if (_currencies[i].$5) Container(margin: const EdgeInsets.only(left: 7), padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2), decoration: BoxDecoration(color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.primary, 0x24), borderRadius: BorderRadius.circular(4)), child: Text('BASE', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w700, letterSpacing: 0.6, color: SuperMaterialThemeData.of(context).colorScheme.primary, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily))),
                  ]),
                  const SizedBox(height: 2),
                  Text(_currencies[i].$2, style: TextStyle(fontSize: 12.5, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                ])),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(_currencies[i].$4, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
                  const SizedBox(height: 4),
                  Pill(_currencies[i].$6, tone: _currencies[i].$6 == 'active' ? PillTone.success : PillTone.neutral),
                ]),
              ]),
            ),
          ),
      ]),
    ]),
    );
  }
}

class CreateCurrencyScreen extends StatelessWidget {
  const CreateCurrencyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, elevation: 0, title: const Text('Add Currency')),
      body: MScroll([
      ISection(icon: 'swap', title: 'Currency Definition', subtitle: 'ISO code, display names and symbol', accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, children: [
        IField(label: 'ISO Code', placeholder: 'e.g. USD', mono: true, required: true),
        IField(label: 'Symbol', placeholder: 'e.g. \$', required: true),
        IField(label: 'Name English', placeholder: 'e.g. US Dollar', required: true),
        IField(label: 'الاسم بالعربية', placeholder: 'مثال: دولار أمريكي', ar: true, required: true),
      ]),
      ISection(icon: 'ledger', title: 'Precision & Rate', subtitle: 'Decimal places and exchange rate against base', accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, children: [
        IField(label: 'Decimal Places', value: '2', select: true),
        IField(label: 'Exchange Rate (per 1 SAR)', placeholder: 'e.g. 3.750200', mono: true),
        IToggle(label: 'Set as base currency', on: false),
      ]),
      ActionRow(primary: 'Add Currency'),
    ]),
    );
  }
}

class CurrencyDetailScreen extends StatelessWidget {
  const CurrencyDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const history = [('Dec 18, 2025', '3.750200', 'System · ECB feed'), ('Dec 11, 2025', '3.751400', 'System · ECB feed'), ('Dec 04, 2025', '3.749800', 'Layla A. (manual)'), ('Nov 27, 2025', '3.752100', 'System · ECB feed')];
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, elevation: 0, title: const Text('Currency Detail')),
      body: MScroll([
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Current Rate', subtitle: 'Per 1 SAR · updated Dec 18, 2025', trailing: Pill('Active'), children: [
        Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Text('USD', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 14, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
          SizedBox(width: 10),
          Text('3.750200', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 34, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).superTheme.fg1, letterSpacing: -0.6)),
          SizedBox(width: 8),
          Text('▲ 0.03%', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).colorScheme.secondary)),
        ]),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Definition', children: [
        KV('ISO Code', 'USD', mono: true), KV('Symbol', '\$'),
        KV('Name English', 'US Dollar'), KV('Name Arabic', 'دولار أمريكي', ar: true),
        KV('Decimal Places', '2', mono: true), KV('Source', 'ECB Daily Feed'),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.tertiary, title: 'Rate History', subtitle: 'Last 4 updates', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < history.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i < history.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                child: Row(children: [
                  SizedBox(width: 92, child: Text(history[i].$1, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg2))),
                  Expanded(child: Text(history[i].$2, textAlign: TextAlign.right, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1))),
                  const SizedBox(width: 12),
                  SizedBox(width: 96, child: Text(history[i].$3, textAlign: TextAlign.right, style: TextStyle(fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily))),
                ]),
              ),
          ]),
        ),
      ]),
      MBtn('Back to List', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => context.goTo('currenciesList')),
    ]),
    );
  }
}

class ExchangeRateSetupScreen extends StatelessWidget {
  const ExchangeRateSetupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const pairs = [('USD', 'US Dollar', '3.750200', '3.751400', true), ('EUR', 'Euro', '4.082100', '4.079800', true), ('GBP', 'British Pound', '4.761000', '4.758200', true), ('AED', 'UAE Dirham', '1.020800', '1.020800', false), ('KWD', 'Kuwaiti Dinar', '12.18000', '12.17200', false)];
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, elevation: 0, title: const Text('Exchange Rates')),
      body: MScroll([
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Base Currency', children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            Text('SAR', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontWeight: FontWeight.w700, fontSize: 15, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
            Container(margin: const EdgeInsets.only(left: 7), padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2), decoration: BoxDecoration(color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.primary, 0x24), borderRadius: BorderRadius.circular(4)), child: Text('BASE', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w700, letterSpacing: 0.6, color: SuperMaterialThemeData.of(context).colorScheme.primary, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily))),
          ]),
          Text('Effective Dec 18, 2025', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
        ]),
        const MBtn('Pull ECB Feed', variant: MBtnVariant.secondary, icon: 'download', full: true),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Rates per 1 SAR', subtitle: 'Auto-fed pairs sync daily; manual pairs are editable', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < pairs.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i < pairs.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                child: Row(children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Text(pairs[i].$1, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
                      const SizedBox(width: 7),
                      Pill(pairs[i].$5 ? 'Auto' : 'Manual', tone: pairs[i].$5 ? PillTone.info : PillTone.neutral),
                    ]),
                    const SizedBox(height: 2),
                    Text(pairs[i].$2, style: TextStyle(fontSize: 11.5, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                  ])),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Container(
                      padding: pairs[i].$5 ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: pairs[i].$5 ? null : BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.inputBg, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.borderStrong), borderRadius: BorderRadius.circular(6)),
                      child: Text(pairs[i].$3, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 14, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
                    ),
                    const SizedBox(height: 3),
                    Text('prev ${pairs[i].$4}', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                  ]),
                ]),
              ),
          ]),
        ),
      ]),
      const ActionRow(primary: 'Save Rates'),
    ]),
    );
  }
}

class FiscalYearSetupScreen extends StatelessWidget {
  const FiscalYearSetupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, elevation: 0, title: const Text('Fiscal Year')),
      body: MScroll([
      ISection(icon: 'calendar', title: 'Year Definition', subtitle: 'Define the active fiscal year boundaries', accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, trailing: Pill('Open'), children: [
        IField(label: 'Fiscal Year', value: '2024', mono: true),
        IField(label: 'Start Date', value: '01/01/2024', mono: true),
        IField(label: 'End Date', value: '12/31/2024', mono: true),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Accounting Periods', subtitle: '12 monthly periods · lock to prevent back-dated postings', children: [
        GridView.count(
          crossAxisCount: 3, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1.7,
          children: [
            for (int i = 0; i < months.length; i++) _PeriodTile(month: months[i], state: i < 11 ? 'closed' : (i == 11 ? 'open' : 'future')),
          ],
        ),
      ]),
      const InfoNote('Closing a period locks all postings dated within it. A locked period can only be reopened by a controller with audit justification.'),
      const ActionRow(primary: 'Save Configuration'),
    ]),
    );
  }
}

class _PeriodTile extends StatelessWidget {
  final String month, state;
  const _PeriodTile({required this.month, required this.state});
  @override
  Widget build(BuildContext context) {
    final isOpen = state == 'open';
    final color = isOpen ? SuperMaterialThemeData.of(context).colorScheme.secondary : SuperMaterialThemeData.of(context).superTheme.fg3;
    return Opacity(
      opacity: state == 'future' ? 0.5 : 1,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: isOpen ? superCoreTint(SuperMaterialThemeData.of(context).colorScheme.secondary, 0x14) : SuperMaterialThemeData.of(context).superTheme.bg, border: Border.all(color: isOpen ? superCoreTint(SuperMaterialThemeData.of(context).colorScheme.secondary, 0x4D) : SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(month, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
            if (state != 'future') Icon(MIcons.of(isOpen ? 'check' : 'lock'), size: 13, color: color),
          ]),
          const SizedBox(height: 8),
          Text(state.toUpperCase(), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 8.5, letterSpacing: 0.6, color: color, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
        ]),
      ),
    );
  }
}
