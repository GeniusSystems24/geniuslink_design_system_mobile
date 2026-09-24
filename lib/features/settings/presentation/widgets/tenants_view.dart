part of '../pages/tenants_screen.dart';

/// Presentation view extracted from `TenantsScreen`.
///
/// The route/page boundary remains in `presentation/pages`, while this widget
/// owns the visual composition. Keeping presentation widgets separate makes
/// the view easier to reuse, test, and break down further without coupling
/// navigation to rendering details.
///
/// Example:
///
/// ```dart
/// TenantsView(
///   controller: controller,
/// )
/// ```
class TenantsView extends StatefulWidget {
  final TenantController? controller;

  const TenantsView({super.key, this.controller});

  @override
  State<TenantsView> createState() => _TenantsViewState();
}

class _TenantsViewState extends State<TenantsView> {
  TenantController? _ownedController;

  TenantController get _controller => widget.controller ?? _ownedController!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _ownedController =
          TenantController(
            resolver: const FakeTenantConnectionResolver(),
          )..setAvailable(const [
            TenantRef(id: '9', name: 'Al-Rashid Trading Co.', plan: 'Business'),
            TenantRef(id: '14', name: 'Najd Holdings', plan: 'Enterprise'),
            TenantRef(id: '22', name: 'Coastal Logistics', plan: 'Starter'),
          ]);
      unawaited(_ownedController!.switchTo('9'));
    }
  }

  @override
  void dispose() {
    _ownedController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tenants = [
      (
        9,
        'Al-Rashid Trading Co.',
        'Administrator',
        'Business',
        6,
        SuperMaterialThemeData.of(context).colorScheme.primary,
      ),
      (
        14,
        'Najd Holdings',
        'Controller',
        'Enterprise',
        28,
        SuperMaterialThemeData.of(context).colorScheme.secondary,
      ),
      (
        22,
        'Coastal Logistics',
        'Accountant',
        'Starter',
        3,
        SuperMaterialThemeData.of(context).colorScheme.tertiary,
      ),
    ];

    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        final activeId = _controller.state.activeTenantId;
        return FeaturePageScaffold(
          title: Text(GeniusLinkLocalization.of(context).workspaces),
          automaticallyImplyLeading: true,
          children: [
            for (final t in tenants)
              SuperSectionCard2(
                trailing: null,
                title: '',
                subtitle: null,
                initiallyExpanded: true,
                accentColor: null,

                padding: const EdgeInsets.all(16),
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
                            width: 44,
                            height: 44,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: superCoreTint(t.$6, 0x1F),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: Icon(
                              MIcons.of('building'),
                              size: 22,
                              color: t.$6,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        t.$2,
                                        style: TextStyle(
                                          fontSize: 14.5,
                                          fontWeight: FontWeight.w700,
                                          color: SuperMaterialThemeData.of(
                                            context,
                                          ).superTheme.fg1,
                                          fontFamily: SuperMaterialThemeData.of(
                                            context,
                                          ).textTheme.bodyMedium?.fontFamily,
                                        ),
                                      ),
                                    ),
                                    if (t.$1.toString() == activeId)
                                      Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Pill(
                                          GeniusLinkLocalization.of(
                                            context,
                                          ).current2,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Tenant ${t.$1} · ${t.$3} · ${t.$5} members',
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
                          Pill(
                            t.$4,
                            tone: t.$4 == 'Enterprise'
                                ? PillTone.info
                                : (t.$4 == 'Business'
                                      ? PillTone.success
                                      : PillTone.neutral),
                          ),
                        ],
                      ),
                    ),

                    SuperGridCell(
                      mobile: 4,
                      tablet: 8,
                      desktop: 12,
                      large: 12,
                      child: (t.$1.toString() == activeId)
                          ? MBtn(
                              GeniusLinkLocalization.of(
                                context,
                              ).manageWorkspace,
                              variant: MBtnVariant.secondary,
                              icon: 'settings',
                              full: true,
                            )
                          : MBtn(
                              GeniusLinkLocalization.of(
                                context,
                              ).switchToThisWorkspace,
                              icon: 'switch2',
                              full: true,
                              onTap: () => unawaited(
                                _controller.switchTo(t.$1.toString()),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            MBtn(
              GeniusLinkLocalization.of(context).newWorkspace,
              icon: 'plus',
              full: true,
            ),
          ],
        );
      },
    );
  }
}
