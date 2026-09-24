import 'package:flutter/material.dart';

import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';
import 'package:gl_mobile_app/design_system/kit.dart';

/// Visual configuration for [AuthPageScaffold].
///
/// Example:
///
/// ```dart
/// const AuthPageScaffoldThemeData(
///   padding: EdgeInsets.fromLTRB(24, 40, 24, 32),
/// )
/// ```
@immutable
class AuthPageScaffoldThemeData {
  const AuthPageScaffoldThemeData({
    this.backgroundColor,
    this.padding = const EdgeInsets.fromLTRB(28, 44, 28, 40),
  });

  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;

  AuthPageScaffoldThemeData copyWith({
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
  }) {
    return AuthPageScaffoldThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      padding: padding ?? this.padding,
    );
  }
}

/// Common adaptive shell for authentication views.
///
/// The component receives its [title] and body [children] directly as widgets
/// and has no dependency on authentication models or controllers.
///
/// Example:
///
/// ```dart
/// AuthPageScaffold(
///   title: const Text('Sign in'),
///   children: const [
///     Text('Authentication form'),
///   ],
/// )
/// ```
class AuthPageScaffold extends StatelessWidget {
  const AuthPageScaffold({
    super.key,
    required this.title,
    required this.children,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.theme = const AuthPageScaffoldThemeData(),
  });

  final Widget title;
  final List<Widget> children;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final AuthPageScaffoldThemeData theme;

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
            const [AppLanguageToggleButton(), AppThemeToggleButton()],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Keep content readable on wide windows instead of stretching
            // fields across the entire available width.
            final maxWidth = constraints.maxWidth >= 720
                ? 560.0
                : double.infinity;
            return SingleChildScrollView(
              padding: theme.padding,
              child: Align(
                alignment: AlignmentDirectional.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: children,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Visual configuration for [AuthBrand].
///
/// Example:
///
/// ```dart
/// const AuthBrandThemeData(
///   markSize: 32,
///   gap: 12,
/// )
/// ```
@immutable
class AuthBrandThemeData {
  const AuthBrandThemeData({
    this.markSize = 28,
    this.gap = 10,
    this.markRadius = 7,
    this.markColor,
    this.markTextStyle,
    this.labelTextStyle,
  });

  final double markSize;
  final double gap;
  final double markRadius;
  final Color? markColor;
  final TextStyle? markTextStyle;
  final TextStyle? labelTextStyle;

  AuthBrandThemeData copyWith({
    double? markSize,
    double? gap,
    double? markRadius,
    Color? markColor,
    TextStyle? markTextStyle,
    TextStyle? labelTextStyle,
  }) {
    return AuthBrandThemeData(
      markSize: markSize ?? this.markSize,
      gap: gap ?? this.gap,
      markRadius: markRadius ?? this.markRadius,
      markColor: markColor ?? this.markColor,
      markTextStyle: markTextStyle ?? this.markTextStyle,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    );
  }
}

/// Displays the authentication brand using directional visual slots.
///
/// Supply [start] or [end] to replace either visual region. When omitted, the
/// component renders the current GeniusLink mark and label. Using `start` and
/// `end` keeps the layout naturally compatible with both LTR and RTL.
///
/// Example:
///
/// ```dart
/// const AuthBrand(
///   end: Text('GeniusLink'),
/// )
/// ```
class AuthBrand extends StatelessWidget {
  const AuthBrand({
    super.key,
    this.start,
    this.end,
    this.theme = const AuthBrandThemeData(),
  });

  final Widget? start;
  final Widget? end;
  final AuthBrandThemeData theme;

  @override
  Widget build(BuildContext context) {
    final material = SuperMaterialThemeData.of(context);
    final defaultMark = Container(
      width: theme.markSize,
      height: theme.markSize,
      decoration: BoxDecoration(
        color: theme.markColor ?? material.colorScheme.primary,
        borderRadius: BorderRadius.circular(theme.markRadius),
      ),
      alignment: Alignment.center,
      child: Text(
        'G',
        style:
            theme.markTextStyle ??
            TextStyle(
              fontFamily: material.textTheme.headlineMedium?.fontFamily,
              fontWeight: FontWeight.w800,
              fontSize: 17,
              color: Colors.white,
            ),
      ),
    );
    final defaultLabel = Text(
      'GeniusLink',
      style:
          theme.labelTextStyle ??
          TextStyle(
            fontFamily: material.textTheme.headlineMedium?.fontFamily,
            fontWeight: FontWeight.w800,
            fontSize: 20,
            color: material.superTheme.fg1,
            letterSpacing: -0.2,
          ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        start ?? defaultMark,
        SizedBox(width: theme.gap),
        end ?? defaultLabel,
      ],
    );
  }
}

/// Visual configuration for [AuthEyebrow].
///
/// Example:
///
/// ```dart
/// const AuthEyebrowThemeData(letterSpacing: 1.2)
/// ```
@immutable
class AuthEyebrowThemeData {
  const AuthEyebrowThemeData({
    this.textStyle,
    this.color,
    this.letterSpacing = 1.6,
  });

  final TextStyle? textStyle;
  final Color? color;
  final double letterSpacing;

  AuthEyebrowThemeData copyWith({
    TextStyle? textStyle,
    Color? color,
    double? letterSpacing,
  }) {
    return AuthEyebrowThemeData(
      textStyle: textStyle ?? this.textStyle,
      color: color ?? this.color,
      letterSpacing: letterSpacing ?? this.letterSpacing,
    );
  }
}

/// Applies the standard authentication eyebrow style to [child].
///
/// The content itself is supplied as a widget. This keeps the component purely
/// presentational and lets callers localize or replace the text freely.
///
/// Example:
///
/// ```dart
/// const AuthEyebrow(
///   child: Text('SIGN IN'),
/// )
/// ```
class AuthEyebrow extends StatelessWidget {
  const AuthEyebrow({
    super.key,
    required this.child,
    this.theme = const AuthEyebrowThemeData(),
  });

  final Widget child;
  final AuthEyebrowThemeData theme;

  @override
  Widget build(BuildContext context) {
    final material = SuperMaterialThemeData.of(context);
    final style =
        theme.textStyle ??
        TextStyle(
          fontFamily: material.textTheme.bodyMedium?.fontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 11,
          letterSpacing: theme.letterSpacing,
          color: theme.color ?? material.colorScheme.primary,
        );

    return DefaultTextStyle(style: style, child: child);
  }
}
