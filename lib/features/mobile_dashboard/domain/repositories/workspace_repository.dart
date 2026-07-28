import '../entities/entities.dart';
import '../object_values/navigation_destination.dart';

/// Provides the dashboard catalog for one workspace module.
abstract interface class WorkspaceRepository {
  String get sectionId;
  MobileDashboardCatalog get catalog;
  List<MobileDashboardNavigationDestination> get navigationItems;
}

MobileDashboardCatalog workspaceCatalogForSection(
  MobileDashboardCatalog source,
  String sectionId,
) {
  final tabs = source.tabs
      .where((tab) => tab.id == sectionId)
      .toList(growable: false);
  final profile = source.profiles[sectionId];
  final profiles = profile == null
      ? <String, MdDashboardProfile>{}
      : <String, MdDashboardProfile>{sectionId: profile};

  return MobileDashboardCatalog(
    tabs: tabs,
    workspaces: source.workspaces,
    attention: profile?.attentionItems ?? source.attention,
    currencies: source.currencies,
    axisLabels: source.axisLabels,
    profiles: profiles,
  );
}
