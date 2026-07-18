// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../design_system/kit.dart';
import '../../../../core/bloc/form_cubit.dart';

import 'platform_toggle.dart';
import 'platform_mono_text.dart';

List<(String, Color, List<(String, Color, String, bool)>)> integrationGroups(
  BuildContext context,
) {
  final colors = SuperMaterialThemeData.of(context).colorScheme;
  return [
    ('Accounting', colors.primary, [('QuickBooks Online', colors.primary, 'Sync chart of accounts and journals', true), ('Xero', colors.secondary, 'Two-way accounting sync', false)]),
    ('Payments', colors.secondary, [('Stripe', colors.primary, 'Card payments and settlements', true), ('Moyasar', colors.secondary, 'Saudi payment gateway', false)]),
    ('Operations', colors.tertiary, [('Shopify', colors.tertiary, 'Orders and inventory sync', false), ('Slack', colors.primary, 'Operational notifications', true)]),
  ];
}

class IntegrationsView extends StatelessWidget {
  const IntegrationsView({super.key});
  @override
  Widget build(BuildContext context) {
    final form = context.read<FormCubit>();
    return BlocBuilder<FormCubit, FormData>(
      builder: (context, fstate) {
        final st = Map<String, bool>.from(fstate.value<Map>('state') ?? const {});
        final groups = integrationGroups(context);
        void toggle(String k) => form.setField('state', {...st, k: !(st[k] ?? false)});
        return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Integrations'),
      body: MScroll([
          for (final g in groups)
            MCard(title: g.$1, accentColor: g.$2, pad: 8, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(children: [
                  for (int i = 0; i < g.$3.length; i++)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(border: i < g.$3.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                      child: Row(children: [
                        PlatformMonoText(name: g.$3[i].$1, tone: g.$3[i].$2),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(g.$3[i].$1, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                          const SizedBox(height: 1),
                          Text(g.$3[i].$3, style: TextStyle(fontSize: 11.5, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                        ])),
                        if (st[g.$3[i].$1] == true) const Padding(padding: EdgeInsets.only(right: 8), child: Pill('On')),
                        PlatformToggle(on: st[g.$3[i].$1] ?? false, onTap: () => toggle(g.$3[i].$1)),
                      ]),
                    ),
                ]),
              ),
            ]),
        ]),
    );
      },
    );
  }
}
