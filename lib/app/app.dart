// ============================================================
// GeniusLink Mobile — App root
// File placement:  lib/app/app.dart
// ============================================================

import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import '../workspace/presentation/pages/workspace_page.dart';

class GeniusLinkApp extends StatelessWidget {
  const GeniusLinkApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'GeniusLink',
    debugShowCheckedModeBanner: false,
    theme: buildMobileTheme(),
    home:  Scaffold(body: WorkspacePage()),
  );
}
