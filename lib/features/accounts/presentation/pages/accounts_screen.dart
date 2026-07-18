
part of 'accounts_screens.dart';

class AccountsScreen extends StatelessWidget {
  final List<Account> accounts;
  final ValueChanged<Account>? onAccountSelected;

  const AccountsScreen({
    required this.accounts,
    this.onAccountSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Accounts'),
      body: MScroll([
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: SuperMaterialThemeData.of(context).superTheme.inputBg,
            border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.borderStrong),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(children: [
            Icon(Icons.search_rounded, size: 16, color: SuperMaterialThemeData.of(context).superTheme.fg3),
            const SizedBox(width: 10),
            Text('Search accounts…', style: TextStyle(color: SuperMaterialThemeData.of(context).superTheme.fg3, fontSize: 14, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
          ]),
        ),
        MCard(pad: 8, children: [
          for (int i = 0; i < accounts.length; i++)
            AccountRow(
              account: accounts[i],
              last: i == accounts.length - 1,
              onTap: () {
                final callback = onAccountSelected;
                if (callback != null) {
                  callback(accounts[i]);
                } else {
                  context.goTo('accountDetail');
                }
              },
            ),
        ]),
      ]),
    );
  }
}
