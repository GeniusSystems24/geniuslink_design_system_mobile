part of '../../pages/contacts_screens.dart';

// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py

/// Renders the presentation for [ContactDetailScreen].
///
/// This widget contains the screen's existing layout and presentation
/// state while the corresponding `*Screen` file remains a small public
/// navigation/compatibility boundary. Business and data-layer behavior
/// is intentionally not introduced by this refactor.
///
/// Example:
///
/// ```dart
/// ContactDetailView(
///   kind: kind,
/// )
/// ```
class ContactDetailView extends StatelessWidget {
  final ContactKind kind;
  final int contactIndex;
  const ContactDetailView({
    required this.kind,
    this.contactIndex = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final d = kind;
    if (d.contacts.isEmpty) {
      return Scaffold(
        backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
        appBar: SuperAppBar(
          title: Text('${contactSingularLabel(d.type)} Detail'),
          actions: const [AppLanguageToggleButton(), AppThemeToggleButton()],
        ),
        body: Center(
          child: Text(
            'No ${contactSingularLabel(d.type).toLowerCase()} data available.',
            style: TextStyle(
              color: SuperMaterialThemeData.of(context).superTheme.fg3,
              fontFamily: SuperMaterialThemeData.of(
                context,
              ).textTheme.bodyMedium?.fontFamily,
            ),
          ),
        ),
      );
    }
    final safeIndex = contactIndex < 0
        ? 0
        : (contactIndex >= d.contacts.length
              ? d.contacts.length - 1
              : contactIndex);
    final c = d.contacts[safeIndex];
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var trailing = Pill(GeniusLinkLocalization.of(context).active);
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(
        title: Text('${contactSingularLabel(d.type)} Detail'),
        actions: const [AppLanguageToggleButton(), AppThemeToggleButton()],
      ),
      body: MScroll([
        SuperSectionCard2(
          trailing: trailing,
          title: 'Outstanding ${contactBalanceLabel(d.type)}',
          subtitle: '${c.orderCount} orders · since Apr 2024',
          initiallyExpanded: true,
          accentColor: accentColor2,

          padding: EdgeInsets.all(16),
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 12,
                large: 12,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      'SAR',
                      style: TextStyle(
                        fontFamily: SuperMaterialThemeData.of(
                          context,
                        ).textTheme.bodyMedium?.fontFamily,
                        fontSize: 14,
                        color: SuperMaterialThemeData.of(
                          context,
                        ).superTheme.fg3,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      formatContactAmount(c.balance),
                      style: TextStyle(
                        fontFamily: SuperMaterialThemeData.of(
                          context,
                        ).textTheme.bodyMedium?.fontFamily,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: contactTone(context, d),
                        letterSpacing: -0.6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: '${contactSingularLabel(d.type)} Information',

          initiallyExpanded: true,
          accentColor: accentColor3,

          padding: EdgeInsets.all(16),
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 6,
                large: 6,
                child: KeyValueRow(
                  GeniusLinkLocalization.of(context).code,
                  c.code,
                  mono: true,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 6,
                large: 6,
                child: KeyValueRow(
                  GeniusLinkLocalization.of(context).city,
                  c.city,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 6,
                large: 6,
                child: KeyValueRow(
                  GeniusLinkLocalization.of(context).contactPerson,
                  'Ahmed K.',
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 6,
                large: 6,
                child: KeyValueRow(
                  GeniusLinkLocalization.of(context).phone,
                  '+966 55 124 9020',
                  mono: true,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 6,
                large: 6,
                child: KeyValueRow(
                  GeniusLinkLocalization.of(context).controlAccount,
                  d.controlAccount,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 6,
                large: 6,
                child: KeyValueRow(
                  GeniusLinkLocalization.of(context).paymentTerms,
                  'Net 30',
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).transactionHistory,
          subtitle: GeniusLinkLocalization.of(
            context,
          ).recentInvoicesAndPayments,
          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(8),
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 12,
                large: 12,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      for (int i = 0; i < d.history.length; i++)
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: i < d.history.length - 1
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
                                      d.history[i].reference,
                                      style: TextStyle(
                                        fontFamily: SuperMaterialThemeData.of(
                                          context,
                                        ).textTheme.bodyMedium?.fontFamily,
                                        fontSize: 12,
                                        color: SuperMaterialThemeData.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${d.history[i].description} · ${formatContactDate(d.history[i].occurredAt)}',
                                      style: TextStyle(
                                        fontSize: 12,
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
                              ),
                              Text(
                                formatContactAmount(
                                  d.history[i].amount,
                                  signed: true,
                                ),
                                style: TextStyle(
                                  fontFamily: SuperMaterialThemeData.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontFamily,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                  color: d.history[i].amount >= 0
                                      ? SuperMaterialThemeData.of(
                                          context,
                                        ).colorScheme.secondary
                                      : SuperMaterialThemeData.of(
                                          context,
                                        ).colorScheme.error,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: MBtn(
                GeniusLinkLocalization.of(context).edit,
                variant: MBtnVariant.secondary,
                icon: 'edit',
                full: true,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: MBtn(
                GeniusLinkLocalization.of(context).archive,
                variant: MBtnVariant.danger,
                icon: 'trash',
                full: true,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
