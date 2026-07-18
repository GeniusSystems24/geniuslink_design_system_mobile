part of 'settings_org_screens.dart';

class FinancialSettingsScreen extends StatelessWidget {
  const FinancialSettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormCubit>(
      create: (_) => FormCubit(initial: const {'basis': 'accrual'}, onSubmit: (_) async {}),
      child: const FinancialSettingsView(),
    );
  }
}
