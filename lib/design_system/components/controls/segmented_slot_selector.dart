import 'package:flutter/material.dart';

/// Configures the surface and selected/unselected states of
/// [SegmentedSlotSelector].
///
/// Example:
///
/// ```dart
/// const selectorTheme = SegmentedSlotSelectorThemeData(
///   minHeight: 40,
///   borderRadius: BorderRadius.all(Radius.circular(10)),
///   optionBorderRadius: BorderRadius.all(Radius.circular(8)),
/// );
/// ```
@immutable
class SegmentedSlotSelectorThemeData {
  const SegmentedSlotSelectorThemeData({
    this.padding = const EdgeInsets.all(3),
    this.minHeight = 38,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1,
    this.borderRadius = const BorderRadius.all(Radius.circular(9)),
    this.selectedBackgroundColor,
    this.selectedForegroundColor,
    this.unselectedForegroundColor,
    this.optionBorderRadius = const BorderRadius.all(Radius.circular(7)),
    this.duration = const Duration(milliseconds: 160),
  });

  final EdgeInsetsGeometry padding;
  final double minHeight;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final BorderRadiusGeometry borderRadius;
  final Color? selectedBackgroundColor;
  final Color? selectedForegroundColor;
  final Color? unselectedForegroundColor;
  final BorderRadiusGeometry optionBorderRadius;
  final Duration duration;

  SegmentedSlotSelectorThemeData copyWith({
    EdgeInsetsGeometry? padding,
    double? minHeight,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadiusGeometry? borderRadius,
    Color? selectedBackgroundColor,
    Color? selectedForegroundColor,
    Color? unselectedForegroundColor,
    BorderRadiusGeometry? optionBorderRadius,
    Duration? duration,
  }) {
    return SegmentedSlotSelectorThemeData(
      padding: padding ?? this.padding,
      minHeight: minHeight ?? this.minHeight,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      selectedBackgroundColor:
          selectedBackgroundColor ?? this.selectedBackgroundColor,
      selectedForegroundColor:
          selectedForegroundColor ?? this.selectedForegroundColor,
      unselectedForegroundColor:
          unselectedForegroundColor ?? this.unselectedForegroundColor,
      optionBorderRadius: optionBorderRadius ?? this.optionBorderRadius,
      duration: duration ?? this.duration,
    );
  }
}

/// Displays a segmented selector whose option content is supplied as
/// widgets.
///
/// The component owns selection layout and interaction only. Labels, icons, and
/// other option visuals remain caller-defined. Provide [semanticLabels] when the
/// visual options do not contain sufficient accessible text.
///
/// Example:
///
/// ```dart
/// SegmentedSlotSelector(
///   options: const [Text('Week'), Text('Month')],
///   selectedIndex: 0,
///   semanticLabels: const ['Week period', 'Month period'],
///   onChanged: (index) {},
/// )
/// ```
class SegmentedSlotSelector extends StatelessWidget {
  const SegmentedSlotSelector({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onChanged,
    this.semanticLabels,
    this.theme = const SegmentedSlotSelectorThemeData(),
  });

  final List<Widget> options;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final List<String>? semanticLabels;
  final SegmentedSlotSelectorThemeData theme;

  @override
  Widget build(BuildContext context) {
    if (options.isEmpty) return const SizedBox.shrink();
    final active = selectedIndex.clamp(0, options.length - 1);

    return Container(
      constraints: BoxConstraints(minHeight: theme.minHeight),
      padding: theme.padding,
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: theme.borderColor == null
            ? null
            : Border.all(
                color: theme.borderColor!,
                width: theme.borderWidth,
              ),
        borderRadius: theme.borderRadius,
      ),
      child: Row(
        children: [
          for (var index = 0; index < options.length; index++)
            Expanded(
              child: Semantics(
                button: true,
                selected: index == active,
                label: semanticLabels != null && index < semanticLabels!.length
                    ? semanticLabels![index]
                    : null,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => onChanged(index),
                    borderRadius: theme.optionBorderRadius.resolve(
                      Directionality.of(context),
                    ),
                    child: AnimatedContainer(
                      duration: theme.duration,
                      constraints: BoxConstraints(minHeight: theme.minHeight - 6),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: index == active
                            ? theme.selectedBackgroundColor
                            : Colors.transparent,
                        borderRadius: theme.optionBorderRadius,
                      ),
                      child: DefaultTextStyle.merge(
                        style: TextStyle(
                          color: index == active
                              ? theme.selectedForegroundColor
                              : theme.unselectedForegroundColor,
                        ),
                        child: IconTheme.merge(
                          data: IconThemeData(
                            color: index == active
                                ? theme.selectedForegroundColor
                                : theme.unselectedForegroundColor,
                          ),
                          child: options[index],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
