// ============================================================
// KIT — Interactive inputs (port of window._mui)
// ------------------------------------------------------------
// TInput · TPassword · TSelect · TSwitch · TCheckbox · Segmented
// · SearchInput. Real controlled widgets so screens behave.
// ============================================================

import 'package:flutter/material.dart';
import 'package:geniuslink_design_system/geniuslink_design_system.dart';
import '../../components/layout/m_icons.dart';
import '../../components/layout/m_widgets.dart';

class TInput extends StatefulWidget {
  final String? label;
  final String defaultValue;
  final String? placeholder;
  final bool mono;
  final bool ar;
  final bool obscure;
  final String? icon;
  final bool required;
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
  late final TextEditingController _c = TextEditingController(text: widget.defaultValue);
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _c.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.ar ? TextDirection.rtl : TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Text.rich(TextSpan(children: [
                TextSpan(text: widget.label!.toUpperCase()),
                if (widget.required) const TextSpan(text: ' *', style: TextStyle(color: M.red)),
              ], style: const TextStyle(fontFamily: M.body, fontWeight: FontWeight.w700, fontSize: 10, letterSpacing: 0.5, color: M.fg2))),
            ),
          Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: M.input,
              border: Border.all(color: _focus.hasFocus ? M.blue : M.borderStrong),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                if (widget.icon != null) ...[Icon(MIcons.of(widget.icon!), size: 16, color: M.fg3), const SizedBox(width: 10)],
                Expanded(
                  child: TextField(
                    controller: _c,
                    focusNode: _focus,
                    obscureText: widget.obscure,
                    textAlign: widget.ar ? TextAlign.right : TextAlign.left,
                    style: TextStyle(fontFamily: widget.mono ? M.mono : (widget.ar ? M.arabic : M.body), fontSize: 14, color: M.fg1),
                    cursorColor: M.blue,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText: widget.placeholder,
                      hintStyle: const TextStyle(fontFamily: M.body, fontSize: 14, color: M.fg3),
                    ),
                  ),
                ),
                if (widget.suffix != null) widget.suffix!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Searchable picker (label + the design-system **AutoSuggestionsBox**). Use
/// instead of [TSelect] when the option set is long or benefits from
/// type-to-filter, grouped sections, or a code/description second line — e.g.
/// account / currency / customer pickers. Strict-pick by default
/// (`allowFreeText: false`) so only a real option commits via [onSelected].
/// Build plain-string rows quickly with [mSuggestions].
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
  late final AutoSuggestionsBoxController<String> _box = AutoSuggestionsBoxController<String>(
    source: AutoSuggestionsSource<String>.list(widget.items),
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
            child: Text.rich(TextSpan(children: [
              TextSpan(text: widget.label!.toUpperCase()),
              if (widget.required) const TextSpan(text: ' *', style: TextStyle(color: M.red)),
            ], style: const TextStyle(fontFamily: M.body, fontWeight: FontWeight.w700, fontSize: 10, letterSpacing: 0.5, color: M.fg2))),
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
List<AutoSuggestion<String>> mSuggestions(List<String> options, {String? group}) =>
    [for (final o in options) AutoSuggestion<String>(value: o, label: o, group: group)];

class TPassword extends StatefulWidget {
  final String? label;
  final String placeholder;
  final bool required;
  const TPassword({super.key, this.label, this.placeholder = 'Minimum 10 characters', this.required = false});

  @override
  State<TPassword> createState() => _TPasswordState();
}

class _TPasswordState extends State<TPassword> {
  bool _show = false;
  @override
  Widget build(BuildContext context) {
    return TInput(
      label: widget.label,
      placeholder: widget.placeholder,
      required: widget.required,
      obscure: !_show,
      suffix: GestureDetector(
        onTap: () => setState(() => _show = !_show),
        child: Text(_show ? 'HIDE' : 'SHOW',
            style: const TextStyle(fontFamily: M.body, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: M.fg3)),
      ),
    );
  }
}

class TSelect extends StatefulWidget {
  final String? label;
  final String? value;
  final List<String> options;
  final bool required;
  const TSelect({super.key, this.label, this.value, required this.options, this.required = false});

  @override
  State<TSelect> createState() => _TSelectState();
}

class _TSelectState extends State<TSelect> {
  late String _v = widget.value ?? widget.options.first;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Text.rich(TextSpan(children: [
              TextSpan(text: widget.label!.toUpperCase()),
              if (widget.required) const TextSpan(text: ' *', style: TextStyle(color: M.red)),
            ], style: const TextStyle(fontFamily: M.body, fontWeight: FontWeight.w700, fontSize: 10, letterSpacing: 0.5, color: M.fg2))),
          ),
        Container(
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(color: M.input, border: Border.all(color: M.borderStrong), borderRadius: BorderRadius.circular(8)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _v,
              isExpanded: true,
              dropdownColor: M.card2,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: M.fg3, size: 18),
              style: const TextStyle(fontFamily: M.body, fontSize: 14, color: M.fg1),
              items: [for (final o in widget.options) DropdownMenuItem(value: o, child: Text(o))],
              onChanged: (v) => setState(() => _v = v ?? _v),
            ),
          ),
        ),
      ],
    );
  }
}

class TSwitch extends StatefulWidget {
  final String label;
  final bool defaultOn;
  const TSwitch({super.key, required this.label, this.defaultOn = false});
  @override
  State<TSwitch> createState() => _TSwitchState();
}

class _TSwitchState extends State<TSwitch> {
  late bool _on = widget.defaultOn;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _on = !_on),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Eyebrow(widget.label),
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 42,
              height: 24,
              decoration: BoxDecoration(
                color: _on ? M.blue : M.input,
                border: Border.all(color: _on ? M.blue : M.borderStrong),
                borderRadius: BorderRadius.circular(999),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 150),
                alignment: _on ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 18, height: 18,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TCheckbox extends StatefulWidget {
  final String label;
  final bool defaultChecked;
  const TCheckbox({super.key, required this.label, this.defaultChecked = false});
  @override
  State<TCheckbox> createState() => _TCheckboxState();
}

class _TCheckboxState extends State<TCheckbox> {
  late bool _on = widget.defaultChecked;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _on = !_on),
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 18, height: 18, margin: const EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              color: _on ? M.blue : Colors.transparent,
              border: Border.all(color: _on ? M.blue : M.borderStrong),
              borderRadius: BorderRadius.circular(4),
            ),
            child: _on ? const Icon(Icons.check_rounded, size: 12, color: Colors.white) : null,
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(widget.label, style: const TextStyle(fontFamily: M.body, fontSize: 12.5, color: M.fg3, height: 1.5))),
        ],
      ),
    );
  }
}

class Segmented extends StatelessWidget {
  final List<String> options;
  final String value;
  final ValueChanged<String> onChange;
  const Segmented({super.key, required this.options, required this.value, required this.onChange});

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
                  style: TextStyle(fontFamily: M.body, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: on ? Colors.white : M.fg3)),
            ),
          );
        },
      ),
    );
  }
}

class SearchInput extends StatelessWidget {
  final String placeholder;
  final String value;
  final ValueChanged<String> onChange;
  const SearchInput({super.key, this.placeholder = 'Search…', required this.value, required this.onChange});

  @override
  Widget build(BuildContext context) {
    final ctrl = TextEditingController.fromValue(TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    ));
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(color: M.input, border: Border.all(color: M.borderStrong), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, size: 16, color: M.fg3),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: ctrl,
              onChanged: onChange,
              cursorColor: M.blue,
              style: const TextStyle(fontFamily: M.body, fontSize: 14, color: M.fg1),
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: placeholder,
                hintStyle: const TextStyle(fontFamily: M.body, fontSize: 14, color: M.fg3),
              ),
            ),
          ),
          if (value.isNotEmpty)
            GestureDetector(onTap: () => onChange(''), child: const Icon(Icons.close_rounded, size: 16, color: M.fg3)),
        ],
      ),
    );
  }
}
