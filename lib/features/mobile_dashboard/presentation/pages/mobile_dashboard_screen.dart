import '../../domain/domain.dart';
import 'banking_dashboard_screen.dart';

@Deprecated(
  'Use BankingDashboardScreen, AccountingDashboardScreen, or CommercialDashboardScreen.',
)
class MobileDashboardScreen extends BankingDashboardScreen {
  const MobileDashboardScreen({
    required super.catalog,
    super.key,
  });
}
