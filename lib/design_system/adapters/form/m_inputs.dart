// ============================================================
// ADAPTERS — Interactive inputs  →  design_system/adapters/form/
// ------------------------------------------------------------
// TInput · TPassword · TSelect · TSwitch · TCheckbox  →  backed by
// super_form_field. MSuggest · mSuggestions  →  backed by
// super_auto_suggestion_box (the AutoSuggestionsBox). Segmented · SearchInput
// stay hand-rolled (compact filter / plain search — not form fields).
//
// File placement:  lib/design_system/adapters/form/m_inputs.dart
// ============================================================

import 'package:flutter/material.dart';
import 'package:super_auto_suggestion_box/super_auto_suggestion_box.dart';
import 'package:super_form_field/super_form_field.dart';
import '../../tokens/m_colors.dart';
import '../../components/layout/m_icons.dart';

// Surface the package suggestion API so screens reach AutoSuggestion /
// AutoSuggestionsBox through the kit barrel — no direct monolith import.
export 'package:super_auto_suggestion_box/super_auto_suggestion_box.dart'
    show
        AutoSuggestion,
        AutoSuggestionsBox,
        AutoSuggestionsBoxController,
        SuggestionSources,
        AutoSuggestionMatch;

/// Single-line text input. `obscure` → password type; `ar` mirrors the field.
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
  SuperTextFieldController? _c;
  @override
  void initState() {
    super.initState();
    if (widget.defaultValue.isNotEmpty)
      _c = SuperTextFieldController(initialValue: widget.defaultValue);
  }

  @override
  void dispose() {
    _c?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final field = SuperTextFormField(
      controller: _c,
      label: widget.label,
      placeholder: widget.placeholder,
      required: widget.required,
      type: widget.obscure ? SuperTextType.password : SuperTextType.text,
    );
    return widget.ar
        ? Directionality(textDirection: TextDirection.rtl, child: field)
        : field;
  }
}

/// Password input — the package field owns its own show/hide toggle.
class TPassword extends StatelessWidget {
  final String? label;
  final String placeholder;
  final bool required;
  const TPassword(
      {super.key,
      this.label,
      this.placeholder = 'Minimum 10 characters',
      this.required = false});
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
  const TSelect(
      {super.key,
      this.label,
      this.value,
      required this.options,
      this.required = false});
  @override
  Widget build(BuildContext context) => SuperSelectFormField<String>(
        label: label,
        required: required,
        initialValue: value,
        searchable: options.length > 8,
        options: [
          for (final o in options) SuperOption<String>(value: o, label: o)
        ],
      );
}

/// Boolean toggle row.
class TSwitch extends StatelessWidget {
  final String label;
  final bool defaultOn;
  const TSwitch({super.key, required this.label, this.defaultOn = false});
  @override
  Widget build(BuildContext context) =>
      SuperBoolFormField(label: label, initialValue: defaultOn);
}

/// Statement checkbox (acknowledgement style).
class TCheckbox extends StatelessWidget {
  final String label;
  final bool defaultChecked;
  const TCheckbox(
      {super.key, required this.label, this.defaultChecked = false});
  @override
  Widget build(BuildContext context) => SuperBoolFormField(
        style: SuperBoolStyle.checkbox,
        title: label,
        initialValue: defaultChecked,
      );
}

/// Searchable strict-pick picker (label + the **AutoSuggestionsBox** from
/// super_auto_suggestion_box).
/// Use instead of [TSelect] when the option set is long or benefits from
/// type-to-filter, grouped sections, or a code/description second line.
class MSuggest extends StatefulWidget {
  final String? label;
  final List<AutoSuggestion<String>> items;
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
  late final AutoSuggestionsBoxController<String> _box =
      AutoSuggestionsBoxController<String>(
    source: SuggestionSources.list<String>(widget.items),
    initialText: widget.value,
    allowFreeText: widget.allowFreeText,
  );

  @override
  void dispose() {
    _box.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Text.rich(TextSpan(
                children: [
                  TextSpan(text: widget.label!.toUpperCase()),
                  if (widget.required)
                    const TextSpan(text: ' *', style: TextStyle(color: M.red)),
                ],
                style: const TextStyle(
                    fontFamily: M.body,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    letterSpacing: 0.5,
                    color: M.fg2))),
          ),
        AutoSuggestionsBox<String>(
          controller: _box,
          hintText: widget.placeholder,
          fieldHeight: 46,
          leading: Icon(MIcons.of(widget.icon), size: 16, color: M.fg3),
          highlightMatch: AutoSuggestionMatch.contains,
          onSelected: (s) => widget.onSelected?.call(s.value),
        ),
      ],
    );
  }
}

/// Convenience: map plain strings to `AutoSuggestion<String>` rows whose value
/// and label are the same string (optionally under a shared [group] header).
List<AutoSuggestion<String>> mSuggestions(List<String> options,
        {String? group}) =>
    [
      for (final o in options)
        AutoSuggestion<String>(value: o, label: o, group: group)
    ];

/// Compact horizontal segmented filter (not a form field — stays hand-rolled).
class Segmented extends StatelessWidget {
  final List<String> options;
  final String value;
  final ValueChanged<String> onChange;
  const Segmented(
      {super.key,
      required this.options,
      required this.value,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final o = options[i];
          final on = o == value;
          return GestureDetector(
            onTap: () => onChange(o),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: on ? M.blue : M.input,
                border: Border.all(color: on ? M.blue : M.border),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(o.toUpperCase(),
                  style: TextStyle(
                      fontFamily: M.body,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                      color: on ? Colors.white : M.fg3)),
            ),
          );
        },
      ),
    );
  }
}

/// Search box (not a form field — stays hand-rolled).
class SearchInput extends StatelessWidget {
  final String placeholder;
  final String value;
  final ValueChanged<String> onChange;
  const SearchInput(
      {super.key,
      this.placeholder = 'Search…',
      required this.value,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    final ctrl = TextEditingController.fromValue(TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    ));
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
          color: M.input,
          border: Border.all(color: M.borderStrong),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, size: 16, color: M.fg3),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: ctrl,
              onChanged: onChange,
              cursorColor: M.blue,
              style: const TextStyle(
                  fontFamily: M.body, fontSize: 14, color: M.fg1),
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: placeholder,
                hintStyle: const TextStyle(
                    fontFamily: M.body, fontSize: 14, color: M.fg3),
              ),
            ),
          ),
          if (value.isNotEmpty)
            GestureDetector(
                onTap: () => onChange(''),
                child: const Icon(Icons.close_rounded, size: 16, color: M.fg3)),
        ],
      ),
    );
  }
}
