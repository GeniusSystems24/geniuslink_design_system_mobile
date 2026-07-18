// ============================================================
// ADAPTERS — Application inputs on the shared Super foundation
// ------------------------------------------------------------
// Standard form controls use super_form_field. Searchable typeahead/combobox
// controls use super_auto_suggestion_box. Both inherit the super_core theme.
// ============================================================

import 'package:flutter/material.dart';
import 'package:super_auto_suggestion_box/super_auto_suggestion_box.dart'
    as suggest;
import 'package:super_form_field/super_form_field.dart';

import '../../components/layout/m_icons.dart';

export 'package:super_auto_suggestion_box/super_auto_suggestion_box.dart'
    show
        AutoSuggestion,
        AutoSuggestionsBox,
        AutoSuggestionsBoxController,
        SuggestionSources,
        AutoSuggestionMatch;

export 'package:super_form_field/super_form_field.dart'
    show
        FieldDensity,
        SuperBoolFieldController,
        SuperBoolFormField,
        SuperBoolStyle,
        SuperChoiceFieldController,
        SuperChoiceFormField,
        SuperChoiceStyle,
        SuperDateFieldController,
        SuperDateFormField,
        SuperMultiSelectFieldController,
        SuperMultiSelectFormField,
        SuperNumericFieldController,
        SuperNumericFormField,
        SuperOption,
        SuperSelectFieldController,
        SuperSelectFormField,
        SuperTextFieldController,
        SuperTextFormField,
        SuperTextType;

/// Single-line text input. `obscure` selects the password field type and `ar`
/// enables the package's Arabic alignment/font behavior.
class TInput extends StatefulWidget {
  final String? label;
  final String defaultValue;
  final String? placeholder;
  final bool mono, ar, obscure, required;
  final String? icon;
  final Widget? suffix;

  const TInput({
    super.key,
    this.label,
    this.defaultValue = '',
    this.placeholder,
    this.mono = false,
    this.ar = false,
    this.obscure = false,
    this.icon,
    this.required = false,
    this.suffix,
  });

  @override
  State<TInput> createState() => _TInputState();
}

class _TInputState extends State<TInput> {
  late final SuperTextFieldController _controller =
      SuperTextFieldController(initialValue: widget.defaultValue);

  @override
  void didUpdateWidget(TInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.defaultValue != widget.defaultValue &&
        _controller.value != widget.defaultValue) {
      _controller.setValue(widget.defaultValue);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SuperTextFormField(
        controller: _controller,
        label: widget.label,
        placeholder: widget.placeholder,
        required: widget.required,
        arabic: widget.ar,
        leadingIcon: widget.icon == null ? null : MIcons.of(widget.icon!),
        type: widget.obscure ? SuperTextType.password : SuperTextType.text,
      );
}

/// Password input — the package field owns its show/hide affordance.
class TPassword extends StatelessWidget {
  final String? label;
  final String placeholder;
  final bool required;

  const TPassword({
    super.key,
    this.label,
    this.placeholder = 'Minimum 10 characters',
    this.required = false,
  });

  @override
  Widget build(BuildContext context) => SuperTextFormField(
        label: label,
        placeholder: placeholder,
        required: required,
        type: SuperTextType.password,
      );
}

/// Single-select dropdown over a plain string list.
class TSelect extends StatelessWidget {
  final String? label;
  final String? value;
  final List<String> options;
  final bool required;

  const TSelect({
    super.key,
    this.label,
    this.value,
    required this.options,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) => SuperSelectFormField<String>(
        label: label,
        required: required,
        initialValue: value,
        searchable: options.length > 8,
        options: [
          for (final option in options)
            SuperOption<String>(value: option, label: option),
        ],
      );
}

/// Boolean toggle row.
class TSwitch extends StatelessWidget {
  final String label;
  final bool defaultOn;

  const TSwitch({super.key, required this.label, this.defaultOn = false});

  @override
  Widget build(BuildContext context) => SuperBoolFormField(
        title: label,
        initialValue: defaultOn,
      );
}

/// Statement checkbox (acknowledgement style).
class TCheckbox extends StatelessWidget {
  final String label;
  final bool defaultChecked;

  const TCheckbox({
    super.key,
    required this.label,
    this.defaultChecked = false,
  });

  @override
  Widget build(BuildContext context) => SuperBoolFormField(
        style: SuperBoolStyle.checkbox,
        title: label,
        initialValue: defaultChecked,
      );
}

/// Searchable typeahead/combobox backed by `super_auto_suggestion_box`.
/// Use this for long, grouped or remotely sourced option sets. Standard short
/// dropdowns continue to use [TSelect]/`SuperSelectFormField`.
class MSuggest extends StatefulWidget {
  final String? label;
  final List<suggest.AutoSuggestion<String>> items;
  final String? value;
  final String? placeholder;
  final bool required;
  final bool allowFreeText;
  final String icon;
  final ValueChanged<String>? onSelected;

  const MSuggest({
    super.key,
    this.label,
    required this.items,
    this.value,
    this.placeholder,
    this.required = false,
    this.allowFreeText = false,
    this.icon = 'search',
    this.onSelected,
  });

  @override
  State<MSuggest> createState() => _MSuggestState();
}

class _MSuggestState extends State<MSuggest> {
  late final suggest.AutoSuggestionsBoxController<String> _controller =
      _buildController();

  suggest.AutoSuggestion<String>? _itemForValue(String? value) {
    if (value == null) return null;
    for (final item in widget.items) {
      if (item.value == value) return item;
    }
    return null;
  }

  suggest.AutoSuggestionsBoxController<String> _buildController() {
    final initial = _itemForValue(widget.value);
    return suggest.AutoSuggestionsBoxController<String>(
      source: suggest.SuggestionSources.list<String>(widget.items),
      initialValue: initial,
      initialText: initial == null ? widget.value : null,
      allowFreeText: widget.allowFreeText,
    );
  }

  bool _sameItems(
    List<suggest.AutoSuggestion<String>> a,
    List<suggest.AutoSuggestion<String>> b,
  ) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i].value != b[i].value ||
          a[i].label != b[i].label ||
          a[i].group != b[i].group) {
        return false;
      }
    }
    return true;
  }

  @override
  void didUpdateWidget(MSuggest oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_sameItems(oldWidget.items, widget.items)) {
      _controller.source =
          suggest.SuggestionSources.list<String>(widget.items);
    }
    if (oldWidget.allowFreeText != widget.allowFreeText) {
      _controller.allowFreeText = widget.allowFreeText;
    }
    if (oldWidget.value != widget.value) {
      final item = _itemForValue(widget.value);
      if (item != null) {
        _controller.select(item);
      } else if (widget.value == null || widget.value!.isEmpty) {
        _controller.clear();
      } else {
        _controller.setText(widget.value!);
        if (widget.allowFreeText) _controller.acceptFreeText();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => suggest.AutoSuggestionsBox<String>(
        controller: _controller,
        label: widget.label,
        hintText: widget.placeholder,
        required: widget.required,
        fieldHeight: 46,
        leading: Icon(
          MIcons.of(widget.icon),
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        highlightMatch: suggest.AutoSuggestionMatch.contains,
        onSelected: (item) => widget.onSelected?.call(item.value),
      );
}

/// Convenience mapping from strings to autocomplete rows.
List<suggest.AutoSuggestion<String>> mSuggestions(
  List<String> options, {
  String? group,
}) =>
    [
      for (final option in options)
        suggest.AutoSuggestion<String>(
          value: option,
          label: option,
          group: group,
        ),
    ];

/// Compact fixed-set filter backed by `SuperChoiceFormField`.
class Segmented extends StatefulWidget {
  final List<String> options;
  final String value;
  final ValueChanged<String> onChange;

  const Segmented({
    super.key,
    required this.options,
    required this.value,
    required this.onChange,
  });

  @override
  State<Segmented> createState() => _SegmentedState();
}

class _SegmentedState extends State<Segmented> {
  late final SuperChoiceFieldController<String> _controller =
      SuperChoiceFieldController<String>(initialValue: [widget.value]);

  @override
  void didUpdateWidget(Segmented oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value &&
        _controller.single != widget.value) {
      _controller.setSingle(widget.value);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SuperChoiceFormField<String>(
        controller: _controller,
        options: [
          for (final option in widget.options)
            SuperOption<String>(value: option, label: option),
        ],
        onChanged: (values) {
          if (values.isNotEmpty && values.first != widget.value) {
            widget.onChange(values.first);
          }
        },
      );
}

/// Search field backed by `SuperTextFormField` and synchronized with the
/// externally-owned query value.
class SearchInput extends StatefulWidget {
  final String placeholder;
  final String value;
  final ValueChanged<String> onChange;

  const SearchInput({
    super.key,
    this.placeholder = 'Search…',
    required this.value,
    required this.onChange,
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  late final SuperTextFieldController _controller =
      SuperTextFieldController(initialValue: widget.value);

  @override
  void didUpdateWidget(SearchInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value &&
        _controller.value != widget.value) {
      _controller.setValue(widget.value);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SuperTextFormField(
        controller: _controller,
        placeholder: widget.placeholder,
        leadingIcon: Icons.search_rounded,
        clearable: true,
        onChanged: widget.onChange,
      );
}
