// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../design_system/kit.dart';
import '../../../../core/bloc/form_cubit.dart';


const notificationCategories = [
  ('Postings & Ledger', 'Entries posted, reversed'),
  ('Approvals', 'Wires & adjustments'),
  ('Inventory', 'Low stock, transfers'),
  ('Security', 'Sign-ins, key changes'),
  ('Billing', 'Invoices & usage'),
];

const notificationChannels = ['Email', 'In-app', 'SMS'];

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});
  @override
  Widget build(BuildContext context) {
    final form = context.read<FormCubit>();
    return BlocBuilder<FormCubit, FormData>(
      builder: (context, fstate) {
        final prefs = [for (final r in (fstate.value<List>('prefs') ?? const [])) List<bool>.from(r as List)];
        void toggle(int ci, int chi) { final n = [for (final r in prefs) List<bool>.from(r)]; n[ci][chi] = !n[ci][chi]; form.setField('prefs', n); }
        return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Notifications'),
      body: MScroll([
          MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Preferences', subtitle: 'Toggle a channel per category', pad: 8, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
                  child: Row(children: [
                    const Spacer(),
                    for (final c in notificationChannels) SizedBox(width: 50, child: Center(child: Text(c.toUpperCase(), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 9, letterSpacing: 0.4, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)))),
                  ]),
                ),
                for (int ci = 0; ci < notificationCategories.length; ci++)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(border: ci < notificationCategories.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                    child: Row(children: [
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(notificationCategories[ci].$1, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                        const SizedBox(height: 1),
                        Text(notificationCategories[ci].$2, style: TextStyle(fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                      ])),
                      for (int chi = 0; chi < notificationChannels.length; chi++)
                        SizedBox(
                          width: 50,
                          child: Center(
                            child: GestureDetector(
                              onTap: () => toggle(ci, chi),
                              child: Container(
                                width: 26, height: 26, alignment: Alignment.center,
                                decoration: BoxDecoration(color: prefs[ci][chi] ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.inputBg, border: Border.all(color: prefs[ci][chi] ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.borderStrong), borderRadius: BorderRadius.circular(7)),
                                child: prefs[ci][chi] ? const Icon(Icons.check_rounded, size: 14, color: Colors.white) : null,
                              ),
                            ),
                          ),
                        ),
                    ]),
                  ),
              ]),
            ),
          ]),
          MBtn('Save Preferences', icon: 'check', full: true, onTap: form.submit),
        ]),
    );
      },
    );
  }
}
