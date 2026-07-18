part of 'banking_cash_screens.dart';

class CreateWithdrawalScreen extends StatelessWidget {
  const CreateWithdrawalScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Create Withdrawal'),
      body: MScroll([
      ISection(icon: 'card', title: 'Withdrawal Amount', accentColor: SuperMaterialThemeData.of(context).colorScheme.error, children: [
        MMoney(label: 'Amount', value: '12,045.00', accent: SuperMaterialThemeData.of(context).colorScheme.error, required: true, sign: '−'),
        MMethod(value: 'wire'),
      ]),
      ISection(icon: 'building', title: 'Source & Purpose', accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, children: [
        IField(label: 'Withdraw From', value: 'Bank · NCB Main (1100)', select: true, required: true),
        IField(label: 'Payee', placeholder: 'e.g. Global Steel Imports', required: true),
        IField(label: 'Expense Account', value: 'Cost of Goods Sold (5001)', select: true),
        IField(label: 'Value Date', value: 'Dec 19, 2025', icon: 'calendar'),
      ]),
      InfoNote('Withdrawals above 10,000 SAR require a second approval before posting.', tone: SuperMaterialThemeData.of(context).colorScheme.tertiary),
      ActionRow(primary: 'Submit for Approval'),
    ]),
    );
  }
}
