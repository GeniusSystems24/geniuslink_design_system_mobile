part of 'accounts_extra_screens.dart';

class AccountTreeScreen extends StatefulWidget {
  const AccountTreeScreen({super.key});
  @override
  State<AccountTreeScreen> createState() => _AccountTreeScreenState();
}

class _AccountTreeScreenState extends State<AccountTreeScreen> {
  late final SuperTreeController<Account> _c = SuperTreeController<Account>(
    roots: _accountRoots,
    searchText: (n) => '${n.code} ${n.name} ${n.value?.type ?? ''}',
    onOpenLeaf: (node) => context.goTo('accountDetail'),
  );

  @override
  void initState() {
    super.initState();
    _c.expandAll();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Account Tree'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SuperTree<Account>(
          controller: _c,
          leadingBuilder: _leading,
          trailingBuilder: _trailing,
          title: 'Chart of Accounts',
          subtitle: 'Roll-up balances · bilingual',
          nameColumnLabel: 'Account',
          trailingColumnLabel: 'Balance (SAR)',
          enableEditing: false,
        ),
      ),
    );
  }

  static Widget _leading(BuildContext context, TreeNode<Account> node, TreeRowInfo info) {
    final color = _typeDot(context)[node.value?.type];
    if (color == null) return const SizedBox.shrink();
    return Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
  }

  static Widget? _trailing(BuildContext context, TreeNode<Account> node, TreeRowInfo info) {
    return Text(
      _fmtAmount(_accTotal(node)),
      style: TextStyle(
        fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
        fontSize: 12,
        fontWeight: info.depth == 0 ? FontWeight.w700 : FontWeight.w500,
        color: SuperMaterialThemeData.of(context).superTheme.fg1,
      ),
    );
  }
}
