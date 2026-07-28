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
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: Text('Add ${contactSingularLabel(d.type)}')),
      body: MScroll([
      ISection(icon: MIcons.of('user'), title: '${contactSingularLabel(d.type)} Identity', subtitle: 'Legal name and contact details', accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, children: [
        TInput(label: 'Name English', placeholder: contactSingularLabel(d.type) == 'Customer' ? 'e.g. Riyadh Construction Co.' : 'e.g. Global Steel Imports LLC', required: true),
        const TInput(label: 'الاسم بالعربية', placeholder: 'مثال: شركة الرياض للإنشاءات', ar: true),
        const TInput(label: 'Contact Person', placeholder: 'e.g. Ahmed K.'),
        const TInput(label: 'Phone', placeholder: '+966 5X XXX XXXX', mono: true),
        const TInput(label: 'Email', placeholder: 'name@company.com'),
        const TInput(label: 'City', placeholder: 'e.g. Riyadh'),
      ]),
      ISection(icon: MIcons.of('swap'), title: 'Financial', subtitle: 'Linked control account and terms', accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, children: [
        TSelect(label: 'Control Account', value: d.controlAccount, options: [d.controlAccount]),
        const TSelect(label: 'Payment Terms', value: 'Net 30', options: ['Net 15', 'Net 30', 'Net 60', 'On Receipt']),
        const TInput(label: 'Tax / VAT Number', placeholder: '3XXXXXXXXXXXXX3', mono: true),
        const TInput(label: 'Credit Limit (SAR)', placeholder: 'e.g. 100,000.00', mono: true),
      ]),
      ISection(icon: MIcons.of('doc'), title: 'Notes', accentColor: SuperMaterialThemeData.of(context).colorScheme.tertiary, children: [
        ITextarea(label: 'Notes', placeholder: 'Internal notes about this ${contactSingularLabel(d.type).toLowerCase()}…'),
      ]),
      Row(children: [
        const Expanded(child: MBtn('Cancel', variant: MBtnVariant.secondary, full: true)),
        const SizedBox(width: 10),
        Expanded(child: MBtn('Add ${contactSingularLabel(d.type)}', icon: 'check', full: true)),
      ]),
    ]),
    );
  }
}
