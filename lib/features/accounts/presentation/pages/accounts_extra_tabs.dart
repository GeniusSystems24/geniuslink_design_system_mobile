part of 'accounts_extra_screens.dart';

class AccountsExtraTabs extends StatefulWidget {
  final List<AccountNode> accountRoots;
  final AccountsExtraTabsThemeData theme;

  const AccountsExtraTabs({
    required this.accountRoots,
    this.theme = const AccountsExtraTabsThemeData(),
    super.key,
  });

  @override
  State<AccountsExtraTabs> createState() => _AccountsExtraTabsState();
}

class _AccountsExtraTabsState extends State<AccountsExtraTabs> {
  SuperTabBarController? _tabs;
  String? _tabsLocaleName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = GeniusLinkLocalization.of(context);

    if (_tabs != null && _tabsLocaleName == l10n.localeName) {
      return;
    }

    _tabs?.dispose();
    _tabsLocaleName = l10n.localeName;
    _tabs = _createTabs(l10n);
  }

  @override
  void didUpdateWidget(covariant AccountsExtraTabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.accountRoots != widget.accountRoots ||
        oldWidget.theme != widget.theme) {
      _tabs?.dispose();
      _tabs = _createTabs(GeniusLinkLocalization.of(context));
    }
  }

  SuperTabBarController _createTabs(GeniusLinkLocalization l10n) =>
      SuperTabBarController(
        tabs: [
          SuperTab(
            id: 1,
            title: l10n.chartOfAccounts,
            pinned: true,
            behavior: SuperTabBehavior.requiredPinned,
            leading: const Icon(Icons.account_tree_outlined, size: 15),
            pageBuilder: (context, tab) => AccountTreeScreen(
              roots: widget.accountRoots,
              theme: widget.theme.tree,
            ),
          ),
          SuperTab(
            id: 2,
            title: l10n.accountDetail,
            leading: const Icon(Icons.description_outlined, size: 15),
            pageBuilder: (context, tab) =>
                AccountDetailFullScreen(theme: widget.theme.detail),
          ),
        ],
        activeId: 1,
      );

  @override
  void dispose() {
    _tabs?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AccountsTabsView(controller: _tabs!, theme: widget.theme.tabs);
  }
}
