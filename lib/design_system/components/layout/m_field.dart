// M_WIDGETS_SPLIT_V1
// Extracted from m_widgets.dart so this widget has one clear source file.
// LAYOUT_WIDGET_DOCS_V1
import 'package:flutter/material.dart';
import 'package:super_form_field/super_form_field.dart';

/// Displays a compact read-only form field.
///
/// [MField] is a presentation wrapper around [SuperTextFormField]. It is useful
/// for detail and review screens that should keep form-field visual language
/// without allowing the value to be edited.
///
/// Example:
///
/// ```dart
/// const MField(
///   label: 'Account code',
///   value: '1001',
///   required: true,
/// )
/// ```
class MField extends StatelessWidget {
  /// Label displayed by the underlying form field.
  final String label;

  /// Optional hint shown when [value] is empty.
  final String? placeholder;

  /// Optional value displayed in the read-only field.
  ///
  /// A null value is rendered as an empty string.
  final String? value;

  /// Whether the field content should use Arabic text handling.
  final bool ar;

  /// Whether the value is conceptually monospaced.
  ///
  /// This property is retained for API compatibility. The current
  /// implementation delegates visual text rendering to [SuperTextFormField].
  final bool mono;

  /// Whether the field should be presented as required.
  final bool required;

  /// Creates a compact read-only field.
  const MField({
    super.key,
    required this.label,
    this.placeholder,
    this.value,
    this.ar = false,
    this.mono = false,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    // Delegate field styling and read-only behavior to SuperTextFormField
    // instead of duplicating form-field presentation locally.
    return SuperTextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: placeholder,
      ),
      initialValue: value ?? '',
      required: required,
      arabic: ar,
      readOnly: true,
    );
  }
}
