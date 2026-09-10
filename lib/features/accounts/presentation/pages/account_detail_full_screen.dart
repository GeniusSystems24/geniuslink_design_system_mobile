part of 'accounts_extra_screens.dart';

class AccountDetailFullScreen extends StatelessWidget {
  const AccountDetailFullScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = GeniusLinkLocalization.of(context);

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
    var trailing = Pill(l10n.active);
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor4 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: Text(l10n.accountDetail), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
      body: MScroll([
        SuperSectionCard2(
          trailing: trailing,
          title: l10n.currentBalance,
          subtitle: '${l10n.asOf} Dec 18, 2025 16:33',
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
                childAspectRatio: 1.7,
                children: [
                  Mini(label: l10n.totalDebits, value: '148,920', sub: 'SAR'),
                  Mini(label: l10n.totalCredits, value: '106,420', sub: 'SAR'),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: l10n.accountInformation,

          initiallyExpanded: true,
          accentColor: accentColor2,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              KV(l10n.code, '1001', mono: true),
              KV(l10n.accountType, l10n.assetCashEquivalents),
              KV(l10n.nameEnglish, 'Cash Box'),
              KV(l10n.nameArabic, 'الصندوق', ar: true),
              KV(l10n.accountTree, 'Assets Tree (1)'),
              KV(l10n.currency, 'SAR — Saudi Riyal'),
              KV(l10n.parentGroup, 'Current Assets (1000)'),
              KV(l10n.tenantId, '9', mono: true),
            ],
          ),
        ),
        SuperSectionCard2(
          title: l10n.recentTransactions,
          subtitle: l10n.latestEntriesRunningBalance,
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
                                  '${l10n.balanceShort} ${tx[i].$6}',
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
          title: l10n.auditInformation,

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
                    title: l10n.created,
                    doAt: DateTime(2024, 4, 12, 9, 21),
                    doBy: 'Admin User (ID: 5)',
                    cancelled: true,
                  ),
                  AuditItem(
                    title: l10n.modified,
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
            Expanded(
              child: MBtn(
                l10n.export,
                variant: MBtnVariant.secondary,
                icon: 'download',
                full: true,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: MBtn(
                l10n.back,
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
