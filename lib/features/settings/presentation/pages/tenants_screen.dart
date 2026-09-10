import 'dart:async' show unawaited;

import 'package:flutter/material.dart';

import '../../../../core/tenancy/tenant_connection.dart';
import '../../../../core/tenancy/tenant_session.dart';
import '../../../../design_system/kit.dart';
import '../../../../workspace/presentation/controllers/tenant_controller.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';

import 'package:gl_mobile_app/shared/presentation/widgets/feature_page_scaffold.dart';
part '../widgets/tenants_view.dart';
// componentized-by: dismantle_more_reports_settings_stores.py
/// Route/page boundary for the Tenants feature view.
///
/// The screen preserves the existing public navigation API and delegates UI
/// composition to its corresponding `*View` widget.
///
/// Example:
///
/// ```dart
/// TenantsScreen(
///   controller: controller,
/// )
/// ```
class TenantsScreen extends StatelessWidget {

  final TenantController? controller;

  const TenantsScreen({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return TenantsView(
        key: key,
        controller: controller,
      );
  }
}
