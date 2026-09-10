import '../../domain/domain.dart';
import '../datasources/mobile_dashboard_data.dart';

// Navigation labels are localized by MobileDashboardScreen.

class CommercialRepository implements WorkspaceRepository {
  final MobileDashboardCatalog? _source;

  const CommercialRepository({MobileDashboardCatalog? source})
    : _source = source;

  @override
  String get sectionId => 'commercial';

  @override
  MobileDashboardCatalog get catalog =>
      workspaceCatalogForSection(_source ?? mobileDashboardCatalog, sectionId);

  @override
  List<MobileDashboardNavigationDestination> get navigationItems => const [
    (id: 'home', label: MobileDashboardNavigationCopy.overview, icon: 'home'),
    (id: 'sales', label: MobileDashboardNavigationCopy.sales, icon: 'send'),
    (id: 'inventory', label: MobileDashboardNavigationCopy.inventory, icon: 'grid'),
    (id: 'more', label: MobileDashboardNavigationCopy.more, icon: 'dots'),
  ];
}
