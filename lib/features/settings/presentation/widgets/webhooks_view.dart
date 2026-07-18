// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../design_system/kit.dart';
import '../../../../core/bloc/form_cubit.dart';

import 'platform_toggle.dart';

class WebhooksView extends StatelessWidget {
  const WebhooksView({super.key});
  @override
  Widget build(BuildContext context) {
    final form = context.read<FormCubit>();
    return BlocBuilder<FormCubit, FormData>(
      builder: (context, fstate) {
        final hooks = [for (final h in (fstate.value<List>('hooks') ?? const [])) List<Object>.from(h as List)];
        void toggle(int i) { final n = [for (final h in hooks) List<Object>.from(h)]; n[i][2] = !(n[i][2] as bool); form.setField('hooks', n); }
        return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Webhooks'),
      body: MScroll([
          MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: '${hooks.length} Endpoints', subtitle: 'HMAC-signed · retried 5× on failure', pad: 8, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(children: [
                for (int i = 0; i < hooks.length; i++)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(border: i < hooks.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                    child: Column(children: [
                      Row(children: [
                        Icon(MIcons.of('link'), size: 15, color: hooks[i][2] as bool ? SuperMaterialThemeData.of(context).colorScheme.secondary : SuperMaterialThemeData.of(context).superTheme.fg4),
                        const SizedBox(width: 10),
                        Expanded(child: Text(hooks[i][0] as String, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg1))),
                        PlatformToggle(on: hooks[i][2] as bool, onTap: () => toggle(i)),
                      ]),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Row(children: [
                          Expanded(child: Wrap(spacing: 6, runSpacing: 6, children: [
                            for (final e in (hooks[i][1] as String).split(','))
                              Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2), decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.inputBg, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(4)), child: Text(e, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10, color: SuperMaterialThemeData.of(context).superTheme.fg2))),
                          ])),
                          Text(hooks[i][3] as String, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10, color: (hooks[i][3] as String).startsWith('2') ? SuperMaterialThemeData.of(context).colorScheme.secondary : SuperMaterialThemeData.of(context).colorScheme.error)),
                        ]),
                      ),
                    ]),
                  ),
              ]),
            ),
          ]),
          const MBtn('Add Endpoint', icon: 'plus', full: true),
        ]),
    );
      },
    );
  }
}
