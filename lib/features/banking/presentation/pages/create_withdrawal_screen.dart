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
      appBar: SuperAppBar(title: Text(GeniusLinkLocalization.of(context).createWithdrawal), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
      body: MScroll([
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).withdrawalAmount,

          initiallyExpanded: true,
          accentColor: accentColor,
          icon: icon,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              MMoney(
                label: GeniusLinkLocalization.of(context).amount,
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
            children: [
              IField(
                label: GeniusLinkLocalization.of(context).withdrawFrom,
                value: 'Bank · NCB Main (1100)',
                select: true,
                required: true,
              ),
              IField(
                label: GeniusLinkLocalization.of(context).payee,
                placeholder: GeniusLinkLocalization.of(context).eGGlobalSteelImports,
                required: true,
              ),
              IField(
                label: GeniusLinkLocalization.of(context).expenseAccount,
                value: 'Cost of Goods Sold (5001)',
                select: true,
              ),
              IField(
                label: GeniusLinkLocalization.of(context).valueDate,
                value: 'Dec 19, 2025',
                icon: 'calendar',
              ),
            ],
          ),
        ),
        InfoNote(
          GeniusLinkLocalization.of(context).withdrawalsAbove10000SarRequireASecondApprovalBeforePosting,
          tone: SuperMaterialThemeData.of(context).colorScheme.tertiary,
        ),
        const ActionRow(primary: 'Submit for Approval'),
      ]),
    );
  }
}
