part of '../pages/settings_team_screens.dart';

/// Presentation view extracted from `RolesListScreen`.
///
/// The route/page boundary remains in `presentation/pages`, while this widget
/// owns the visual composition. Keeping presentation widgets separate makes
/// the view easier to reuse, test, and break down further without coupling
/// navigation to rendering details.
///
/// Example:
///
/// ```dart
/// const RolesListView()
/// ```
class RolesListView extends StatelessWidget {
  const RolesListView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = SuperMaterialThemeData.of(context).superTheme;
    final roles = [
      (
        'admin',
        'Administrator',
        SuperMaterialThemeData.of(context).colorScheme.primary,
        1,
        'Full access to every module and settings.',
        [('Accounts', 'Full'), ('Banking', 'Full'), ('Users', 'Full')],
      ),
      (
        'controller',
        'Controller',
        SuperMaterialThemeData.of(context).colorScheme.secondary,
        1,
        'Approves postings and manages the ledger.',
        [('Ledger', 'Full'), ('Banking', 'Full'), ('Users', 'View')],
      ),
      (
        'accountant',
        'Accountant',
        SuperMaterialThemeData.of(context).colorScheme.tertiary,
        2,
        'Creates and edits day-to-day transactions.',
        [('Accounts', 'Edit'), ('Ledger', 'Edit'), ('Reports', 'View')],
      ),
      (
        'manager',
        'Store Manager',
        theme.fg3,
        1,
        'Manages inventory and store operations.',
        [('Stores', 'Edit'), ('Inventory', 'Edit'), ('Banking', '—')],
      ),
      (
        'viewer',
        'Viewer',
        theme.fg3,
        1,
        'Read-only access to reports and records.',
        [('Reports', 'View'), ('Accounts', 'View'), ('Users', '—')],
      ),
    ];
    Color? levelColor(String level) => switch (level) {
      'Full' => SuperMaterialThemeData.of(context).colorScheme.secondary,
      'Edit' => SuperMaterialThemeData.of(context).colorScheme.primary,
      'View' => theme.fg3,
      _ => null,
    };
    return FeaturePageScaffold(
      title: Text(GeniusLinkLocalization.of(context).rolesList),
      automaticallyImplyLeading: true,
      children: [
        for (final r in roles)
          SuperSectionCard2(
            title: "",

            initiallyExpanded: true,
            accentColor: (null),

            padding: EdgeInsets.all(16),
            child: SuperGrid(
              scope: SuperGridScope.current,
              children: [
                SuperGridCell(
                  mobile: 4,
                  tablet: 8,
                  desktop: 12,
                  large: 12,
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: r.$3,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        r.$2,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: SuperMaterialThemeData.of(
                            context,
                          ).superTheme.fg1,
                          fontFamily: SuperMaterialThemeData.of(
                            context,
                          ).textTheme.bodyMedium?.fontFamily,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${r.$4} member${r.$4 == 1 ? '' : 's'}',
                        style: TextStyle(
                          fontFamily: SuperMaterialThemeData.of(
                            context,
                          ).textTheme.bodyMedium?.fontFamily,
                          fontSize: 11,
                          color: SuperMaterialThemeData.of(
                            context,
                          ).superTheme.fg3,
                        ),
                      ),
                    ],
                  ),
                ),
                SuperGridCell(
                  mobile: 4,
                  tablet: 8,
                  desktop: 12,
                  large: 12,
                  child: Text(
                    r.$5,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: SuperMaterialThemeData.of(context).superTheme.fg3,
                      height: 1.5,
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                    ),
                  ),
                ),
                SuperGridCell(
                  mobile: 4,
                  tablet: 8,
                  desktop: 12,
                  large: 12,
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: SuperMaterialThemeData.of(
                            context,
                          ).superTheme.border,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        for (final p in r.$6)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  p.$1,
                                  style: TextStyle(
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).superTheme.fg2,
                                    fontFamily: SuperMaterialThemeData.of(
                                      context,
                                    ).textTheme.bodyMedium?.fontFamily,
                                    fontSize: 12,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (levelColor(p.$2) != null)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 6,
                                        ),
                                        child: Container(
                                          width: 6,
                                          height: 6,
                                          decoration: BoxDecoration(
                                            color: levelColor(p.$2),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    Text(
                                      p.$2.toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10,
                                        letterSpacing: 0.4,
                                        color:
                                            levelColor(p.$2) ??
                                            SuperMaterialThemeData.of(
                                              context,
                                            ).superTheme.fg4,
                                        fontFamily: SuperMaterialThemeData.of(
                                          context,
                                        ).textTheme.bodyMedium?.fontFamily,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SuperGridCell(
                  mobile: 4,
                  tablet: 8,
                  desktop: 12,
                  large: 12,
                  child: MBtn(
                    GeniusLinkLocalization.of(context).editRole,
                    variant: MBtnVariant.secondary,
                    icon: 'edit',
                    full: true,
                    onTap: () => context.goTo('roleEditor'),
                  ),
                ),
              ],
            ),
          ),
        MBtn(
          GeniusLinkLocalization.of(context).newRole,
          icon: 'plus',
          full: true,
          onTap: () => context.goTo('roleEditor'),
        ),
      ],
    );
  }
}
