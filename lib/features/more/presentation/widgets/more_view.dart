part of '../pages/more_screen.dart';

/// Presentation view extracted from `MoreScreen`.
///
/// The route/page boundary remains in `presentation/pages`, while this widget
/// owns the visual composition. Keeping presentation widgets separate makes
/// the view easier to reuse, test, and break down further without coupling
/// navigation to rendering details.
///
/// Example:
///
/// ```dart
/// MoreView(
///   groups: groups,
/// )
/// ```
class MoreView extends StatelessWidget {
  final List<NavigationGroup>? groups;

  const MoreView({this.groups, super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = GeniusLinkLocalization.of(context);
    final groups = this.groups ?? buildDefaultMoreNavigationGroups(l10n);

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
    return FeaturePageScaffold(
      title: Text(GeniusLinkLocalization.of(context).more),
      automaticallyImplyLeading: true,
      children: [
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
      ],
    );
  }
}
