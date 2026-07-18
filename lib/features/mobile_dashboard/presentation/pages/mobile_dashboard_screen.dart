import '../../domain/domain.dart';
import 'banking_dashboard_screen.dart';

@Deprecated(
  'Use BankingDashboardScreen, AccountingDashboardScreen, or CommercialDashboardScreen.',
)
class MobileDashboardScreen extends BankingDashboardScreen {
  const MobileDashboardScreen({
    required MobileDashboardCatalog catalog,
    super.key,
  }) : super(catalog: catalog);
}
