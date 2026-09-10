import 'package:flutter/material.dart';

import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';
import 'package:gl_mobile_app/design_system/kit.dart';

/// Visual configuration for [FeaturePageScaffold].
///
/// The scaffold intentionally owns only page chrome and spacing. Feature data,
/// controllers, and domain models stay outside this component.
///
/// Example:
///
/// ```dart
/// const FeaturePageScaffoldThemeData(
///   bodyPadding: 20,
/// )
/// ```
@immutable
class FeaturePageScaffoldThemeData {
  const FeaturePageScaffoldThemeData({
    this.backgroundColor,
    this.bodyPadding = 16,
  });

  final Color? backgroundColor;
  final double bodyPadding;

  FeaturePageScaffoldThemeData copyWith({
    Color? backgroundColor,
    double? bodyPadding,
  }) {
    return FeaturePageScaffoldThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      bodyPadding: bodyPadding ?? this.bodyPadding,
    );
  }
}

/// Provides the common app bar and scrollable body used by feature pages.
///
/// [title], [actions], and [children] are direct presentation inputs, so this
/// component is reusable without depending on Admin, Banking, or other feature
/// models. The default actions preserve the application's language and theme
/// controls.
///
/// Example:
///
/// ```dart
/// FeaturePageScaffold(
///   title: const Text('Details'),
///   children: const [
///     Text('Primary content'),
///   ],
/// )
/// ```
class FeaturePageScaffold extends StatelessWidget {
  const FeaturePageScaffold({
    super.key,
    required this.title,
    required this.children,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.theme = const FeaturePageScaffoldThemeData(),
  });

  final Widget title;
  final List<Widget> children;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final FeaturePageScaffoldThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          theme.backgroundColor ??
          SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(
        title: title,
        automaticallyImplyLeading: automaticallyImplyLeading,
        actions:
            actions ??
            const [
              AppLanguageToggleButton(),
              AppThemeToggleButton(),
            ],
      ),
      body: MScroll(children, pad: theme.bodyPadding),
    );
  }
}
