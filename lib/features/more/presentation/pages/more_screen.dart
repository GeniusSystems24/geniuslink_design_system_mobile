// ============================================================
// VIEW — More menu with reusable navigation configuration.
// ============================================================

import 'package:flutter/material.dart';

import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';
import '../models/models.dart';

class MoreScreen extends StatelessWidget {
  final List<NavigationGroup> groups;

  const MoreScreen({
    this.groups = defaultMoreNavigationGroups,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final spotlight = <AutoSuggestion<String>>[
      for (final group in groups)
        for (final item in group.items)
          AutoSuggestion<String>(
            value: item.routeId,
            label: item.label,
            group: group.title,
          ),
    ];

    var accentColor = SuperMaterialThemeData.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('More')),
      body: MScroll([
        MSuggest(
          items: spotlight,
          placeholder: 'Search every screen…',
          onSelected: context.goTo,
        ),
        for (final group in groups)
          SuperSectionCard2(
      trailing: (null),
      title: group.title,
      subtitle: (null),
      initiallyExpanded: true,
      accentColor: accentColor,
      icon: null,
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
                                        color: SuperMaterialThemeData.of(context)
                                            .superTheme
                                            .border,
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
                                    color: SuperMaterialThemeData.of(context)
                                        .superTheme
                                        .fg1,
                                    fontFamily: SuperMaterialThemeData.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.fontFamily,
                                  ),
                                ),
                                Icon(
                                  MIcons.of('chevR'),
                                  size: 16,
                                  color: SuperMaterialThemeData.of(context)
                                      .superTheme
                                      .fg4,
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
