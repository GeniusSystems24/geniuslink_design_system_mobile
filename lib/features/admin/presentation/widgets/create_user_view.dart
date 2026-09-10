import 'package:flutter/material.dart';

import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/shared/presentation/widgets/feature_page_scaffold.dart';

/// Presentation view extracted from `CreateUserScreen`.
///
/// Keeping rendering in a dedicated widget lets the page remain a lifecycle,
/// controller, and navigation boundary while this view stays independently
/// composable and testable.
///
/// Example:
///
/// ```dart
/// const CreateUserView()
/// ```
class CreateUserView extends StatelessWidget {
  const CreateUserView({super.key});
  @override
  Widget build(BuildContext context) {
    var marker = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var icon = MIcons.of('lock');
    var marker2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon2 = MIcons.of('user');
    return FeaturePageScaffold(
        title: Text(GeniusLinkLocalization.of(context).inviteUser),
        automaticallyImplyLeading: true,
        children: [
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
      ],
      );
  }
}
