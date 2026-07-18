// Reusable presentation widget extracted from the former multi-screen file.

import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';


class UserSessionBanner extends StatefulWidget {
  const UserSessionBanner({super.key});
  @override
  State<UserSessionBanner> createState() => _UserSessionBannerState();
}

class _UserSessionBannerState extends State<UserSessionBanner> {
  int _left = 90;
  bool _reauth = false, _dismissed = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_reauth || _dismissed) return;
      setState(() => _left = _left > 0 ? _left - 1 : 0);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_dismissed) return const SizedBox.shrink();
    final mm = (_left ~/ 60).toString().padLeft(2, '0');
    final ss = (_left % 60).toString().padLeft(2, '0');
    final urgent = _left <= 30;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: SuperMaterialThemeData.of(context).superTheme.surface,
        border: Border(left: BorderSide(color: urgent ? SuperMaterialThemeData.of(context).colorScheme.error : SuperMaterialThemeData.of(context).colorScheme.tertiary, width: 3), top: BorderSide(color: urgent ? SuperMaterialThemeData.of(context).colorScheme.error : SuperMaterialThemeData.of(context).superTheme.borderStrong), right: BorderSide(color: urgent ? SuperMaterialThemeData.of(context).colorScheme.error : SuperMaterialThemeData.of(context).superTheme.borderStrong), bottom: BorderSide(color: urgent ? SuperMaterialThemeData.of(context).colorScheme.error : SuperMaterialThemeData.of(context).superTheme.borderStrong)),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Color(0x80000000), blurRadius: 28, offset: Offset(0, 12))],
      ),
      child: !_reauth
          ? Row(children: [
              Icon(MIcons.of('clock'), size: 18, color: urgent ? SuperMaterialThemeData.of(context).colorScheme.error : SuperMaterialThemeData.of(context).colorScheme.tertiary),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text.rich(TextSpan(children: [
                  TextSpan(text: 'Session expires in ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                  TextSpan(text: '$mm:$ss', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, fontWeight: FontWeight.w600, color: urgent ? SuperMaterialThemeData.of(context).colorScheme.error : SuperMaterialThemeData.of(context).superTheme.fg1)),
                ])),
                const SizedBox(height: 1),
                Text('Re-authenticate to stay signed in', style: TextStyle(fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
              ])),
              GestureDetector(onTap: () => setState(() => _dismissed = true), child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Text('Dismiss', style: TextStyle(color: SuperMaterialThemeData.of(context).superTheme.fg3, fontSize: 12, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)))),
              MBtn('Renew', icon: 'lock', onTap: () => setState(() => _reauth = true)),
            ])
          : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Row(children: [
                Icon(MIcons.of('lock'), size: 16, color: SuperMaterialThemeData.of(context).colorScheme.primary),
                const SizedBox(width: 10),
                Text('Confirm your password', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
              ]),
              const SizedBox(height: 12),
              const TPassword(label: 'Password', placeholder: '••••••••••'),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: MBtn('Cancel', variant: MBtnVariant.secondary, full: true, onTap: () => setState(() => _reauth = false))),
                const SizedBox(width: 10),
                Expanded(child: MBtn('Confirm', icon: 'check', full: true, onTap: () => setState(() => _dismissed = true))),
              ]),
            ]),
    );
  }
}
