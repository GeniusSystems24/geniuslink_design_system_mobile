part of 'accounts_extra_screens.dart';

class AccountTreeScreen extends StatefulWidget {
  final List<AccountNode> roots;
  final ValueChanged<Account>? onAccountOpen;
  final AccountTreeScreenThemeData theme;

  const AccountTreeScreen({
    required this.roots,
    this.onAccountOpen,
    this.theme = const AccountTreeScreenThemeData(),
    super.key,
  });

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
    final materialTheme = SuperMaterialThemeData.of(context);
    final fontFamily = materialTheme.textTheme.bodyMedium?.fontFamily;

    final headerStartStyle = TextStyle(
      fontFamily: fontFamily,
      color: materialTheme.superTheme.fg2,
    ).merge(widget.theme.headerStartStyle);
    final headerEndStyle = TextStyle(
      fontFamily: fontFamily,
      color: materialTheme.superTheme.fg2,
    ).merge(widget.theme.headerEndStyle);

    return Scaffold(
      backgroundColor:
          widget.theme.backgroundColor ?? materialTheme.colorScheme.surface,
      appBar: SuperAppBar(
        title: Text(l10n.accountTree),
        actions: const [AppLanguageToggleButton(), AppThemeToggleButton()],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SuperGrid(
          scope: SuperGridScope.current,
          children: [
            SuperGridCell(
              mobile: 4,
              tablet: 8,
              desktop: 12,
              large: 12,
              child: SizedBox(
                height: constraints.maxHeight,
                child: AccountTreeSection(
                  title: l10n.chartOfAccounts,
                  subtitle: l10n.rollUpBalancesBilingual,
                  icon: Icons.account_tree_outlined,
                  accentColor:
                      widget.theme.accentColor ??
                      materialTheme.colorScheme.primary,
                  theme: widget.theme.section,
                  headerStart: Text(l10n.account, style: headerStartStyle),
                  headerEnd: Text(l10n.balanceSar, style: headerEndStyle),
                  content: SuperTree<Account>(
                    controller: _controller,
                    leadingBuilder: _leading,
                    trailingBuilder: _trailing,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _leading(
    BuildContext context,
    TreeNode<Account> node,
    TreeRowInfo info,
  ) {
    final color = _typeDot(context)[node.value?.type];
    if (color == null) return const SizedBox.shrink();
    return Container(
      width: widget.theme.typeDotSize,
      height: widget.theme.typeDotSize,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget? _trailing(
    BuildContext context,
    TreeNode<Account> node,
    TreeRowInfo info,
  ) {
    final materialTheme = SuperMaterialThemeData.of(context);
    final baseStyle = TextStyle(
      fontFamily: materialTheme.textTheme.bodyMedium?.fontFamily,
      fontSize: 12,
      fontWeight: info.depth == 0 ? FontWeight.w700 : FontWeight.w500,
      color: materialTheme.superTheme.fg1,
    );

    return Text(
      _fmtAmount(_treeTotal(node)),
      style: baseStyle.merge(
        info.depth == 0
            ? widget.theme.rootAmountStyle ?? widget.theme.amountStyle
            : widget.theme.amountStyle,
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
