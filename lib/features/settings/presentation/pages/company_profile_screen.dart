part of 'settings_org_screens.dart';

class CompanyProfileScreen extends StatelessWidget {
  const CompanyProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var marker = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var icon = MIcons.of('percent');
    var marker2 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var icon2 = MIcons.of('pin');
    var marker3 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon3 = MIcons.of('building');
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: Text(GeniusLinkLocalization.of(context).companyProfile), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
      body: MScroll([
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).identity,
          subtitle: GeniusLinkLocalization.of(context).namesShownOnDocuments,
          initiallyExpanded: true,
          accentColor: marker3,
          icon: icon3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: SuperMaterialThemeData.of(
                        context,
                      ).superTheme.inputBg,
                      border: Border.all(
                        color: SuperMaterialThemeData.of(
                          context,
                        ).superTheme.borderStrong,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      MIcons.of('building'),
                      size: 26,
                      color: SuperMaterialThemeData.of(context).superTheme.fg3,
                    ),
                  ),
                  const SizedBox(width: 14),
                  MBtn(
                    GeniusLinkLocalization.of(context).uploadLogo,
                    variant: MBtnVariant.secondary,
                    icon: 'download',
                  ),
                ],
              ),
              TInput(
                label: GeniusLinkLocalization.of(context).legalNameEnglish,
                defaultValue: 'Al-Rashid Trading Co.',
                required: true,
              ),
              TInput(
                label: GeniusLinkLocalization.of(context).legalName,
                defaultValue: 'شركة الراشد التجارية',
                ar: true,
                required: true,
              ),
              TInput(label: GeniusLinkLocalization.of(context).tradeName, defaultValue: 'GeniusLink'),
              TInput(
                label: GeniusLinkLocalization.of(context).commercialRegistration,
                defaultValue: '1010234567',
                mono: true,
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).registeredAddress,

          initiallyExpanded: true,
          accentColor: marker2,
          icon: icon2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TSelect(
                label: 'Country',
                value: 'Saudi Arabia',
                options: [
                  'Saudi Arabia',
                  'United Arab Emirates',
                  'Kuwait',
                  'Qatar',
                ],
              ),
              TInput(label: GeniusLinkLocalization.of(context).city, defaultValue: 'Riyadh'),
              TInput(
                label: GeniusLinkLocalization.of(context).streetAddress,
                defaultValue: 'King Fahd Rd, Olaya',
              ),
              TInput(label: GeniusLinkLocalization.of(context).postalCode, defaultValue: '12211', mono: true),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).taxRegistration,

          initiallyExpanded: true,
          accentColor: marker,
          icon: icon,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TInput(
                label: GeniusLinkLocalization.of(context).vatNumber,
                defaultValue: '300123456700003',
                mono: true,
                required: true,
              ),
              TInput(
                label: GeniusLinkLocalization.of(context).taxIdentificationNo,
                defaultValue: '9100234567',
                mono: true,
              ),
              TSelect(
                label: GeniusLinkLocalization.of(context).taxAuthority,
                value: 'ZATCA (Saudi Arabia)',
                options: ['ZATCA (Saudi Arabia)', 'FTA (UAE)', 'GAZT'],
              ),
            ],
          ),
        ),
        MBtn(GeniusLinkLocalization.of(context).saveChanges, icon: 'check', full: true),
      ]),
    );
  }
}
