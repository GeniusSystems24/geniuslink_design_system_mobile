part of 'reports_screens.dart';

class AuditLogScreen extends StatefulWidget {
  const AuditLogScreen({super.key});
  @override
  State<AuditLogScreen> createState() => _AuditLogScreenState();
}

class _AuditLogScreenState extends State<AuditLogScreen> {
  String _act = 'All';
  @override
  Widget build(BuildContext context) {
    const logs = [
      (
        '2025-12-19 10:14:02',
        'Layla A.',
        'POST',
        'JV-2024-0226',
        '10.4.22.18',
        PillTone.success
      ),
      (
        '2025-12-18 11:02:55',
        'Layla A.',
        'CREATE',
        'EXT-2024-0311',
        '10.4.22.18',
        PillTone.info
      ),
      (
        '2025-12-18 10:05:31',
        'Controller',
        'APPROVE',
        'DEP-2024-0182',
        '10.4.22.03',
        PillTone.success
      ),
      (
        '2025-12-18 09:42:10',
        'Layla A.',
        'CREATE',
        'DEP-2024-0182',
        '10.4.22.18',
        PillTone.info
      ),
      (
        '2025-12-17 16:20:44',
        'Layla A.',
        'EDIT',
        'Account 1200',
        '10.4.22.18',
        PillTone.warning
      ),
      (
        '2025-12-12 14:08:09',
        'Admin',
        'VOID',
        'JV-2024-0150',
        '10.4.22.01',
        PillTone.danger
      ),
      (
        '2025-12-01 00:00:01',
        'System',
        'LOCK',
        'Period Nov 2024',
        'internal',
        PillTone.neutral
      ),
    ];
    final visible = logs.where((l) => _act == 'All' || l.$3 == _act).toList();
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Audit Log'),
      body: MScroll([
        Segmented(options: const [
          'All',
          'POST',
          'CREATE',
          'APPROVE',
          'EDIT',
          'VOID',
          'LOCK'
        ], value: _act, onChange: (v) => setState(() => _act = v)),
        MCard(
            accentColor: SuperMaterialThemeData.of(context).colorScheme.tertiary,
            title: 'Immutable Activity Trail',
            subtitle: 'Every state-changing action · 7-year retention',
            pad: 8,
            children: [
              MTable(
                showSearch: true,
                searchHint: 'Search entity or user…',
                itemNoun: 'event',
                itemNounPlural: 'events',
                columns: const [
                  MCol('entity', 'Entity', flex: 1),
                  MCol('action', 'Action', fixed: 100),
                ],
                rows: [
                  for (final l in visible)
                    {
                      'entity': '${l.$4}\n${l.$2} · ${l.$5} · ${l.$1}',
                      'action': l.$3
                    },
                ],
              ),
              if (visible.isEmpty)
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                        child: Text('No log entries match.',
                            style: TextStyle(
                                color: SuperMaterialThemeData.of(context).superTheme.fg3,
                                fontSize: 13,
                                fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)))),
            ]),
      ]),
    );
  }
}
