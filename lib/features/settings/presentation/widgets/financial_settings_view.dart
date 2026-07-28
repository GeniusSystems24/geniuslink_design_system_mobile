// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gl_mobile_app/design_system/adapters/inventory/i_section.dart';
import '../../../../design_system/kit.dart';
import '../../../../core/bloc/form_cubit.dart';


class FinancialSettingsView extends StatelessWidget {
  const FinancialSettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    final form = context.read<FormCubit>();
    return BlocBuilder<FormCubit, FormData>(
      builder: (context, state) {
        final basis = state.value<String>('basis') ?? 'accrual';
        return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Financial Settings')),
      body: MScroll([
          ISection(icon: MIcons.of('globe'), title: 'Currency & Calendar', marker: SuperMaterialThemeData.of(context).colorScheme.primary, children: [
            const TSelect(label: 'Base Currency', value: 'SAR — Saudi Riyal', options: ['SAR — Saudi Riyal', 'USD — US Dollar', 'AED — UAE Dirham']),
            const TSelect(label: 'Fiscal Year Start', value: 'January', options: ['January', 'April', 'July', 'October']),
            const TSelect(label: 'Rounding Precision', value: '2 decimals', options: ['0 decimals', '2 decimals', '3 decimals']),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(padding: EdgeInsets.only(bottom: 7), child: Eyebrow('Accounting Basis')),
              Row(children: [
                for (final e in const [('accrual', 'Accrual'), ('cash', 'Cash')]) ...[
                  if (e.$1 == 'cash') const SizedBox(width: 8),
                  Expanded(child: GestureDetector(
                    onTap: () => form.setField('basis', e.$1),
                    child: Container(
                      padding: const EdgeInsets.all(12), alignment: Alignment.center,
                      decoration: BoxDecoration(color: basis == e.$1 ? superCoreTint(SuperMaterialThemeData.of(context).colorScheme.primary, 0x1F) : SuperMaterialThemeData.of(context).superTheme.inputBg, border: Border.all(color: basis == e.$1 ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(8)),
                      child: Text(e.$2.toUpperCase(), style: TextStyle(color: basis == e.$1 ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.fg2, fontWeight: FontWeight.w700, fontSize: 12, letterSpacing: 0.4, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                    ),
                  )),
                ],
              ]),
            ]),
          ]),
          ISection(icon: MIcons.of('ledger'), title: 'Default Posting Accounts', marker: SuperMaterialThemeData.of(context).colorScheme.secondary, children: const [
            TSelect(label: 'Retained Earnings', value: '3100 — Retained Earnings', options: ['3100 — Retained Earnings', '3001 — Owner Capital']),
            TSelect(label: 'Default Tax Account', value: '2200 — VAT Payable', options: ['2200 — VAT Payable', '1350 — VAT Receivable']),
          ]),
          ISection(icon: MIcons.of('lock'), title: 'Posting Rules', marker: SuperMaterialThemeData.of(context).colorScheme.tertiary, children: const [
            TSwitch(label: 'Lock postings to open periods only', defaultOn: true),
            TSwitch(label: 'Auto-update FX rates daily', defaultOn: true),
          ]),
          MBtn('Save Changes', icon: 'check', full: true, onTap: form.submit),
        ]),
    );
      },
    );
  }
}
