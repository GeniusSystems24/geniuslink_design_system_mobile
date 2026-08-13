part of 'banking_cash_screens.dart';

class CreateWithdrawalScreen extends StatelessWidget {
  const CreateWithdrawalScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.error;
    var icon = MIcons.of('card');
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon2 = MIcons.of('building');
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Create Withdrawal')),
      body: MScroll([
        SuperSectionCard2(
          
          title: 'Withdrawal Amount',
          
          initiallyExpanded: true,
          accentColor: accentColor,
          icon: icon,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              MMoney(
                label: 'Amount',
                value: '12,045.00',
                accent: SuperMaterialThemeData.of(context).colorScheme.error,
                required: true,
                sign: '−',
              ),
              const MMethod(value: 'wire'),
            ],
          ),
        ),
        SuperSectionCard2(
          
          title: 'Source & Purpose',
          
          initiallyExpanded: true,
          accentColor: accentColor2,
          icon: icon2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              IField(
                label: 'Withdraw From',
                value: 'Bank · NCB Main (1100)',
                select: true,
                required: true,
              ),
              IField(
                label: 'Payee',
                placeholder: 'e.g. Global Steel Imports',
                required: true,
              ),
              IField(
                label: 'Expense Account',
                value: 'Cost of Goods Sold (5001)',
                select: true,
              ),
              IField(
                label: 'Value Date',
                value: 'Dec 19, 2025',
                icon: 'calendar',
              ),
            ],
          ),
        ),
        InfoNote(
          'Withdrawals above 10,000 SAR require a second approval before posting.',
          tone: SuperMaterialThemeData.of(context).colorScheme.tertiary,
        ),
        const ActionRow(primary: 'Submit for Approval'),
      ]),
    );
  }
}
