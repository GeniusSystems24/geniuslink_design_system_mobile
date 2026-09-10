part of '../pages/stores_screens.dart';

/// Presentation view extracted from `CreateStoreScreen`.
///
/// The route/page boundary remains in `presentation/pages`, while this widget
/// owns the visual composition. Keeping presentation widgets separate makes
/// the view easier to reuse, test, and break down further without coupling
/// navigation to rendering details.
///
/// Example:
///
/// ```dart
/// const CreateStoreView()
/// ```
class CreateStoreView extends StatelessWidget {
  const CreateStoreView({super.key});
  @override
  Widget build(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.primary;
    return FeaturePageScaffold(
      title: Text(GeniusLinkLocalization.of(context).createStore),
      automaticallyImplyLeading: true,
      children: [
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
      ],
    );
  }
}
