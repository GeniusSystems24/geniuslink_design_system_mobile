part of 'users_screens.dart';

class CreateUserScreen extends StatelessWidget {
  const CreateUserScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Invite User'),
      body: MScroll([
      ISection(icon: 'user', title: 'Identity', sub: "The new member's name and contact", marker: SuperMaterialThemeData.of(context).colorScheme.primary, children: const [
        TInput(label: 'Name English', placeholder: 'e.g. Omar Hassan', required: true),
        TInput(label: 'الاسم بالعربية', placeholder: 'مثال: عمر حسن', ar: true),
        TInput(label: 'Work Email', placeholder: 'name@geniuslink.sa', required: true),
        TInput(label: 'Employee ID', placeholder: 'Optional', mono: true),
      ]),
      ISection(icon: 'lock', title: 'Access', sub: 'Role determines default permissions', marker: SuperMaterialThemeData.of(context).colorScheme.secondary, children: [
        const TSelect(label: 'Role', value: 'Accountant', options: ['Administrator', 'Controller', 'Accountant', 'Store Manager', 'Viewer']),
        const TSelect(label: 'Default Store', value: 'All Stores', options: ['All Stores', 'Downtown Central', 'King Fahd Warehouse', 'Jeddah Showroom']),
        InfoNote('An invitation email with a single-use setup link will be sent. The account stays Pending until the user sets a password.', tone: SuperMaterialThemeData.of(context).colorScheme.primary),
      ]),
      const Row(children: [
        Expanded(child: MBtn('Cancel', variant: MBtnVariant.secondary, full: true)),
        SizedBox(width: 10),
        Expanded(child: MBtn('Send Invitation', icon: 'check', full: true)),
      ]),
    ]),
    );
  }
}
