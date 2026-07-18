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

// Feedback
export 'components/feedback/m_feedback.dart';

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
