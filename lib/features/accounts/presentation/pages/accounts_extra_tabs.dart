part of 'accounts_extra_screens.dart';

class AccountsExtraTabs extends StatefulWidget {
  final List<AccountNode> accountRoots;

  const AccountsExtraTabs({required this.accountRoots, super.key});

  @override
  State<AccountsExtraTabs> createState() => _AccountsExtraTabsState();
}

class _AccountsExtraTabsState extends State<AccountsExtraTabs> {
  late SuperTabBarController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = _createTabs();
  }

  @override
  void didUpdateWidget(covariant AccountsExtraTabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.accountRoots != widget.accountRoots) {
      _tabs.dispose();
      _tabs = _createTabs();
    }
  }

  SuperTabBarController _createTabs() => SuperTabBarController(
    tabs: [
      BrowserTab(
        id: 1,
        title: 'Chart of Accounts',
        pinned: true,
        behavior: SuperTabBehavior.requiredPinned,
        leading: const Icon(Icons.account_tree_outlined, size: 15),
        pageBuilder: (context, tab) =>
            AccountTreeScreen(roots: widget.accountRoots),
      ),
      BrowserTab(
        id: 2,
        title: 'Account Detail',
        leading: const Icon(Icons.description_outlined, size: 15),
        pageBuilder: (context, tab) => const AccountDetailFullScreen(),
      ),
    ],
    activeId: 1,
  );

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SuperTabBar(
      controller: _tabs,
      fillContent: true,
      scrollContent: false,
      contentPadding: EdgeInsets.zero,
      allowAutoCompact: true,
    );
  }
}
