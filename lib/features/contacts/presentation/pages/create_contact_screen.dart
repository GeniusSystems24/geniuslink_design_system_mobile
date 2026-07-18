part of 'contacts_screens.dart';

class CreateContactScreen extends StatelessWidget {
  final _ContactKind kind;
  const CreateContactScreen._(this.kind, {super.key});
  factory CreateContactScreen.customer() => CreateContactScreen._(_customer);
  factory CreateContactScreen.supplier() => CreateContactScreen._(_supplier);
  @override
  Widget build(BuildContext context) {
    final d = kind;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: 'Add ${d.label}'),
      body: MScroll([
      ISection(icon: 'user', title: '${d.label} Identity', subtitle: 'Legal name and contact details', accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, children: [
        TInput(label: 'Name English', placeholder: d.label == 'Customer' ? 'e.g. Riyadh Construction Co.' : 'e.g. Global Steel Imports LLC', required: true),
        const TInput(label: 'الاسم بالعربية', placeholder: 'مثال: شركة الرياض للإنشاءات', ar: true),
        const TInput(label: 'Contact Person', placeholder: 'e.g. Ahmed K.'),
        const TInput(label: 'Phone', placeholder: '+966 5X XXX XXXX', mono: true),
        const TInput(label: 'Email', placeholder: 'name@company.com'),
        const TInput(label: 'City', placeholder: 'e.g. Riyadh'),
      ]),
      ISection(icon: 'swap', title: 'Financial', subtitle: 'Linked control account and terms', accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, children: [
        TSelect(label: 'Control Account', value: d.control, options: [d.control]),
        const TSelect(label: 'Payment Terms', value: 'Net 30', options: ['Net 15', 'Net 30', 'Net 60', 'On Receipt']),
        const TInput(label: 'Tax / VAT Number', placeholder: '3XXXXXXXXXXXXX3', mono: true),
        const TInput(label: 'Credit Limit (SAR)', placeholder: 'e.g. 100,000.00', mono: true),
      ]),
      ISection(icon: 'doc', title: 'Notes', accentColor: SuperMaterialThemeData.of(context).colorScheme.tertiary, children: [
        ITextarea(label: 'Notes', placeholder: 'Internal notes about this ${d.label.toLowerCase()}…'),
      ]),
      Row(children: [
        const Expanded(child: MBtn('Cancel', variant: MBtnVariant.secondary, full: true)),
        const SizedBox(width: 10),
        Expanded(child: MBtn('Add ${d.label}', icon: 'check', full: true)),
      ]),
    ]),
    );
  }
}
