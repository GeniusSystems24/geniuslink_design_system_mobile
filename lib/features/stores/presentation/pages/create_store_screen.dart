part of 'stores_screens.dart';

class CreateStoreScreen extends StatelessWidget {
  const CreateStoreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: Text(GeniusLinkLocalization.of(context).createStore), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
      body: MScroll([
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).storeDetails,
          subtitle: GeniusLinkLocalization.of(context).nameAndLocation,
          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              MField(
                label: GeniusLinkLocalization.of(context).nameEnglish,
                placeholder: GeniusLinkLocalization.of(context).eGDowntownCentralStore,
                required: true,
              ),
              MField(
                label: GeniusLinkLocalization.of(context).nameArabic,
                placeholder: GeniusLinkLocalization.of(context).eGDowntownCentralStore,
                ar: true,
                required: true,
              ),
              MField(label: GeniusLinkLocalization.of(context).locationCode, value: 'ST-001', mono: true),
              MField(label: GeniusLinkLocalization.of(context).storeCategory, value: 'Retail'),
              MField(label: GeniusLinkLocalization.of(context).note, placeholder: GeniusLinkLocalization.of(context).addInternalNotes),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: MBtn(GeniusLinkLocalization.of(context).cancel, variant: MBtnVariant.secondary, full: true),
            ),
            SizedBox(width: 10),
            Expanded(child: MBtn(GeniusLinkLocalization.of(context).create, icon: 'check', full: true)),
          ],
        ),
      ]),
    );
  }
}
