import 'package:flutter/material.dart';

import '../../../../shared/presentation/controllers/form_controller.dart';
import '../widgets/financial_settings_view.dart';

class FinancialSettingsScreen extends StatefulWidget {
  const FinancialSettingsScreen({super.key});

  @override
  State<FinancialSettingsScreen> createState() =>
      _FinancialSettingsScreenState();
}

class _FinancialSettingsScreenState extends State<FinancialSettingsScreen> {
  late final FormController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FormController(
      initial: const {'basis': 'accrual'},
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
      FinancialSettingsView(controller: _controller);
}
