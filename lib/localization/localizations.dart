import 'package:flutter/widgets.dart';

import 'generated/l10n.dart';
import 'generated/l10n_en.dart';

export 'generated/l10n.dart';

/// English fallback used when no [GeniusLinkLocalization] is available
/// from the current widget tree.
final GeniusLinkLocalization superTreeEnglishLocalizationFallback =
    GeniusLinkLocalizationEn();

/// Provides convenient access to GeniusLink localized strings from a
/// [BuildContext].
extension GeniusLinkLocalizationBuildContext on BuildContext {
  /// Returns the active [GeniusLinkLocalization] for this context.
  ///
  /// Falls back to [superTreeEnglishLocalizationFallback] when the
  /// package localization delegate is not installed above this context.
  GeniusLinkLocalization get superTreeLocalization =>
      Localizations.of<GeniusLinkLocalization>(this, GeniusLinkLocalization) ??
      superTreeEnglishLocalizationFallback;
}
