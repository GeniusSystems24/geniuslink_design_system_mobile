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
      appBar: SuperAppBar(title: Text(GeniusLinkLocalization.of(context).inviteUser), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
      body: MScroll([
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).identity,
          subtitle: GeniusLinkLocalization.of(context).theNewMemberSNameAndContact,
          initiallyExpanded: true,
          accentColor: marker2,
          icon: icon2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TInput(
                label: GeniusLinkLocalization.of(context).nameEnglish,
                placeholder: GeniusLinkLocalization.of(context).eGOmarHassan,
                required: true,
              ),
              TInput(
                label: GeniusLinkLocalization.of(context).nameArabic,
                placeholder: GeniusLinkLocalization.of(context).eGOmarHassan,
                ar: true,
              ),
              TInput(
                label: GeniusLinkLocalization.of(context).workEmail,
                placeholder: 'name@geniuslink.sa',
                required: true,
              ),
              TInput(label: GeniusLinkLocalization.of(context).employeeId, placeholder: GeniusLinkLocalization.of(context).optional, mono: true),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).access,
          subtitle: GeniusLinkLocalization.of(context).roleDeterminesDefaultPermissions,
          initiallyExpanded: true,
          accentColor: marker,
          icon: icon,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TSelect(
                label: GeniusLinkLocalization.of(context).role,
                value: 'Accountant',
                options: [
                  'Administrator',
                  'Controller',
                  'Accountant',
                  'Store Manager',
                  'Viewer',
                ],
              ),
              TSelect(
                label: GeniusLinkLocalization.of(context).defaultStore,
                value: 'All Stores',
                options: [
                  'All Stores',
                  'Downtown Central',
                  'King Fahd Warehouse',
                  'Jeddah Showroom',
                ],
              ),
              InfoNote(
                GeniusLinkLocalization.of(context).anInvitationEmailWithASingleUseSetupLinkWillBeSentTheAccountStaysPendingUntilTheUserSetsAPassword,
                tone: SuperMaterialThemeData.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: MBtn(GeniusLinkLocalization.of(context).cancel, variant: MBtnVariant.secondary, full: true),
            ),
            SizedBox(width: 10),
            Expanded(child: MBtn(GeniusLinkLocalization.of(context).sendInvitation, icon: 'check', full: true)),
          ],
        ),
      ]),
    );
  }
}
