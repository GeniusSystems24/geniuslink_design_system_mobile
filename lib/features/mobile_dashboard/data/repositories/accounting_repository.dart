import '../../domain/domain.dart';
import '../datasources/mobile_dashboard_data.dart';

// Navigation labels are localized by MobileDashboardScreen.

class AccountingRepository implements WorkspaceRepository {
  final MobileDashboardCatalog? _source;

  const AccountingRepository({MobileDashboardCatalog? source})
    : _source = source;

  @override
  String get sectionId => 'accounting';

  @override
  MobileDashboardCatalog get catalog =>
      workspaceCatalogForSection(_source ?? mobileDashboardCatalog, sectionId);

  @override
  List<MobileDashboardNavigationDestination> get navigationItems => const [
    (id: 'home', label: MobileDashboardNavigationCopy.overview, icon: 'home'),
    (id: 'ledger', label: MobileDashboardNavigationCopy.ledger, icon: 'doc'),
    (id: 'reports', label: MobileDashboardNavigationCopy.reports, icon: 'poll'),
    (id: 'more', label: MobileDashboardNavigationCopy.more, icon: 'dots'),
  ];
}
