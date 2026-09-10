part of 'contacts_screens.dart';

class CreateContactScreen extends StatelessWidget {
  final ContactKind kind;
  const CreateContactScreen({required this.kind, super.key});

  @override
  Widget build(BuildContext context) {
    final d = kind;
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var icon = MIcons.of('doc');
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon2 = MIcons.of('user');
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var icon3 = MIcons.of('swap');
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: Text('Add ${contactSingularLabel(d.type)}'), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
      body: MScroll([
        SuperSectionCard2(
          title: '${contactSingularLabel(d.type)} Identity',
          subtitle: GeniusLinkLocalization.of(context).legalNameAndContactDetails,
          initiallyExpanded: true,
          accentColor: accentColor2,
          icon: icon2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TInput(
                label: GeniusLinkLocalization.of(context).nameEnglish,
                placeholder: contactSingularLabel(d.type) == 'Customer'
                    ? 'e.g. Riyadh Construction Co.'
                    : 'e.g. Global Steel Imports LLC',
                required: true,
              ),
              TInput(
                label: GeniusLinkLocalization.of(context).nameArabic,
                placeholder: GeniusLinkLocalization.of(context).eGRiyadhConstructionCo,
                ar: true,
              ),
              TInput(
                label: GeniusLinkLocalization.of(context).contactPerson,
                placeholder: GeniusLinkLocalization.of(context).eGAhmedK,
              ),
              TInput(
                label: GeniusLinkLocalization.of(context).phone,
                placeholder: '+966 5X XXX XXXX',
                mono: true,
              ),
              TInput(label: GeniusLinkLocalization.of(context).email, placeholder: 'name@company.com'),
              TInput(label: GeniusLinkLocalization.of(context).city, placeholder: GeniusLinkLocalization.of(context).eGRiyadh),
            ],
          ),
        ),
        SuperSectionCard2(
          title: 'Financial',
          subtitle: GeniusLinkLocalization.of(context).linkedControlAccountAndTerms,
          initiallyExpanded: true,
          accentColor: accentColor3,
          icon: icon3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TSelect(
                label: GeniusLinkLocalization.of(context).controlAccount,
                value: d.controlAccount,
                options: [d.controlAccount],
              ),
              TSelect(
                label: GeniusLinkLocalization.of(context).paymentTerms,
                value: 'Net 30',
                options: ['Net 15', 'Net 30', 'Net 60', 'On Receipt'],
              ),
              TInput(
                label: GeniusLinkLocalization.of(context).taxVatNumber,
                placeholder: '3XXXXXXXXXXXXX3',
                mono: true,
              ),
              TInput(
                label: GeniusLinkLocalization.of(context).creditLimitSar,
                placeholder: GeniusLinkLocalization.of(context).eG10000000,
                mono: true,
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).notes,

          initiallyExpanded: true,
          accentColor: accentColor,
          icon: icon,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              ITextarea(
                label: GeniusLinkLocalization.of(context).notes,
                placeholder:
                    'Internal notes about this ${contactSingularLabel(d.type).toLowerCase()}…',
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: MBtn(GeniusLinkLocalization.of(context).cancel, variant: MBtnVariant.secondary, full: true),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: MBtn(
                'Add ${contactSingularLabel(d.type)}',
                icon: 'check',
                full: true,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
