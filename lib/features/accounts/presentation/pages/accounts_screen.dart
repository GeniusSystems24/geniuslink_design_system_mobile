part of 'accounts_screens.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

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
            borderRadius: BorderRadius.circular(10)),
        child: Row(children: [
          Icon(Icons.search_rounded, size: 16, color: SuperMaterialThemeData.of(context).superTheme.fg3),
          SizedBox(width: 10),
          Text('Search accounts…',
              style: TextStyle(color: SuperMaterialThemeData.of(context).superTheme.fg3, fontSize: 14, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
        ]),
      ),
      MCard(pad: 8, children: [
        for (int i = 0; i < _accounts.length; i++)
          AccountRow(
              row: _accounts[i],
              last: i == _accounts.length - 1,
              onTap: () => context.goTo('accountDetail')),
      ]),
    ]),
    );
  }
}
