part of 'currencies_screens.dart';

class FiscalYearSetupScreen extends StatelessWidget {
  const FiscalYearSetupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Fiscal Year')),
      body: MScroll([
      ISection(icon: 'calendar', title: 'Year Definition', subtitle: 'Define the active fiscal year boundaries', accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, trailing: const Pill('Open'), children: const [
        IField(label: 'Fiscal Year', value: '2024', mono: true),
        IField(label: 'Start Date', value: '01/01/2024', mono: true),
        IField(label: 'End Date', value: '12/31/2024', mono: true),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Accounting Periods', subtitle: '12 monthly periods · lock to prevent back-dated postings', children: [
        GridView.count(
          crossAxisCount: 3, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1.7,
          children: [
            for (int i = 0; i < months.length; i++) FiscalPeriodTile(month: months[i], state: i < 11 ? 'closed' : (i == 11 ? 'open' : 'future')),
          ],
        ),
      ]),
      const InfoNote('Closing a period locks all postings dated within it. A locked period can only be reopened by a controller with audit justification.'),
      const ActionRow(primary: 'Save Configuration'),
    ]),
    );
  }
}
