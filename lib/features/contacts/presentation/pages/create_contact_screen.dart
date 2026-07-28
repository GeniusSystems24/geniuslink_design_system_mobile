part of 'contacts_screens.dart';

class CreateContactScreen extends StatelessWidget {
  final ContactKind kind;
  const CreateContactScreen({
    required this.kind,
    super.key,
  });

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
      appBar: SuperAppBar(title: Text('Add ${contactSingularLabel(d.type)}')),
      body: MScroll([
      SuperSectionCard2(
      trailing: (null),
      title: '${contactSingularLabel(d.type)} Identity',
      subtitle: 'Legal name and contact details',
      initiallyExpanded: true,
      accentColor: accentColor2,
      icon: icon2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          TInput(label: 'Name English', placeholder: contactSingularLabel(d.type) == 'Customer' ? 'e.g. Riyadh Construction Co.' : 'e.g. Global Steel Imports LLC', required: true),
          const TInput(label: 'الاسم بالعربية', placeholder: 'مثال: شركة الرياض للإنشاءات', ar: true),
          const TInput(label: 'Contact Person', placeholder: 'e.g. Ahmed K.'),
          const TInput(label: 'Phone', placeholder: '+966 5X XXX XXXX', mono: true),
          const TInput(label: 'Email', placeholder: 'name@company.com'),
          const TInput(label: 'City', placeholder: 'e.g. Riyadh'),
        ],
      ),
    ),
      SuperSectionCard2(
      trailing: (null),
      title: 'Financial',
      subtitle: 'Linked control account and terms',
      initiallyExpanded: true,
      accentColor: accentColor3,
      icon: icon3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          TSelect(label: 'Control Account', value: d.controlAccount, options: [d.controlAccount]),
          const TSelect(label: 'Payment Terms', value: 'Net 30', options: ['Net 15', 'Net 30', 'Net 60', 'On Receipt']),
          const TInput(label: 'Tax / VAT Number', placeholder: '3XXXXXXXXXXXXX3', mono: true),
          const TInput(label: 'Credit Limit (SAR)', placeholder: 'e.g. 100,000.00', mono: true),
        ],
      ),
    ),
      SuperSectionCard2(
      trailing: (null),
      title: 'Notes',
      subtitle: (null),
      initiallyExpanded: true,
      accentColor: accentColor,
      icon: icon,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          ITextarea(label: 'Notes', placeholder: 'Internal notes about this ${contactSingularLabel(d.type).toLowerCase()}…'),
        ],
      ),
    ),
      Row(children: [
        const Expanded(child: MBtn('Cancel', variant: MBtnVariant.secondary, full: true)),
        const SizedBox(width: 10),
        Expanded(child: MBtn('Add ${contactSingularLabel(d.type)}', icon: 'check', full: true)),
      ]),
    ]),
    );
  }
}
