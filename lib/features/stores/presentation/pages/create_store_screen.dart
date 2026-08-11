part of 'stores_screens.dart';

class CreateStoreScreen extends StatelessWidget {
  const CreateStoreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Create Store')),
      body: MScroll([
        SuperSectionCard2(
          trailing: (null),
          title: 'Store Details',
          subtitle: 'Name and location',
          initiallyExpanded: true,
          accentColor: accentColor,
          icon: null,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              MField(
                label: 'Name English',
                placeholder: 'e.g. Downtown Central Store',
                required: true,
              ),
              MField(
                label: 'الاسم بالعربية',
                placeholder: 'مثال: متجر وسط المدينة',
                ar: true,
                required: true,
              ),
              MField(label: 'Location Code', value: 'ST-001', mono: true),
              MField(label: 'Store Category', value: 'Retail'),
              MField(label: 'Note', placeholder: 'Add internal notes…'),
            ],
          ),
        ),
        const Row(
          children: [
            Expanded(
              child: MBtn('Cancel', variant: MBtnVariant.secondary, full: true),
            ),
            SizedBox(width: 10),
            Expanded(child: MBtn('Create', icon: 'check', full: true)),
          ],
        ),
      ]),
    );
  }
}
