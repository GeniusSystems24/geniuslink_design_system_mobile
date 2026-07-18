// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../design_system/kit.dart';
import '../../../../core/bloc/form_cubit.dart';

import 'platform_toggle.dart';

class BackupView extends StatelessWidget {
  const BackupView({super.key});
  @override
  Widget build(BuildContext context) {
    final form = context.read<FormCubit>();
    return BlocBuilder<FormCubit, FormData>(
      builder: (context, fstate) {
        final auto = fstate.value<bool>('auto') ?? true;
        final scope = Map<String, bool>.from(fstate.value<Map>('scope') ?? const {});
        void toggleScope(String k) => form.setField('scope', {...scope, k: !(scope[k] ?? false)});
        return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Backup'),
      body: MScroll([
          MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Automatic Backups', trailing: const Pill('Healthy'), children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Daily encrypted snapshot', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                const SizedBox(height: 3),
                Text('Last · Dec 19 03:00 · 248 MB', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
              ])),
              PlatformToggle(on: auto, onTap: () => form.setField('auto', !auto)),
            ]),
          ]),
          ISection(icon: 'download', title: 'Manual Export', sub: 'Download a portable copy', marker: SuperMaterialThemeData.of(context).colorScheme.primary, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(padding: EdgeInsets.only(bottom: 7), child: Eyebrow('Data Scope')),
              GridView.count(
                crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 4.4,
                children: [
                  for (final k in scope.keys)
                    GestureDetector(
                      onTap: () => toggleScope(k),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                        decoration: BoxDecoration(color: scope[k]! ? superCoreTint(SuperMaterialThemeData.of(context).colorScheme.primary, 0x1F) : SuperMaterialThemeData.of(context).superTheme.inputBg, border: Border.all(color: scope[k]! ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(8)),
                        child: Row(children: [
                          Container(width: 18, height: 18, alignment: Alignment.center, decoration: BoxDecoration(color: scope[k]! ? SuperMaterialThemeData.of(context).colorScheme.primary : Colors.transparent, border: Border.all(color: scope[k]! ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.borderStrong), borderRadius: BorderRadius.circular(4)), child: scope[k]! ? const Icon(Icons.check_rounded, size: 12, color: Colors.white) : null),
                          const SizedBox(width: 9),
                          Text(k, style: TextStyle(fontSize: 13, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                        ]),
                      ),
                    ),
                ],
              ),
            ]),
            const TSelect(label: 'Format', value: 'CSV (zipped)', options: ['CSV (zipped)', 'JSON', 'Excel (XLSX)']),
            const MBtn('Generate Export', icon: 'download', full: true),
          ]),
          MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.tertiary, title: 'Export History', pad: 8, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(children: [
                for (final f in const [('full-export-2025-12-15.zip', '248 MB · Dec 15'), ('ledger-q4-2025.csv', '12 MB · Dec 02'), ('contacts-2025-11.json', '1.1 MB · Nov 20')])
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
                    child: Row(children: [
                      Icon(MIcons.of('doc'), size: 16, color: SuperMaterialThemeData.of(context).colorScheme.primary),
                      const SizedBox(width: 10),
                      Expanded(child: Text(f.$1, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11.5, color: SuperMaterialThemeData.of(context).superTheme.fg1))),
                      Text(f.$2, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10.5, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                      const SizedBox(width: 10),
                      Icon(MIcons.of('download'), size: 15, color: SuperMaterialThemeData.of(context).superTheme.fg3),
                    ]),
                  ),
              ]),
            ),
          ]),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.error, 0x0F), border: Border.all(color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.error, 0x4D)), borderRadius: BorderRadius.circular(10)),
            child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Delete workspace', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                const SizedBox(height: 2),
                Text('30-day grace period.', style: TextStyle(fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
              ])),
              const MBtn('Delete', variant: MBtnVariant.danger, icon: 'trash'),
            ]),
          ),
        ]),
    );
      },
    );
  }
}
