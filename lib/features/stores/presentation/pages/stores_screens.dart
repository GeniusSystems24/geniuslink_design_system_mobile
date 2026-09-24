// ============================================================
// VIEW — Stores feature (ports MobileStores)
// list · createStore · storeDetail · issue
// ============================================================

import 'package:flutter/material.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';
import '../../domain/domain.dart';

import '../widgets/widgets.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/shared/presentation/widgets/feature_page_scaffold.dart';
export '../widgets/widgets.dart';
part 'stores_screen.dart';
part 'create_store_screen.dart';
part 'store_detail_screen.dart';
part 'issue_inventory_screen.dart';

part '../widgets/create_store_view.dart';
part '../widgets/issue_inventory_view.dart';
part '../widgets/store_detail_view.dart';
part '../widgets/stores_view.dart';

/// A dashed-border container (CustomPaint) for "add" affordances.
