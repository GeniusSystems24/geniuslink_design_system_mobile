part of 'accounts_extra_screens.dart';

class AccountDetailFullScreen extends StatelessWidget {
  const AccountDetailFullScreen({
    super.key,
    this.theme = const AccountDetailFullScreenTheme(),
  });

  final AccountDetailFullScreenTheme theme;

  @override
  Widget build(BuildContext context) {
    final l10n = GeniusLinkLocalization.of(context);
    final materialTheme = SuperMaterialThemeData.of(context);
    final colors = materialTheme.colorScheme;
    final superTheme = materialTheme.superTheme;
    final fontFamily = materialTheme.textTheme.bodyMedium?.fontFamily;

    const transactions = [
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

    final currentBalanceTopStartStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      color: superTheme.fg3,
    ).merge(theme.currentBalanceContent.topStartStyle);

    final currentBalanceTopEndStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: colors.secondary,
      letterSpacing: -0.6,
    ).merge(theme.currentBalanceContent.topEndStyle);

    TextStyle transactionTopStartStyle() => TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
          color: colors.primary,
        ).merge(theme.transactionContent.topStartStyle);

    TextStyle transactionTopEndStyle(bool positive) => TextStyle(
          fontFamily: fontFamily,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: positive ? colors.secondary : colors.error,
        ).merge(
          positive
              ? theme.transactionContent.topEndPositiveStyle
              : theme.transactionContent.topEndNegativeStyle,
        );

    TextStyle transactionBottomStartStyle() => TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
          color: superTheme.fg3,
        ).merge(theme.transactionContent.bottomStartStyle);

    TextStyle transactionBottomEndStyle() => TextStyle(
          fontFamily: fontFamily,
          fontSize: 11.5,
          color: superTheme.fg2,
        ).merge(theme.transactionContent.bottomEndStyle);

    return Scaffold(
      backgroundColor: theme.backgroundColor ?? colors.surface,
      appBar: SuperAppBar(
        title: Text(l10n.accountDetail),
        actions: const [
          AppLanguageToggleButton(),
          AppThemeToggleButton(),
        ],
      ),
      body: MScroll([
        AccountDetailCurrentBalanceSection(
          title: l10n.currentBalance,
          subtitle: '${l10n.asOf} Dec 18, 2025 16:33',
          trailing: Pill(l10n.active),
          accentColor: theme.currentBalanceAccentColor ?? colors.secondary,
          theme: theme.currentBalanceSection,
          topStart: Text('SAR', style: currentBalanceTopStartStyle),
          topEnd: Text('42,500.00', style: currentBalanceTopEndStyle),
          bottomStart: Mini(
            label: l10n.totalDebits,
            value: '148,920',
            sub: 'SAR',
          ),
          bottomEnd: Mini(
            label: l10n.totalCredits,
            value: '106,420',
            sub: 'SAR',
          ),
        ),
        SuperSectionCard2(
          title: l10n.accountInformation,
          initiallyExpanded: true,
          accentColor: theme.informationAccentColor ?? colors.primary,
          padding: const EdgeInsets.all(16),
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
        AccountDetailRecentTransactionsSection(
          title: l10n.recentTransactions,
          subtitle: l10n.latestEntriesRunningBalance,
          accentColor:
              theme.recentTransactionsAccentColor ?? colors.secondary,
          theme: theme.recentTransactionsSection,
          children: [
            for (final transaction in transactions)
              TwoRowTile(
                theme: theme.transactionTile,
                topStart: Text(
                  transaction.$1,
                  style: transactionTopStartStyle(),
                ),
                topEnd: Text(
                  transaction.$4,
                  style: transactionTopEndStyle(transaction.$5),
                ),
                bottomStart: Text(
                  '${transaction.$3} · ${transaction.$2}',
                  style: transactionBottomStartStyle(),
                ),
                bottomEnd: Text(
                  '${l10n.balanceShort} ${transaction.$6}',
                  style: transactionBottomEndStyle(),
                ),
              ),
          ],
        ),
        SuperSectionCard2(
          title: l10n.auditInformation,
          initiallyExpanded: true,
          accentColor: theme.auditAccentColor ?? colors.tertiary,
          padding: const EdgeInsets.all(16),
          child: AuditColumn(
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
        ),
        AccountDetailActions(
          theme: theme.actions,
          start: MBtn(
            l10n.export,
            variant: MBtnVariant.secondary,
            icon: 'download',
            full: true,
          ),
          end: MBtn(
            l10n.back,
            variant: MBtnVariant.secondary,
            icon: 'back',
            full: true,
            onTap: () => context.goTo('accounts'),
          ),
        ),
      ]),
    );
  }
}
