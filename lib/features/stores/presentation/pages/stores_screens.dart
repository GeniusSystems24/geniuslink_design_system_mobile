// ============================================================
// VIEW — Stores feature (ports MobileStores)
// list · createStore · storeDetail · issue
// ============================================================

import 'package:flutter/material.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';

import '../widgets/widgets.dart';
export '../widgets/widgets.dart';
part 'stores_screen.dart';
part 'create_store_screen.dart';
part 'store_detail_screen.dart';
part 'issue_inventory_screen.dart';

final _stores = [
  ('ST-001', 'Downtown Central', 'وسط المدينة', '342,820', '1,248'),
  ('ST-002', 'King Fahd Warehouse', 'مستودع الملك فهد', '1,820,460', '4,892'),
  ('ST-003', 'Jeddah Showroom', 'صالة عرض جدة', '128,640', '412'),
];


/// A dashed-border container (CustomPaint) for "add" affordances.
