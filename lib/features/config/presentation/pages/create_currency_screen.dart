part of 'currencies_screens.dart';

class CreateCurrencyScreen extends StatelessWidget {
  const CreateCurrencyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var icon = MIcons.of('ledger');
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon2 = MIcons.of('swap');
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Add Currency')),
      body: MScroll([
        SuperSectionCard2(
          
          title: 'Currency Definition',
          subtitle: 'ISO code, display names and symbol',
          initiallyExpanded: true,
          accentColor: accentColor2,
          icon: icon2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              IField(
                label: 'ISO Code',
                placeholder: 'e.g. USD',
                mono: true,
                required: true,
              ),
              IField(label: 'Symbol', placeholder: 'e.g. \$', required: true),
              IField(
                label: 'Name English',
                placeholder: 'e.g. US Dollar',
                required: true,
              ),
              IField(
                label: 'الاسم بالعربية',
                placeholder: 'مثال: دولار أمريكي',
                ar: true,
                required: true,
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          
          title: 'Precision & Rate',
          subtitle: 'Decimal places and exchange rate against base',
          initiallyExpanded: true,
          accentColor: accentColor,
          icon: icon,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              IField(label: 'Decimal Places', value: '2', select: true),
              IField(
                label: 'Exchange Rate (per 1 SAR)',
                placeholder: 'e.g. 3.750200',
                mono: true,
              ),
              IToggle(label: 'Set as base currency', on: false),
            ],
          ),
        ),
        const ActionRow(primary: 'Add Currency'),
      ]),
    );
  }
}
