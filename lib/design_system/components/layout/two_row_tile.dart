// TWO_ROW_TILE_FUNCTIONAL_API_V2
// TWO_ROW_TILE_THEME_EXTENSION_V1
// TWO_ROW_TILE_THEME_STATIC_HELPERS_V1
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Configures the layout and surface of [TwoRowTile].
///
/// This theme only controls presentation. The tile's visual content is supplied
/// as widgets through [TwoRowTile.leading], [TwoRowTile.title],
/// [TwoRowTile.subtitle], [TwoRowTile.trailing], and
/// [TwoRowTile.subtitleTrailing].
///
/// `TwoRowTileThemeData` is a [ThemeExtension], so applications can register it
/// in [ThemeData.extensions] and interpolate it automatically during animated
/// theme changes.
///
/// Use [TwoRowTileThemeData.mayOf] when the extension is optional, or
/// [TwoRowTileThemeData.of] when a guaranteed effective theme is needed.
/// [TwoRowTileThemeData.light] and [TwoRowTileThemeData.dark] provide reusable
/// brightness-specific defaults.
///
/// Registering the extension does not change [TwoRowTile]'s current local
/// `theme` argument behavior; callers can retrieve the extension with
/// `Theme.of(context).extension<TwoRowTileThemeData>()` and pass it explicitly
/// when a globally configured value is desired.
///
/// Example:
///
/// ```dart
/// const tileTheme = TwoRowTileThemeData(
///   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
///   rowGap: 6,
///   columnGap: 12,
///   leadingGap: 12,
///   minHeight: 64,
///   borderRadius: BorderRadius.all(Radius.circular(12)),
/// );
///
/// final theme = ThemeData(
///   extensions: const <ThemeExtension<dynamic>>[
///     tileTheme,
///   ],
/// );
///
/// // Later, inside build():
/// final effectiveTileTheme = TwoRowTileThemeData.of(context);
/// ```
///
/// The static brightness presets can also be used directly:
///
/// ```dart
/// final lightTileTheme = TwoRowTileThemeData.light();
/// final darkTileTheme = TwoRowTileThemeData.dark();
/// ```
@immutable
class TwoRowTileThemeData extends ThemeExtension<TwoRowTileThemeData> {
  /// Creates layout and surface configuration for [TwoRowTile].
  const TwoRowTileThemeData({
    this.padding = const EdgeInsets.symmetric(vertical: 12),
    this.rowGap = 4,
    this.columnGap = 12,
    this.leadingGap = 12,
    this.minHeight,
    this.backgroundColor,
    this.borderColor,
    this.dividerColor,
    this.borderRadius = BorderRadius.zero,
  });

  /// Returns the nearest registered [TwoRowTileThemeData], if one exists.
  ///
  /// This reads the extension from [ThemeData.extensions] without creating a
  /// fallback value.
  ///
  /// Example:
  ///
  /// ```dart
  /// final tileTheme = TwoRowTileThemeData.mayOf(context);
  /// if (tileTheme != null) {
  ///   // Use the explicitly registered extension.
  /// }
  /// ```
  static TwoRowTileThemeData? mayOf(BuildContext context) {
    return Theme.of(context).extension<TwoRowTileThemeData>();
  }

  /// Returns the effective [TwoRowTileThemeData] for [context].
  ///
  /// If a [TwoRowTileThemeData] is registered in [ThemeData.extensions], that
  /// value is returned. Otherwise a fallback is created from the active
  /// [ThemeData.colorScheme] using [light] or [dark], according to the current
  /// theme brightness.
  ///
  /// Example:
  ///
  /// ```dart
  /// final tileTheme = TwoRowTileThemeData.of(context);
  ///
  /// TwoRowTile(
  ///   title: const Text('Main account'),
  ///   subtitle: const Text('1001'),
  ///   theme: tileTheme,
  /// )
  /// ```
  static TwoRowTileThemeData of(BuildContext context) {
    final registered = mayOf(context);
    if (registered != null) {
      return registered;
    }

    final materialTheme = Theme.of(context);
    return materialTheme.brightness == Brightness.dark
        ? dark(colorScheme: materialTheme.colorScheme)
        : light(colorScheme: materialTheme.colorScheme);
  }

  /// Creates the default light [TwoRowTileThemeData].
  ///
  /// When [colorScheme] is omitted, Flutter's default light [ColorScheme] is
  /// used. Passing the application's color scheme keeps the tile surface and
  /// separators aligned with the active design system.
  ///
  /// Example:
  ///
  /// ```dart
  /// final tileTheme = TwoRowTileThemeData.light(
  ///   colorScheme: Theme.of(context).colorScheme,
  /// );
  /// ```
  static TwoRowTileThemeData light({
    ColorScheme colorScheme = const ColorScheme.light(),
  }) {
    return TwoRowTileThemeData(
      backgroundColor: colorScheme.surface,
      borderColor: colorScheme.outlineVariant,
      dividerColor: colorScheme.outlineVariant,
    );
  }

  /// Creates the default dark [TwoRowTileThemeData].
  ///
  /// When [colorScheme] is omitted, Flutter's default dark [ColorScheme] is
  /// used. Passing the application's color scheme keeps the tile surface and
  /// separators aligned with the active design system.
  ///
  /// Example:
  ///
  /// ```dart
  /// final tileTheme = TwoRowTileThemeData.dark(
  ///   colorScheme: Theme.of(context).colorScheme,
  /// );
  /// ```
  static TwoRowTileThemeData dark({
    ColorScheme colorScheme = const ColorScheme.dark(),
  }) {
    return TwoRowTileThemeData(
      backgroundColor: colorScheme.surface,
      borderColor: colorScheme.outlineVariant,
      dividerColor: colorScheme.outlineVariant,
    );
  }

  /// Insets applied around the tile content.
  final EdgeInsetsGeometry padding;

  /// Vertical space between the title and subtitle rows.
  final double rowGap;

  /// Horizontal space between start and trailing content within each row.
  final double columnGap;

  /// Horizontal space between [TwoRowTile.leading] and the two-row content.
  final double leadingGap;

  /// Optional minimum height of the complete tile surface.
  final double? minHeight;

  /// Optional background color painted behind the tile content.
  final Color? backgroundColor;

  /// Optional color for a border around the complete tile.
  ///
  /// When this value is set, the full border takes precedence over the optional
  /// bottom divider configured by [dividerColor].
  final Color? borderColor;

  /// Optional color used by the bottom divider when
  /// [TwoRowTile.showBottomDivider] is `true`.
  final Color? dividerColor;

  /// Radius applied to the tile surface and its interactive ink response.
  final BorderRadiusGeometry borderRadius;

  /// Returns a copy with the supplied presentation values replaced.
  @override
  TwoRowTileThemeData copyWith({
    EdgeInsetsGeometry? padding,
    double? rowGap,
    double? columnGap,
    double? leadingGap,
    double? minHeight,
    Color? backgroundColor,
    Color? borderColor,
    Color? dividerColor,
    BorderRadiusGeometry? borderRadius,
  }) {
    return TwoRowTileThemeData(
      padding: padding ?? this.padding,
      rowGap: rowGap ?? this.rowGap,
      columnGap: columnGap ?? this.columnGap,
      leadingGap: leadingGap ?? this.leadingGap,
      minHeight: minHeight ?? this.minHeight,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      dividerColor: dividerColor ?? this.dividerColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  /// Linearly interpolates between this theme and [other].
  ///
  /// Flutter calls this method while animating between [ThemeData] instances,
  /// for example when switching between light and dark themes.
  @override
  TwoRowTileThemeData lerp(
    covariant TwoRowTileThemeData? other,
    double t,
  ) {
    if (other == null) {
      return this;
    }

    if (identical(this, other)) {
      return this;
    }

    return TwoRowTileThemeData(
      // Geometry values use Flutter's interpolation helpers so directional
      // EdgeInsets and BorderRadius values keep their RTL-aware semantics.
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      rowGap: ui.lerpDouble(rowGap, other.rowGap, t)!,
      columnGap: ui.lerpDouble(columnGap, other.columnGap, t)!,
      leadingGap: ui.lerpDouble(leadingGap, other.leadingGap, t)!,
      minHeight: ui.lerpDouble(minHeight, other.minHeight, t),
      backgroundColor: Color.lerp(
        backgroundColor,
        other.backgroundColor,
        t,
      ),
      borderColor: Color.lerp(
        borderColor,
        other.borderColor,
        t,
      ),
      dividerColor: Color.lerp(
        dividerColor,
        other.dividerColor,
        t,
      ),
      borderRadius: BorderRadiusGeometry.lerp(
        borderRadius,
        other.borderRadius,
        t,
      )!,
    );
  }
}

/// Displays a compact two-row tile using functional content slots.
///
/// The API follows familiar list-item terminology:
///
/// - [leading] is optional content before the text/content column.
/// - [title] is the primary start-aligned content.
/// - [trailing] is content opposite [title].
/// - [subtitle] is the secondary start-aligned content.
/// - [subtitleTrailing] is content opposite [subtitle].
///
/// All horizontal placement is directional, so start/end positions automatically
/// follow the ambient [TextDirection]. The component has no dependency on
/// feature or domain models.
///
/// Example:
///
/// ```dart
/// TwoRowTile(
///   leading: const Icon(Icons.receipt_long_outlined),
///   title: const Text('Cash deposit — Main'),
///   trailing: const Text('+SAR 120,000.00'),
///   subtitle: const Text('DEP-7741'),
///   subtitleTrailing: const Text('1h ago'),
///   onTap: () {},
/// )
/// ```
class TwoRowTile extends StatelessWidget {
  /// Creates a functional two-row tile.
  const TwoRowTile({
    super.key,
    this.leading,
    this.title,
    this.trailing,
    this.subtitle,
    this.subtitleTrailing,
    this.onTap,
    this.semanticLabel,
    this.showBottomDivider = false,
    this.theme = const TwoRowTileThemeData(),
  });

  /// Optional widget displayed before the title/subtitle content column.
  ///
  /// Typical values include an avatar, icon, thumbnail, checkbox, or status
  /// indicator. Its position follows the ambient [TextDirection].
  final Widget? leading;

  /// Primary start-aligned content for the first row.
  ///
  /// This is usually a [Text] widget, but any widget can be supplied.
  final Widget? title;

  /// Optional end-aligned content opposite [title].
  ///
  /// Typical values include an amount, badge, timestamp, or compact action.
  final Widget? trailing;

  /// Secondary start-aligned content for the second row.
  ///
  /// Use this for supporting text, references, metadata, or a custom widget.
  final Widget? subtitle;

  /// Optional end-aligned content opposite [subtitle].
  ///
  /// This slot is useful when the second row needs its own status, timestamp,
  /// balance, or other supporting trailing content.
  final Widget? subtitleTrailing;

  /// Callback invoked when the tile is tapped.
  ///
  /// When `null`, no [InkWell] is created and the tile remains non-interactive.
  final VoidCallback? onTap;

  /// Optional accessibility label for the complete tile.
  ///
  /// When [onTap] is provided, the generated semantics node is also marked as a
  /// button.
  final String? semanticLabel;

  /// Whether to draw a bottom-only divider using
  /// [TwoRowTileThemeData.dividerColor].
  ///
  /// A full [TwoRowTileThemeData.borderColor] takes precedence.
  final bool showBottomDivider;

  /// Presentation configuration for spacing, sizing, border, and surface color.
  final TwoRowTileThemeData theme;

  @override
  Widget build(BuildContext context) {
    final hasTitleRow = title != null || trailing != null;
    final hasSubtitleRow = subtitle != null || subtitleTrailing != null;

    // Keep row placement directional so the same tile works in LTR and RTL
    // without feature code having to swap its content manually.
    final contentColumn = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasTitleRow)
          _DirectionalContentRow(
            start: title,
            end: trailing,
            gap: theme.columnGap,
          ),
        if (hasTitleRow && hasSubtitleRow)
          SizedBox(height: theme.rowGap),
        if (hasSubtitleRow)
          _DirectionalContentRow(
            start: subtitle,
            end: subtitleTrailing,
            gap: theme.columnGap,
          ),
      ],
    );

    // Leading content is optional. Avoid wrapping the common no-leading case in
    // an extra Row so the tile stays lightweight and keeps previous constraints.
    final Widget layout;
    if (leading == null) {
      layout = contentColumn;
    } else {
      layout = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: leading,
          ),
          SizedBox(width: theme.leadingGap),
          Expanded(child: contentColumn),
        ],
      );
    }

    // The surface owns only layout/decoration concerns. Feature-specific text,
    // icons, badges, amounts, and colors remain caller-provided widgets.
    final content = Container(
      constraints: theme.minHeight == null
          ? null
          : BoxConstraints(minHeight: theme.minHeight!),
      padding: theme.padding,
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: theme.borderColor != null
            ? Border.all(color: theme.borderColor!)
            : showBottomDivider && theme.dividerColor != null
                ? Border(bottom: BorderSide(color: theme.dividerColor!))
                : null,
        borderRadius: theme.borderRadius,
      ),
      child: layout,
    );

    // Non-interactive tiles avoid Material/InkWell overhead while still
    // supporting an explicit semantic label.
    if (onTap == null) {
      return semanticLabel == null
          ? content
          : Semantics(label: semanticLabel, child: content);
    }

    // Resolve the directional border radius before passing it to InkWell so the
    // splash follows the same visual shape as the decorated surface.
    final interactive = Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: theme.borderRadius.resolve(Directionality.of(context)),
        onTap: onTap,
        child: content,
      ),
    );

    return semanticLabel == null
        ? interactive
        : Semantics(
            button: true,
            label: semanticLabel,
            child: interactive,
          );
  }
}

/// Places optional start and end widgets on one directional row.
///
/// This stays private because it is an implementation detail of [TwoRowTile],
/// not a feature-level API.
class _DirectionalContentRow extends StatelessWidget {
  const _DirectionalContentRow({
    required this.start,
    required this.end,
    required this.gap,
  });

  final Widget? start;
  final Widget? end;
  final double gap;

  @override
  Widget build(BuildContext context) {
    // A single child does not need Row/Flex, which also makes single-slot usage
    // safe in more parent constraint configurations.
    if (start == null) {
      return Align(
        alignment: AlignmentDirectional.centerEnd,
        child: end,
      );
    }

    if (end == null) {
      return Align(
        alignment: AlignmentDirectional.centerStart,
        child: start,
      );
    }

    // Expanded gives the primary/start slot the remaining horizontal space,
    // while Flexible allows trailing content to take only the space it needs.
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: start,
          ),
        ),
        SizedBox(width: gap),
        Flexible(
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: end,
          ),
        ),
      ],
    );
  }
}
