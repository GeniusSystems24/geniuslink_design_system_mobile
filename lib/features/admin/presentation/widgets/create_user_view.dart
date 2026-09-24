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
          subtitle: GeniusLinkLocalization.of(
            context,
          ).theNewMemberSNameAndContact,
          initiallyExpanded: true,
          accentColor: marker2,
          icon: icon2,
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: TInput(
                  label: GeniusLinkLocalization.of(context).nameEnglish,
                  placeholder: GeniusLinkLocalization.of(context).eGOmarHassan,
                  required: true,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: TInput(
                  label: GeniusLinkLocalization.of(context).nameArabic,
                  placeholder: GeniusLinkLocalization.of(context).eGOmarHassan,
                  ar: true,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: TInput(
                  label: GeniusLinkLocalization.of(context).workEmail,
                  placeholder: 'name@geniuslink.sa',
                  required: true,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: TInput(
                  label: GeniusLinkLocalization.of(context).employeeId,
                  placeholder: GeniusLinkLocalization.of(context).optional,
                  mono: true,
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).access,
          subtitle: GeniusLinkLocalization.of(
            context,
          ).roleDeterminesDefaultPermissions,
          initiallyExpanded: true,
          accentColor: marker,
          icon: icon,
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: TSelect(
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
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: TSelect(
                  label: GeniusLinkLocalization.of(context).defaultStore,
                  value: 'All Stores',
                  options: [
                    'All Stores',
                    'Downtown Central',
                    'King Fahd Warehouse',
                    'Jeddah Showroom',
                  ],
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 12,
                large: 12,
                child: InfoNote(
                  GeniusLinkLocalization.of(
                    context,
                  ).anInvitationEmailWithASingleUseSetupLinkWillBeSentTheAccountStaysPendingUntilTheUserSetsAPassword,
                  tone: SuperMaterialThemeData.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: MBtn(
                GeniusLinkLocalization.of(context).cancel,
                variant: MBtnVariant.secondary,
                full: true,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: MBtn(
                GeniusLinkLocalization.of(context).sendInvitation,
                icon: 'check',
                full: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
