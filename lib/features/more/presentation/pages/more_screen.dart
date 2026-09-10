// ============================================================
// VIEW — More menu with reusable navigation configuration.
// ============================================================

import 'package:flutter/material.dart';

import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';
import '../../../../localization/generated/l10n.dart';
import '../models/models.dart';

import 'package:gl_mobile_app/shared/presentation/widgets/feature_page_scaffold.dart';
part '../widgets/more_view.dart';
// componentized-by: dismantle_more_reports_settings_stores.py
/// Route/page boundary for the More feature view.
///
/// The screen preserves the existing public navigation API and delegates UI
/// composition to its corresponding `*View` widget.
///
/// Example:
///
/// ```dart
/// MoreScreen(
///   groups: groups,
/// )
/// ```
class MoreScreen extends StatelessWidget {

  final List<NavigationGroup>? groups;

  const MoreScreen({this.groups, super.key});

  @override
  Widget build(BuildContext context) {
    return MoreView(
        key: key,
        groups: groups,
      );
  }
}
