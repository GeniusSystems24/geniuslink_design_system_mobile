import 'package:flutter/material.dart';

import '../../domain/domain.dart';
import '../widgets/mobile_dashboard_section_view.dart';

class BankingDashboardScreen extends StatelessWidget {
  final MobileDashboardCatalog catalog;

  const BankingDashboardScreen({
    required this.catalog,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MobileDashboardSectionView(
      catalog: catalog,
      sectionId: 'banking',
    );
  }
}
