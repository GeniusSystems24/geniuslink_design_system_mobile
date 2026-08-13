// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';
import '../../../../shared/presentation/controllers/form_controller.dart';

class FinancialSettingsView extends StatelessWidget {
  final FormController controller;

  const FinancialSettingsView({required this.controller, super.key});
  @override
  Widget build(BuildContext context) {
    final form = controller;
    return ListenableBuilder(
      listenable: form,
      builder: (context, _) {
        final state = form.state;
        final basis = state.value<String>('basis') ?? 'accrual';
        var marker = SuperMaterialThemeData.of(context).colorScheme.primary;
        var icon = MIcons.of('globe');
        var marker2 = SuperMaterialThemeData.of(context).colorScheme.tertiary;
        var icon2 = MIcons.of('lock');
        var marker3 = SuperMaterialThemeData.of(context).colorScheme.secondary;
        var icon3 = MIcons.of('ledger');
        return Scaffold(
          backgroundColor: SuperMaterialThemeData.of(
            context,
          ).colorScheme.surface,
          appBar: SuperAppBar(title: const Text('Financial Settings')),
          body: MScroll([
            SuperSectionCard2(
              title: 'Currency & Calendar',

              initiallyExpanded: true,
              accentColor: marker,
              icon: icon,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TSelect(
                    label: 'Base Currency',
                    value: 'SAR — Saudi Riyal',
                    options: [
                      'SAR — Saudi Riyal',
                      'USD — US Dollar',
                      'AED — UAE Dirham',
                    ],
                  ),
                  const TSelect(
                    label: 'Fiscal Year Start',
                    value: 'January',
                    options: ['January', 'April', 'July', 'October'],
                  ),
                  const TSelect(
                    label: 'Rounding Precision',
                    value: '2 decimals',
                    options: ['0 decimals', '2 decimals', '3 decimals'],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 7),
                        child: Eyebrow('Accounting Basis'),
                      ),
                      Row(
                        children: [
                          for (final e in const [
                            ('accrual', 'Accrual'),
                            ('cash', 'Cash'),
                          ]) ...[
                            if (e.$1 == 'cash') const SizedBox(width: 8),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => form.setField('basis', e.$1),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: basis == e.$1
                                        ? superCoreTint(
                                            SuperMaterialThemeData.of(
                                              context,
                                            ).colorScheme.primary,
                                            0x1F,
                                          )
                                        : SuperMaterialThemeData.of(
                                            context,
                                          ).superTheme.inputBg,
                                    border: Border.all(
                                      color: basis == e.$1
                                          ? SuperMaterialThemeData.of(
                                              context,
                                            ).colorScheme.primary
                                          : SuperMaterialThemeData.of(
                                              context,
                                            ).superTheme.border,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    e.$2.toUpperCase(),
                                    style: TextStyle(
                                      color: basis == e.$1
                                          ? SuperMaterialThemeData.of(
                                              context,
                                            ).colorScheme.primary
                                          : SuperMaterialThemeData.of(
                                              context,
                                            ).superTheme.fg2,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      letterSpacing: 0.4,
                                      fontFamily: SuperMaterialThemeData.of(
                                        context,
                                      ).textTheme.bodyMedium?.fontFamily,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SuperSectionCard2(
              title: 'Default Posting Accounts',

              initiallyExpanded: true,
              accentColor: marker3,
              icon: icon3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  TSelect(
                    label: 'Retained Earnings',
                    value: '3100 — Retained Earnings',
                    options: [
                      '3100 — Retained Earnings',
                      '3001 — Owner Capital',
                    ],
                  ),
                  TSelect(
                    label: 'Default Tax Account',
                    value: '2200 — VAT Payable',
                    options: ['2200 — VAT Payable', '1350 — VAT Receivable'],
                  ),
                ],
              ),
            ),
            SuperSectionCard2(
              title: 'Posting Rules',

              initiallyExpanded: true,
              accentColor: marker2,
              icon: icon2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  TSwitch(
                    label: 'Lock postings to open periods only',
                    defaultOn: true,
                  ),
                  TSwitch(label: 'Auto-update FX rates daily', defaultOn: true),
                ],
              ),
            ),
            MBtn('Save Changes', icon: 'check', full: true, onTap: form.submit),
          ]),
        );
      },
    );
  }
}
