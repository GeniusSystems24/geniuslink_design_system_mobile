import 'package:flutter/widgets.dart';

import '../controllers/app_controller.dart';

/// Exposes app-scoped settings controllers to widgets below MaterialApp.
class AppSettingsScope extends InheritedWidget {
  const AppSettingsScope({
    super.key,
    required this.controller,
    required super.child,
  });

  final AppController controller;

  static AppController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppSettingsScope>();
    assert(scope != null, 'No AppSettingsScope found in context.');
    return scope!.controller;
  }

  @override
  bool updateShouldNotify(AppSettingsScope oldWidget) =>
      !identical(controller, oldWidget.controller);
}
