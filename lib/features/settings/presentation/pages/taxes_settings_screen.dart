part of 'settings_org_screens.dart';

class TaxesSettingsScreen extends StatelessWidget {
  const TaxesSettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormCubit>(
      create: (_) => FormCubit(initial: const {
        'rules': [
          ['Standard VAT', '15', 'VAT', 'Sales & Purchases', true],
          ['Zero-Rated', '0', 'VAT', 'Exports', true],
          ['Exempt', '0', 'VAT', 'Financial services', true],
          ['Withholding — Services', '5', 'WHT', 'Non-resident', false],
        ]
      }, onSubmit: (_) async {}),
      child: const TaxesSettingsView(),
    );
  }
}
