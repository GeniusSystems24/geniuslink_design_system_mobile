import 'package:flutter/material.dart';

import '../../../../shared/presentation/controllers/form_controller.dart';
import '../widgets/taxes_settings_view.dart';

/// Route/page boundary for the TaxesSettings feature view.
///
/// The screen preserves the existing public navigation API and delegates UI
/// composition to its corresponding `*View` widget.
///
/// Example:
///
/// ```dart
/// const TaxesSettingsScreen()
/// ```
class TaxesSettingsScreen extends StatefulWidget {
  const TaxesSettingsScreen({super.key});

  @override
  State<TaxesSettingsScreen> createState() => _TaxesSettingsScreenState();
}

class _TaxesSettingsScreenState extends State<TaxesSettingsScreen> {
  late final FormController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FormController(
      initial: const {
        'rules': [
          ['Standard VAT', '15', 'VAT', 'Sales & Purchases', true],
          ['Zero-Rated', '0', 'VAT', 'Exports', true],
          ['Exempt', '0', 'VAT', 'Financial services', true],
          ['Withholding — Services', '5', 'WHT', 'Non-resident', false],
        ],
      },
      onSubmit: (_) async {},
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      TaxesSettingsView(controller: _controller);
}
