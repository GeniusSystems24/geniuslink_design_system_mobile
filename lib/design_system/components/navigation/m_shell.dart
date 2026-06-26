// ============================================================
// GeniusLink Mobile — Shell chrome (MAppBar · MTabBar)
// File placement:  lib/design_system/components/navigation/m_shell.dart
// ============================================================

import 'package:flutter/material.dart';
import '../../tokens/m_colors.dart';
import '../layout/m_icons.dart';

class MAppBar extends StatelessWidget {
  final String title;
  final String? ar;
  final VoidCallback? onBack;
  final Widget? action;
  const MAppBar({super.key, required this.title, this.ar, this.onBack, this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 14, 16, 12),
      decoration: const BoxDecoration(color: Color(0xEB111318), border: Border(bottom: BorderSide(color: M.border))),
      child: Row(children: [
        if (onBack != null)
          GestureDetector(onTap: onBack, behavior: HitTestBehavior.opaque, child: const Padding(padding: EdgeInsetsDirectional.only(end: 12), child: Icon(Icons.arrow_back_rounded, size: 22, color: M.blue))),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: M.display, fontWeight: FontWeight.w700, fontSize: 19, letterSpacing: -0.4, color: M.fg1)),
          if (ar != null)
            Directionality(textDirection: TextDirection.rtl, child: Text(ar!, style: TextStyle(fontFamily: M.arabic, fontSize: 12, color: M.blue.withOpacity(0.85)))),
        ])),
        if (action != null) action!,
      ]),
    );
  }
}

class MTabBar extends StatelessWidget {
  final String active;
  final ValueChanged<String> onChange;
  const MTabBar({super.key, required this.active, required this.onChange});

  static const _tabs = [
    ('dashboard', 'Home', 'home'),
    ('accounts', 'Accounts', 'ledger'),
    ('stores', 'Stores', 'store'),
    ('more', 'More', 'grid'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xE6111318), border: Border(top: BorderSide(color: M.border))),
      padding: EdgeInsets.only(top: 8, bottom: 8 + MediaQuery.of(context).padding.bottom),
      child: Row(children: [
        for (final (id, label, icon) in _tabs)
          Expanded(child: GestureDetector(
            onTap: () => onChange(id),
            behavior: HitTestBehavior.opaque,
            child: Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(MIcons.of(icon), size: 22, color: active == id ? M.blue : M.fg3),
              const SizedBox(height: 4),
              Text(label, style: TextStyle(fontFamily: M.body, fontSize: 10, fontWeight: active == id ? FontWeight.w700 : FontWeight.w500, color: active == id ? M.blue : M.fg3)),
            ])),
          )),
      ]),
    );
  }
}
