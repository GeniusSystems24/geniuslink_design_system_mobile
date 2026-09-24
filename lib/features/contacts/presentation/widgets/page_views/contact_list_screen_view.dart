part of '../../pages/contacts_screens.dart';

// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py

/// Renders the presentation for [ContactListScreen].
///
/// This widget contains the screen's existing layout and presentation
/// state while the corresponding `*Screen` file remains a small public
/// navigation/compatibility boundary. Business and data-layer behavior
/// is intentionally not introduced by this refactor.
///
/// Example:
///
/// ```dart
/// ContactListView(
///   kind: kind,
///   detailKey: detailKey,
/// )
/// ```
class ContactListView extends StatefulWidget {
  final ContactKind kind;
  final String detailKey;
  const ContactListView({
    required this.kind,
    required this.detailKey,
    super.key,
  });

  @override
  State<ContactListView> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListView> {
  String _q = '';
  String _status = 'All';
  @override
  Widget build(BuildContext context) {
    final d = widget.kind;
    final ql = _q.trim().toLowerCase();
    final visible = d.contacts.where((contact) {
      final statusMatches =
          _status == 'All' || contact.status.name == _status.toLowerCase();
      final queryMatches =
          ql.isEmpty ||
          contact.name.toLowerCase().contains(ql) ||
          contact.code.toLowerCase().contains(ql) ||
          contact.arabicName.contains(_q);
      return statusMatches && queryMatches;
    }).toList();
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(
        title: Text(contactPluralLabel(d.type)),
        actions: const [AppLanguageToggleButton(), AppThemeToggleButton()],
      ),
      body: MScroll([
        SearchInput(
          placeholder: 'Search ${contactPluralLabel(d.type).toLowerCase()}…',
          value: _q,
          onChange: (v) => setState(() => _q = v),
        ),
        Segmented(
          options: const ['All', 'Active', 'Pending', 'Inactive'],
          value: _status,
          onChange: (v) => setState(() => _status = v),
        ),
        SuperSectionCard2(
          title: "",

          initiallyExpanded: true,
          accentColor: (null),

          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < visible.length; i++)
                GestureDetector(
                  onTap: () => context.goTo(widget.detailKey),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 13,
                    ),
                    decoration: BoxDecoration(
                      border: i < visible.length - 1
                          ? Border(
                              bottom: BorderSide(
                                color: SuperMaterialThemeData.of(
                                  context,
                                ).superTheme.border,
                              ),
                            )
                          : null,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                visible[i].name,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                  color: SuperMaterialThemeData.of(
                                    context,
                                  ).superTheme.fg1,
                                  fontFamily: SuperMaterialThemeData.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontFamily,
                                ),
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  visible[i].arabicName,
                                  style: TextStyle(
                                    fontFamily: SuperMaterialThemeData.of(
                                      context,
                                    ).textTheme.bodyMedium?.fontFamily,
                                    fontSize: 12,
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).superTheme.fg3,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  Text(
                                    visible[i].code,
                                    style: TextStyle(
                                      fontFamily: SuperMaterialThemeData.of(
                                        context,
                                      ).textTheme.bodyMedium?.fontFamily,
                                      fontSize: 10.5,
                                      color: SuperMaterialThemeData.of(
                                        context,
                                      ).superTheme.fg3,
                                    ),
                                  ),
                                  Text(
                                    '  ·  ',
                                    style: TextStyle(
                                      color: SuperMaterialThemeData.of(
                                        context,
                                      ).superTheme.fg4,
                                      fontSize: 10.5,
                                    ),
                                  ),
                                  Text(
                                    visible[i].city,
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      color: SuperMaterialThemeData.of(
                                        context,
                                      ).superTheme.fg3,
                                      fontFamily: SuperMaterialThemeData.of(
                                        context,
                                      ).textTheme.bodyMedium?.fontFamily,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              formatContactAmount(visible[i].balance),
                              style: TextStyle(
                                fontFamily: SuperMaterialThemeData.of(
                                  context,
                                ).textTheme.bodyMedium?.fontFamily,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: visible[i].balance == 0
                                    ? SuperMaterialThemeData.of(
                                        context,
                                      ).superTheme.fg4
                                    : contactTone(context, d),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Pill(
                              visible[i].status.name,
                              tone: contactStatusTone(visible[i].status),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              if (visible.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 36),
                  child: Center(
                    child: Text(
                      'No ${contactPluralLabel(d.type).toLowerCase()} match.',
                      style: TextStyle(
                        color: SuperMaterialThemeData.of(
                          context,
                        ).superTheme.fg3,
                        fontSize: 13,
                        fontFamily: SuperMaterialThemeData.of(
                          context,
                        ).textTheme.bodyMedium?.fontFamily,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ]),
    );
  }
}
