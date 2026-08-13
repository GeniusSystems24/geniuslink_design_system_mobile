part of 'accounts_extra_screens.dart';

class AccountDetailFullScreen extends StatelessWidget {
  const AccountDetailFullScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const tx = [
      (
        'JV-2024-0042',
        'Dec 15, 14:22',
        'Opening balance',
        '+5,000.00',
        true,
        '5,000.00',
      ),
      (
        'JV-2024-0058',
        'Dec 16, 09:14',
        'Cash sale — Customer 102',
        '+1,250.00',
        true,
        '6,250.00',
      ),
      (
        'TR-9042',
        'Dec 17, 11:48',
        'Transfer to NCB Bank',
        '-1,800.00',
        false,
        '4,450.00',
      ),
      (
        'JV-2024-0071',
        'Dec 18, 16:33',
        'Petty cash reimbursement',
        '+650.00',
        true,
        '5,100.00',
      ),
    ];
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var trailing = const Pill('Active');
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor4 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Account Detail')),
      body: MScroll([
        SuperSectionCard2(
          trailing: trailing,
          title: 'Current Balance',
          subtitle: 'As of Dec 18, 2025 16:33',
          initiallyExpanded: true,
          accentColor: accentColor3,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    'SAR',
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 14,
                      color: SuperMaterialThemeData.of(context).superTheme.fg3,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '42,500.00',
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: SuperMaterialThemeData.of(
                        context,
                      ).colorScheme.secondary,
                      letterSpacing: -0.6,
                    ),
                  ),
                ],
              ),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.4,
                children: const [
                  Mini(label: 'Total Debits', value: '148,920', sub: 'SAR'),
                  Mini(label: 'Total Credits', value: '106,420', sub: 'SAR'),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: 'Account Information',

          initiallyExpanded: true,
          accentColor: accentColor2,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              KV('Code', '1001', mono: true),
              KV('Type', 'Asset · Cash Equivalents'),
              KV('Name English', 'Cash Box'),
              KV('Name Arabic', 'الصندوق', ar: true),
              KV('Account Tree', 'Assets Tree (1)'),
              KV('Currency', 'SAR — Saudi Riyal'),
              KV('Parent Group', 'Current Assets (1000)'),
              KV('Tenant ID', '9', mono: true),
            ],
          ),
        ),
        SuperSectionCard2(
          title: 'Recent Transactions',
          subtitle: 'Latest entries · running balance',
          initiallyExpanded: true,
          accentColor: accentColor4,

          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    for (int i = 0; i < tx.length; i++)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: i < tx.length - 1
                              ? Border(
                                  bottom: BorderSide(
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).superTheme.border,
                                  ),
                                )
                              : null,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tx[i].$1,
                                  style: TextStyle(
                                    fontFamily: SuperMaterialThemeData.of(
                                      context,
                                    ).textTheme.bodyMedium?.fontFamily,
                                    fontSize: 12,
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                                Text(
                                  tx[i].$4,
                                  style: TextStyle(
                                    fontFamily: SuperMaterialThemeData.of(
                                      context,
                                    ).textTheme.bodyMedium?.fontFamily,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: tx[i].$5
                                        ? SuperMaterialThemeData.of(
                                            context,
                                          ).colorScheme.secondary
                                        : SuperMaterialThemeData.of(
                                            context,
                                          ).colorScheme.error,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${tx[i].$3} · ${tx[i].$2}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: SuperMaterialThemeData.of(
                                        context,
                                      ).superTheme.fg3,
                                      fontFamily: SuperMaterialThemeData.of(
                                        context,
                                      ).textTheme.bodyMedium?.fontFamily,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Bal ${tx[i].$6}',
                                  style: TextStyle(
                                    fontFamily: SuperMaterialThemeData.of(
                                      context,
                                    ).textTheme.bodyMedium?.fontFamily,
                                    fontSize: 11.5,
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).superTheme.fg2,
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
            ],
          ),
        ),
        SuperSectionCard2(
          title: 'Audit Information',

          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              AuditColumn(
                connectIndictors: true,
                items: [
                  AuditItem(
                    title: 'Created',
                    doAt: DateTime(2024, 4, 12, 9, 21),
                    doBy: 'Admin User (ID: 5)',
                    cancelled: true,
                  ),
                  AuditItem(
                    title: 'Modified',
                    doAt: DateTime(2025, 11, 2, 15, 48),
                    doBy: 'Layla A. (ID: 12)',
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            const Expanded(
              child: MBtn(
                'Export',
                variant: MBtnVariant.secondary,
                icon: 'download',
                full: true,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: MBtn(
                'Back',
                variant: MBtnVariant.secondary,
                icon: 'back',
                full: true,
                onTap: () => context.goTo('accounts'),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
