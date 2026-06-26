// ============================================================
// VIEW — Accounts feature (ports MobileAccounts)
// list · createAccount · accountDetail · createGroup · groupDetail
// ============================================================

import 'package:flutter/material.dart';
import 'package:gl_mobile_app/design_system/kit.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MScroll([
      MCard(marker: M.blue, title: 'Account Details', sub: 'Identify and place in the tree', children: [
        const MField(label: 'Account Code', placeholder: 'e.g. 1102', mono: true, required: true),
        const MField(label: 'Account Type', value: 'Asset'),
        const MField(label: 'Name English', placeholder: 'e.g. Bank · Al Rajhi', required: true),
        const MField(label: 'الاسم بالعربية', placeholder: 'مثال: بنك الراجحي', ar: true, required: true),
        MSuggest(
          label: 'Parent Group',
          value: 'Current Assets (1000)',
          placeholder: 'Search a parent group…',
          icon: 'briefcase',
          items: mSuggestions(const ['Current Assets (1000)', 'Fixed Assets (1500)', 'Liabilities (2000)', 'Equity (3000)']),
        ),
      ]),
      MCard(marker: M.green, title: 'Settings', children: [
        MSuggest(
          label: 'Currency',
          value: 'SAR — Saudi Riyal',
          placeholder: 'Search currency…',
          icon: 'globe',
          items: mSuggestions(const ['SAR — Saudi Riyal', 'USD — US Dollar', 'EUR — Euro']),
        ),
        const MField(label: 'Opening Balance', placeholder: '0.00', mono: true),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Eyebrow('Normal Balance'),
          const SizedBox(height: 7),
          Row(children: [
            Expanded(child: _toggleBox('Debit', true)),
            const SizedBox(width: 8),
            Expanded(child: _toggleBox('Credit', false)),
          ]),
        ]),
      ]),
      const Row(children: [
        Expanded(child: MBtn('Cancel', variant: MBtnVariant.secondary, full: true)),
        SizedBox(width: 10),
        Expanded(child: MBtn('Create', icon: 'check', full: true)),
      ]),
    ]);
  }

  static Widget _toggleBox(String label, bool on) => Container(
        padding: const EdgeInsets.all(12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: on ? tint(M.green, 0x14) : M.input,
          border: Border.all(color: on ? M.green : M.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(label.toUpperCase(),
            style: TextStyle(color: on ? M.green : M.fg2, fontWeight: FontWeight.w700, fontSize: 12, letterSpacing: 0.4, fontFamily: M.body)),
      );
}
