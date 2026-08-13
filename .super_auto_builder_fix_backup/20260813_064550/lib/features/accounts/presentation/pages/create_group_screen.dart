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
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.primary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Create Account Group')),
      body: MScroll([
        SuperSectionCard2(
          title: 'Group Details',
          subtitle: 'Name and tree association',
          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SuperTextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name English',
                  hintText: 'e.g. Current Assets',
                ),
                required: true,
                minLength: 3,
                forceError: _force,
                onValidity: (e) => _nameEnErr = e,
              ),
              SuperTextFormField(
                decoration: const InputDecoration(
                  labelText: 'الاسم بالعربية',
                  hintText: 'مثال: الأصول المتداولة',
                ),
                required: true,
                minLength: 3,
                arabic: true,
                forceError: _force,
                onValidity: (e) => _nameArErr = e,
              ),
              AutoSuggestionsBox<String>(
                suggestionBuilder: (_arg0, suggestion) => Text(suggestion),
                controller: _treeController,
                label: 'Account Tree',
                hintText: 'Select a tree…',
                required: true,
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: 'Additional Information',

          initiallyExpanded: true,
          accentColor: accentColor2,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SuperTextFormField(
                decoration: InputDecoration(
                  labelText: 'Note',
                  hintText: 'Add any notes about this group…',
                ),
                multiline: true,
                rows: 3,
              ),
            ],
          ),
        ),
        Row(
          children: [
            const Expanded(
              child: MBtn('Cancel', variant: MBtnVariant.secondary, full: true),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: MBtn('Create', icon: 'check', full: true, onTap: _submit),
            ),
          ],
        ),
      ]),
    );
  }
}
