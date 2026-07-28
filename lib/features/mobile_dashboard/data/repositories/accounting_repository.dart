import '../../domain/domain.dart';
import '../datasources/mobile_dashboard_data.dart';

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
    (id: 'home', label: 'Overview', icon: 'home'),
    (id: 'ledger', label: 'Ledger', icon: 'doc'),
    (id: 'reports', label: 'Reports', icon: 'poll'),
    (id: 'more', label: 'More', icon: 'dots'),
  ];
}
