// ============================================================
// VIEW — Settings · Platform (ports MobileSettingsPlatform)
// setIntegrations · setWebhooks · setApiKeys
// setNotifications · setBilling · setBackup
// ============================================================

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../design_system/kit.dart';
import '../../../../core/bloc/form_cubit.dart';


import '../widgets/widgets.dart';
export '../widgets/widgets.dart';
part 'integrations_screen.dart';
part 'webhooks_screen.dart';
part 'api_keys_screen.dart';
part 'notifications_screen.dart';
part 'billing_screen.dart';
part 'backup_screen.dart';

List<(String, Color, List<(String, Color, String, bool)>)> _integrationGroups(BuildContext context) {
  final colors = SuperMaterialThemeData.of(context).colorScheme;
  return [
    ('Banking & Payments', colors.primary, [('SAMA Open Banking', colors.primary, 'Statement sync', true), ('Mada Gateway', colors.secondary, 'Local card acquiring', true), ('Stripe', const Color(0xFF635BFF), 'International cards', false)]),
    ('E-commerce', colors.secondary, [('Salla', colors.secondary, 'Orders & inventory', true), ('Zid', colors.tertiary, 'Order import', false), ('Shopify', const Color(0xFF95BF47), 'Multi-channel', false)]),
    ('Email & Comms', colors.tertiary, [('SendGrid', colors.primary, 'Document email', true), ('Slack', const Color(0xFFE01E5A), 'Alert notifications', false)]),
  ];
}
