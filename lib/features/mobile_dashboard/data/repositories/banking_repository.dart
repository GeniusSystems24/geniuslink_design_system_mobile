import '../../domain/domain.dart';
import '../datasources/mobile_dashboard_data.dart';

class BankingRepository implements WorkspaceRepository {
  final MobileDashboardCatalog? _source;

  const BankingRepository({MobileDashboardCatalog? source}) : _source = source;

  @override
  String get sectionId => 'banking';

  @override
  MobileDashboardCatalog get catalog =>
      workspaceCatalogForSection(_source ?? mobileDashboardCatalog, sectionId);

  @override
  List<MobileDashboardNavigationDestination> get navigationItems => const [
    (id: 'home', label: 'Overview', icon: 'home'),
    (id: 'accounts', label: 'Accounts', icon: 'inbox'),
    (id: 'transfers', label: 'Transfers', icon: 'send'),
    (id: 'more', label: 'More', icon: 'dots'),
  ];
}
