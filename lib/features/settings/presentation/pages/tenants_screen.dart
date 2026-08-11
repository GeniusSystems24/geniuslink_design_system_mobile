import 'dart:async' show unawaited;

import 'package:flutter/material.dart';

import '../../../../core/tenancy/tenant_connection.dart';
import '../../../../core/tenancy/tenant_session.dart';
import '../../../../design_system/kit.dart';
import '../../../../workspace/presentation/controllers/tenant_controller.dart';

class TenantsScreen extends StatefulWidget {
  final TenantController? controller;

  const TenantsScreen({super.key, this.controller});

  @override
  State<TenantsScreen> createState() => _TenantsScreenState();
}

class _TenantsScreenState extends State<TenantsScreen> {
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
        return Scaffold(
          backgroundColor: SuperMaterialThemeData.of(
            context,
          ).colorScheme.surface,
          appBar: SuperAppBar(title: const Text('Workspaces')),
          body: MScroll([
            for (final t in tenants)
              SuperSectionCard2(
                trailing: null,
                title: '',
                subtitle: null,
                initiallyExpanded: true,
                accentColor: null,
                icon: null,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
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
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Pill('Current'),
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
                    if (t.$1.toString() == activeId)
                      const MBtn(
                        'Manage Workspace',
                        variant: MBtnVariant.secondary,
                        icon: 'settings',
                        full: true,
                      )
                    else
                      MBtn(
                        'Switch to this Workspace',
                        icon: 'switch2',
                        full: true,
                        onTap: () =>
                            unawaited(_controller.switchTo(t.$1.toString())),
                      ),
                  ],
                ),
              ),
            const MBtn('New Workspace', icon: 'plus', full: true),
          ]),
        );
      },
    );
  }
}
