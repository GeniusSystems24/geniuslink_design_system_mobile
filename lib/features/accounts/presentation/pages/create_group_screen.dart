// ============================================================
// VIEW — Accounts feature (ports MobileAccounts)
// list · createAccount · accountDetail · createGroup · groupDetail
// ============================================================

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});
  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  bool _force = false;
  String? _nameEnErr, _nameArErr;

  final _treeController = AutoSuggestionsBoxController<String>(
    source: SuggestionSources.strings([
      'Assets Tree (1)',
      'Liabilities Tree (2)',
      'Equity Tree (3)',
    ]),
    allowFreeText: false,
  );

  @override
  void dispose() {
    _treeController.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() => _force = true);
    if (_nameEnErr == null && _nameArErr == null) {
      // Implementation note: persist group
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Create Account Group'),
      body: MScroll([
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Group Details', subtitle: 'Name and tree association', children: [
        SuperTextFormField(
          label: 'Name English',
          placeholder: 'e.g. Current Assets',
          required: true,
          minLength: 3,
          forceError: _force,
          onValidity: (e) => _nameEnErr = e,
        ),
        SuperTextFormField(
          label: 'الاسم بالعربية',
          placeholder: 'مثال: الأصول المتداولة',
          required: true,
          minLength: 3,
          arabic: true,
          forceError: _force,
          onValidity: (e) => _nameArErr = e,
        ),
        AutoSuggestionsBox<String>(
          controller: _treeController,
          label: 'Account Tree',
          hintText: 'Select a tree…',
          required: true,
        ),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.tertiary, title: 'Additional Information', children: const [
        SuperTextFormField(
          label: 'Note',
          placeholder: 'Add any notes about this group…',
          multiline: true,
          rows: 3,
        ),
      ]),
      Row(children: [
        const Expanded(child: MBtn('Cancel', variant: MBtnVariant.secondary, full: true)),
        const SizedBox(width: 10),
        Expanded(
          child: MBtn('Create', icon: 'check', full: true, onTap: _submit),
        ),
      ]),
    ]),
    );
  }
}
