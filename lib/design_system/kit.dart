// ============================================================
// GeniusLink Mobile — Kit Barrel
// Single import for all design-system components and adapters.
//
//   import '../../../design_system/kit.dart';
//
// File placement:  lib/design_system/kit.dart
// ============================================================

// Theme foundation
export 'package:super_core/super_core.dart' hide PillTone, FieldDensity;
export 'theme/super_core_theme_helpers.dart';

// Layout
export 'components/layout/m_icons.dart';
export 'components/layout/m_widgets.dart';
export 'components/layout/pressable_surface.dart';
export 'components/layout/directional_slot_tile.dart';
export 'components/layout/icon_surface.dart';
export 'components/layout/labeled_action_tile.dart';
export 'components/layout/adaptive_slot_grid.dart';
export 'components/layout/metric_slot_card.dart';
export 'components/layout/two_row_tile.dart';

// Feedback
export 'components/feedback/m_feedback.dart';
export 'components/feedback/status_badge.dart';
export 'components/feedback/animated_skeleton_box.dart';

// Buttons
export 'components/buttons/m_buttons.dart';

// Navigation
export 'components/navigation/m_shell.dart';

// Form adapters
export 'adapters/form/m_inputs.dart';

// Table adapter
export 'adapters/table/m_table.dart';

// Banking & Inventory kits
export 'adapters/banking/m_bank_kit.dart';
export 'adapters/inventory/m_inv_kit.dart';
export 'components/controls/segmented_slot_selector.dart';
