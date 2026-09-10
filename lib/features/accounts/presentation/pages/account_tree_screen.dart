part of 'accounts_extra_screens.dart';

class AccountTreeScreen extends StatefulWidget {
  final List<AccountNode> roots;
  final ValueChanged<Account>? onAccountOpen;

  const AccountTreeScreen({required this.roots, this.onAccountOpen, super.key});

  @override
  State<AccountTreeScreen> createState() => _AccountTreeScreenState();
}

class _AccountTreeScreenState extends State<AccountTreeScreen> {
  late SuperTreeController<Account> _controller;

  @override
  void initState() {
    super.initState();
    _controller = _createController();
  }

  @override
  void didUpdateWidget(covariant AccountTreeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.roots != widget.roots ||
        oldWidget.onAccountOpen != widget.onAccountOpen) {
      _controller.dispose();
      _controller = _createController();
    }
  }

  SuperTreeController<Account> _createController() =>
      SuperTreeController<Account>(
        roots: widget.roots.map(_toTreeNode).toList(growable: false),
        searchText: (node) =>
            '${node.code} ${node.name} ${node.value?.type.name ?? ''}',
        onOpenLeaf: (node) {
          final account = node.value;
          if (account != null && widget.onAccountOpen != null) {
            widget.onAccountOpen!(account);
            return;
          }
          context.goTo('accountDetail');
        },
      )..expandAll();

  static TreeNode<Account> _toTreeNode(AccountNode node) => TreeNode<Account>(
    code: node.account.code,
    name: node.account.name,
    value: node.account,
    children: node.children.map(_toTreeNode).toList(growable: false),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = GeniusLinkLocalization.of(context);

    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: Text(l10n.accountTree), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // SuperSectionCard2 renders its body inside an internal Column.
            // Give the tree an explicit bounded height so its scrollable
            // viewport remains valid.
            final availableHeight = constraints.hasBoundedHeight
                ? constraints.maxHeight
                : 520.0;
            final contentHeight = availableHeight > 104
                ? availableHeight - 104
                : availableHeight;

            return SuperSectionCard2(
              title: l10n.chartOfAccounts,
              subtitle: l10n.rollUpBalancesBilingual,
              icon: Icons.account_tree_outlined,
              accentColor:
                  SuperMaterialThemeData.of(context).colorScheme.primary,
              collapsible: false,
              dividerAfterHeader: true,
              margin: EdgeInsets.zero,
              child: SizedBox(
                height: contentHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(l10n.account)),
                        Text(l10n.balanceSar),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: SuperTree<Account>(
                        controller: _controller,
                        leadingBuilder: _leading,
                        trailingBuilder: _trailing,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static Widget _leading(
    BuildContext context,
    TreeNode<Account> node,
    TreeRowInfo info,
  ) {
    final color = _typeDot(context)[node.value?.type];
    if (color == null) return const SizedBox.shrink();
    return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  static Widget? _trailing(
    BuildContext context,
    TreeNode<Account> node,
    TreeRowInfo info,
  ) {
    return Text(
      _fmtAmount(_treeTotal(node)),
      style: TextStyle(
        fontFamily: SuperMaterialThemeData.of(
          context,
        ).textTheme.bodyMedium?.fontFamily,
        fontSize: 12,
        fontWeight: info.depth == 0 ? FontWeight.w700 : FontWeight.w500,
        color: SuperMaterialThemeData.of(context).superTheme.fg1,
      ),
    );
  }

  static double _treeTotal(TreeNode<Account> node) {
    if (!node.hasChildren) return node.value?.balance ?? 0;
    return node.children!.fold<double>(
      0,
      (sum, child) => sum + _treeTotal(child),
    );
  }
}
