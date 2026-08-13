part of 'users_screens.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});
  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  bool _twofa = true;
  @override
  Widget build(BuildContext context) {
    const activity = [
      ('Posted JV-2024-0226', 'Dec 19, 10:14'),
      ('Created DEP-2024-0182', 'Dec 18, 09:42'),
      ('Edited account 1200', 'Dec 17, 16:20'),
    ];
    const sessions = [
      ('MacBook Pro · Chrome', 'Riyadh · 10.4.22.18 · now', true),
      ('iPhone 15 · App', 'Riyadh · 10.4.22.51 · 2h ago', false),
      ('Windows · Edge', 'Jeddah · 94.12.8.140 · Yesterday', false),
    ];
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var marker = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon = MIcons.of('user');
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('User Detail')),
      body: MScroll([
        SuperSectionCard2(
          
          title: "",
          
          initiallyExpanded: true,
          accentColor: (null),
          
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Avatar('Layla Ahmed', size: 56),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Layla Ahmed',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: SuperMaterialThemeData.of(
                              context,
                            ).superTheme.fg1,
                            fontFamily: SuperMaterialThemeData.of(
                              context,
                            ).textTheme.bodyMedium?.fontFamily,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'layla.a@geniuslink.sa',
                          style: TextStyle(
                            fontFamily: SuperMaterialThemeData.of(
                              context,
                            ).textTheme.bodyMedium?.fontFamily,
                            fontSize: 12,
                            color: SuperMaterialThemeData.of(
                              context,
                            ).superTheme.fg3,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Row(
                          children: [
                            UserRoleChip(),
                            SizedBox(width: 8),
                            Pill('Active'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          
          title: 'Profile',
          
          initiallyExpanded: true,
          accentColor: marker,
          icon: icon,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              TInput(label: 'Full Name', defaultValue: 'Layla Ahmed'),
              TInput(
                label: 'Work Email',
                defaultValue: 'layla.a@geniuslink.sa',
                mono: true,
              ),
              TInput(
                label: 'Employee ID',
                defaultValue: 'EMP-0012',
                mono: true,
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          
          title: 'Security',
          
          initiallyExpanded: true,
          accentColor: accentColor2,
          
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Two-Factor Authentication',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: SuperMaterialThemeData.of(
                              context,
                            ).superTheme.fg1,
                            fontFamily: SuperMaterialThemeData.of(
                              context,
                            ).textTheme.bodyMedium?.fontFamily,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _twofa ? 'Enabled · Authenticator app' : 'Disabled',
                          style: TextStyle(
                            fontSize: 11.5,
                            color: SuperMaterialThemeData.of(
                              context,
                            ).superTheme.fg3,
                            fontFamily: SuperMaterialThemeData.of(
                              context,
                            ).textTheme.bodyMedium?.fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _twofa = !_twofa),
                    child: Container(
                      width: 42,
                      height: 24,
                      decoration: BoxDecoration(
                        color: _twofa
                            ? SuperMaterialThemeData.of(
                                context,
                              ).colorScheme.secondary
                            : SuperMaterialThemeData.of(
                                context,
                              ).superTheme.inputBg,
                        border: Border.all(
                          color: _twofa
                              ? SuperMaterialThemeData.of(
                                  context,
                                ).colorScheme.secondary
                              : SuperMaterialThemeData.of(
                                  context,
                                ).superTheme.borderStrong,
                        ),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: AnimatedAlign(
                        duration: const Duration(milliseconds: 150),
                        alignment: _twofa
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          width: 18,
                          height: 18,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          
          title: 'Active Sessions',
          subtitle: 'Devices currently signed in',
          initiallyExpanded: true,
          accentColor: accentColor3,
          
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    for (int i = 0; i < sessions.length; i++)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: i < sessions.length - 1
                              ? Border(
                                  bottom: BorderSide(
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).superTheme.border,
                                  ),
                                )
                              : null,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              MIcons.of(sessions[i].$3 ? 'briefcase' : 'swap'),
                              size: 17,
                              color: SuperMaterialThemeData.of(
                                context,
                              ).superTheme.fg3,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        sessions[i].$1,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: SuperMaterialThemeData.of(
                                            context,
                                          ).superTheme.fg1,
                                          fontFamily: SuperMaterialThemeData.of(
                                            context,
                                          ).textTheme.bodyMedium?.fontFamily,
                                        ),
                                      ),
                                      if (sessions[i].$3)
                                        const Padding(
                                          padding: EdgeInsets.only(left: 7),
                                          child: Pill('This'),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    sessions[i].$2,
                                    style: TextStyle(
                                      fontFamily: SuperMaterialThemeData.of(
                                        context,
                                      ).textTheme.bodyMedium?.fontFamily,
                                      fontSize: 10.5,
                                      color: SuperMaterialThemeData.of(
                                        context,
                                      ).superTheme.fg3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (!sessions[i].$3)
                              Text(
                                'Revoke',
                                style: TextStyle(
                                  color: SuperMaterialThemeData.of(
                                    context,
                                  ).colorScheme.error,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: SuperMaterialThemeData.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontFamily,
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          
          title: 'Recent Activity',
          
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
                    for (int i = 0; i < activity.length; i++)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 11),
                        decoration: BoxDecoration(
                          border: i < activity.length - 1
                              ? Border(
                                  bottom: BorderSide(
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).superTheme.border,
                                  ),
                                )
                              : null,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              activity[i].$1,
                              style: TextStyle(
                                fontSize: 13,
                                color: SuperMaterialThemeData.of(
                                  context,
                                ).superTheme.fg1,
                                fontFamily: SuperMaterialThemeData.of(
                                  context,
                                ).textTheme.bodyMedium?.fontFamily,
                              ),
                            ),
                            Text(
                              activity[i].$2,
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
                  ],
                ),
              ),
            ],
          ),
        ),
        const MBtn(
          'Deactivate User',
          variant: MBtnVariant.danger,
          icon: 'trash',
          full: true,
        ),
      ]),
    );
  }
}
