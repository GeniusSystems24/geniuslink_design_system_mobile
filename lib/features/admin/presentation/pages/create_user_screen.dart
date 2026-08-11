part of 'users_screens.dart';

class CreateUserScreen extends StatelessWidget {
  const CreateUserScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var marker = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var icon = MIcons.of('lock');
    var marker2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon2 = MIcons.of('user');
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Invite User')),
      body: MScroll([
        SuperSectionCard2(
          trailing: (null),
          title: 'Identity',
          subtitle: "The new member's name and contact",
          initiallyExpanded: true,
          accentColor: marker2,
          icon: icon2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              TInput(
                label: 'Name English',
                placeholder: 'e.g. Omar Hassan',
                required: true,
              ),
              TInput(
                label: 'الاسم بالعربية',
                placeholder: 'مثال: عمر حسن',
                ar: true,
              ),
              TInput(
                label: 'Work Email',
                placeholder: 'name@geniuslink.sa',
                required: true,
              ),
              TInput(label: 'Employee ID', placeholder: 'Optional', mono: true),
            ],
          ),
        ),
        SuperSectionCard2(
          trailing: (null),
          title: 'Access',
          subtitle: 'Role determines default permissions',
          initiallyExpanded: true,
          accentColor: marker,
          icon: icon,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const TSelect(
                label: 'Role',
                value: 'Accountant',
                options: [
                  'Administrator',
                  'Controller',
                  'Accountant',
                  'Store Manager',
                  'Viewer',
                ],
              ),
              const TSelect(
                label: 'Default Store',
                value: 'All Stores',
                options: [
                  'All Stores',
                  'Downtown Central',
                  'King Fahd Warehouse',
                  'Jeddah Showroom',
                ],
              ),
              InfoNote(
                'An invitation email with a single-use setup link will be sent. The account stays Pending until the user sets a password.',
                tone: SuperMaterialThemeData.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
        const Row(
          children: [
            Expanded(
              child: MBtn('Cancel', variant: MBtnVariant.secondary, full: true),
            ),
            SizedBox(width: 10),
            Expanded(child: MBtn('Send Invitation', icon: 'check', full: true)),
          ],
        ),
      ]),
    );
  }
}
