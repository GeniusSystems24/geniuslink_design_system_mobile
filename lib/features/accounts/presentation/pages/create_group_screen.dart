// ============================================================
// VIEW — Accounts feature (ports MobileAccounts)
// list · createAccount · accountDetail · createGroup · groupDetail
// ============================================================

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});
  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  bool _force = false;
  String? _nameEnErr, _nameArErr;

  final _treeSource = SuperAutoSuggestionSources.strings([
      'Assets Tree (1)',
      'Liabilities Tree (2)',
      'Equity Tree (3)',
    ]);
  final _treeController = SuperAutoSuggestionsController<String>(
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
    final l10n = GeniusLinkLocalization.of(context);

    var accentColor = SuperMaterialThemeData.of(context).colorScheme.primary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: Text(l10n.createAccountGroup), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
      body: MScroll([
        SuperSectionCard2(
          title: l10n.groupDetails,
          subtitle: l10n.nameAndTreeAssociation,
          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SuperTextFormField(
                decoration: InputDecoration(
                  labelText: l10n.nameEnglish,
                  hintText: l10n.exampleCurrentAssets,
                ),
                required: true,
                minLength: 3,
                forceError: _force,
                onValidity: (e) => _nameEnErr = e,
              ),
              SuperTextFormField(
                decoration: InputDecoration(
                  labelText: l10n.nameArabic,
                  hintText: l10n.exampleCurrentAssets,
                ),
                required: true,
                minLength: 3,
                arabic: true,
                forceError: _force,
                onValidity: (e) => _nameArErr = e,
              ),
              SuperAutoSuggestionsBox<String>(
                suggestionBuilder: (items, index, item) => SuperAutoSuggestionsItem<String>(
                  value: item,
                  titleText: item,
                ),
                source: _treeSource,
                controller: _treeController,
                decoration: InputDecoration(labelText: l10n.accountTree),
                hintText: l10n.selectTree,
                required: true,
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: l10n.additionalInformation,

          initiallyExpanded: true,
          accentColor: accentColor2,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SuperTextFormField(
                decoration: InputDecoration(
                  labelText: l10n.note,
                  hintText: l10n.addNotesAboutGroup,
                ),
                multiline: true,
                rows: 3,
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: MBtn(l10n.cancel, variant: MBtnVariant.secondary, full: true),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: MBtn(l10n.create, icon: 'check', full: true, onTap: _submit),
            ),
          ],
        ),
      ]),
    );
  }
}
