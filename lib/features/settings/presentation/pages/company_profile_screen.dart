part of 'settings_org_screens.dart';

class CompanyProfileScreen extends StatelessWidget {
  const CompanyProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Company Profile')),
      body: MScroll([
      ISection(icon: MIcons.of('building'), title: 'Identity', sub: 'Names shown on documents', marker: SuperMaterialThemeData.of(context).colorScheme.primary, children: [
        Row(children: [
          Container(width: 64, height: 64, alignment: Alignment.center, decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.inputBg, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.borderStrong), borderRadius: BorderRadius.circular(12)), child: Icon(MIcons.of('building'), size: 26, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
          const SizedBox(width: 14),
          const MBtn('Upload Logo', variant: MBtnVariant.secondary, icon: 'download'),
        ]),
        const TInput(label: 'Legal Name (English)', defaultValue: 'Al-Rashid Trading Co.', required: true),
        const TInput(label: 'الاسم القانوني', defaultValue: 'شركة الراشد التجارية', ar: true, required: true),
        const TInput(label: 'Trade Name', defaultValue: 'GeniusLink'),
        const TInput(label: 'Commercial Registration', defaultValue: '1010234567', mono: true),
      ]),
      ISection(icon: MIcons.of('pin'), title: 'Registered Address', marker: SuperMaterialThemeData.of(context).colorScheme.secondary, children: const [
        TSelect(label: 'Country', value: 'Saudi Arabia', options: ['Saudi Arabia', 'United Arab Emirates', 'Kuwait', 'Qatar']),
        TInput(label: 'City', defaultValue: 'Riyadh'),
        TInput(label: 'Street Address', defaultValue: 'King Fahd Rd, Olaya'),
        TInput(label: 'Postal Code', defaultValue: '12211', mono: true),
      ]),
      ISection(icon: MIcons.of('percent'), title: 'Tax Registration', marker: SuperMaterialThemeData.of(context).colorScheme.tertiary, children: const [
        TInput(label: 'VAT Number', defaultValue: '300123456700003', mono: true, required: true),
        TInput(label: 'Tax Identification No.', defaultValue: '9100234567', mono: true),
        TSelect(label: 'Tax Authority', value: 'ZATCA (Saudi Arabia)', options: ['ZATCA (Saudi Arabia)', 'FTA (UAE)', 'GAZT']),
      ]),
      const MBtn('Save Changes', icon: 'check', full: true),
    ]),
    );
  }
}
