// ============================================================
// VIEW — More menu with reusable navigation configuration.
// ============================================================

import 'package:flutter/material.dart';

import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';
import '../models/models.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

class MoreScreen extends StatelessWidget {
  final List<NavigationGroup> groups;

  const MoreScreen({this.groups = defaultMoreNavigationGroups, super.key});

  @override
  Widget build(BuildContext context) {
    final spotlight = <SuperAutoSuggestionsItem<String>>[
      for (final group in groups)
        for (final item in group.items)
          SuperAutoSuggestionsItem<String>(
            value: item.routeId,
            titleText: item.label,
            group: group.title,
          ),
    ];

    var accentColor = SuperMaterialThemeData.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: Text(GeniusLinkLocalization.of(context).more), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
      body: MScroll([
        MSuggest(
          items: spotlight,
          placeholder: GeniusLinkLocalization.of(context).searchEveryScreen,
          onSelected: context.goTo,
        ),
        for (final group in groups)
          SuperSectionCard2(
            title: group.title,

            initiallyExpanded: true,
            accentColor: accentColor,

            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      for (int i = 0; i < group.items.length; i++)
                        GestureDetector(
                          onTap: () => context.goTo(group.items[i].routeId),
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            decoration: BoxDecoration(
                              border: i == group.items.length - 1
                                  ? null
                                  : Border(
                                      bottom: BorderSide(
                                        color: SuperMaterialThemeData.of(
                                          context,
                                        ).superTheme.border,
                                      ),
                                    ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  group.items[i].label,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).superTheme.fg1,
                                    fontFamily: SuperMaterialThemeData.of(
                                      context,
                                    ).textTheme.bodyMedium?.fontFamily,
                                  ),
                                ),
                                Icon(
                                  MIcons.of('chevR'),
                                  size: 16,
                                  color: SuperMaterialThemeData.of(
                                    context,
                                  ).superTheme.fg4,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ]),
    );
  }
}
