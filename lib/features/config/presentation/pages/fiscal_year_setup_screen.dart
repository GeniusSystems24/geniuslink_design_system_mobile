part of 'currencies_screens.dart';

class FiscalYearSetupScreen extends StatelessWidget {
  const FiscalYearSetupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var trailing = const Pill('Open');
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon = MIcons.of('calendar');
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Fiscal Year')),
      body: MScroll([
      SuperSectionCard2(
      trailing: trailing,
      title: 'Year Definition',
      subtitle: 'Define the active fiscal year boundaries',
      initiallyExpanded: true,
      accentColor: accentColor2,
      icon: icon,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: const [
          IField(label: 'Fiscal Year', value: '2024', mono: true),
          IField(label: 'Start Date', value: '01/01/2024', mono: true),
          IField(label: 'End Date', value: '12/31/2024', mono: true),
        ],
      ),
    ),
      SuperSectionCard2(
      trailing: (null),
      title: 'Accounting Periods' ?? "",
      subtitle: '12 monthly periods · lock to prevent back-dated postings',
      initiallyExpanded: true,
      accentColor: accentColor,
      icon: null,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          GridView.count(
            crossAxisCount: 3, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1.7,
            children: [
              for (int i = 0; i < months.length; i++) FiscalPeriodTile(month: months[i], state: i < 11 ? 'closed' : (i == 11 ? 'open' : 'future')),
            ],
          ),
        ],
      ),
    ),
      const InfoNote('Closing a period locks all postings dated within it. A locked period can only be reopened by a controller with audit justification.'),
      const ActionRow(primary: 'Save Configuration'),
    ]),
    );
  }
}
