import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'screen_route_registry.dart';

/// Extension methods on [BuildContext] that bridge legacy screen ID
/// navigation to GoRouter typed routes.
///
/// Use these during incremental migration so that call sites switch
/// from `nav.go('id')` / `nav.back('target')` to
/// `context.goTo('id')` / `context.goBack()` / `context.goBackTo('target')`.
extension NavigationExtensions on BuildContext {
  /// Navigate to the sub-screen identified by [screenId].
  /// Uses [ScreenRouteRegistry] to resolve the GoRouter path.
  ///
  /// If [screenId] is not registered, this call is a no-op
  /// (avoids breaking the app during partial migration).
  void goTo(String screenId) {
    final path = ScreenRouteRegistry.path(screenId);
    if (path == null) return;
    // Tab roots switch the shell branch; all other destinations are pushed
    // so the back stack is preserved and the user can navigate back.
    const tabRoots = {'/dashboard', '/accounts', '/stores', '/more'};
    if (tabRoots.contains(path)) {
      go(path);
    } else {
      push(path);
    }
  }

  /// Pop the current screen and return to the previous one.
  void goBack() => pop<dynamic>();

  /// Navigate to the tab or sub-screen identified by [screenId],
  /// replacing the current location (used for back-to-target).
  void goBackTo(String screenId) => goTo(screenId);
}
