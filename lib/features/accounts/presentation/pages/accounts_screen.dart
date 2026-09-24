part of 'accounts_screens.dart';

class AccountsScreen extends StatelessWidget {
  final List<Account> accounts;
  final ValueChanged<Account>? onAccountSelected;
  final AccountsScreenThemeData theme;

  const AccountsScreen({
    required this.accounts,
    this.onAccountSelected,
    this.theme = const AccountsScreenThemeData(),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = GeniusLinkLocalization.of(context);
    final materialTheme = SuperMaterialThemeData.of(context);

    return Scaffold(
      backgroundColor:
          theme.backgroundColor ?? materialTheme.colorScheme.surface,
      appBar: SuperAppBar(
        title: Text(l10n.accounts),
        actions: const [AppLanguageToggleButton(), AppThemeToggleButton()],
      ),
      body: MScroll([
        AccountsSearchPrompt(
          theme: theme.searchPrompt,
          start: const Icon(Icons.search_rounded, size: 16),
          center: Text(l10n.searchAccounts),
        ),
        AccountsListSection(
          theme: theme.listSection,
          children: [
            for (int index = 0; index < accounts.length; index++)
              AccountRow(
                account: accounts[index],
                last: index == accounts.length - 1,
                theme: theme.accountRow,
                onTap: () {
                  final callback = onAccountSelected;
                  if (callback != null) {
                    callback(accounts[index]);
                  } else {
                    context.goTo('accountDetail');
                  }
                },
              ),
          ],
        ),
      ]),
    );
  }
}
