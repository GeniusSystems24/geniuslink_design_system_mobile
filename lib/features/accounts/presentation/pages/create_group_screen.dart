// ============================================================
// VIEW — Accounts feature (ports MobileAccounts)
// create group
// ============================================================

import 'package:flutter/material.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';
import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';

import '../widgets/widgets.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({
    super.key,
    this.theme = const CreateGroupScreenThemeData(),
  });

  final CreateGroupScreenThemeData theme;

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  bool _force = false;
  String? _nameEnErr;
  String? _nameArErr;

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
    final colors = SuperMaterialThemeData.of(context).colorScheme;

    return Scaffold(
      backgroundColor: widget.theme.backgroundColor ?? colors.surface,
      appBar: SuperAppBar(
        title: Text(l10n.createAccountGroup),
        actions: const [
          AppLanguageToggleButton(),
          AppThemeToggleButton(),
        ],
      ),
      body: MScroll([
        AccountsFieldSection(
          title: l10n.groupDetails,
          subtitle: l10n.nameAndTreeAssociation,
          accentColor: widget.theme.detailsAccentColor ?? colors.primary,
          theme: widget.theme.section,
          children: [
              SuperTextFormField(
                decoration: InputDecoration(
                  labelText: l10n.nameEnglish,
                  hintText: l10n.exampleCurrentAssets,
                ),
                required: true,
                minLength: 3,
                forceError: _force,
                onValidity: (error) => _nameEnErr = error,
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
                onValidity: (error) => _nameArErr = error,
              ),
              SuperAutoSuggestionsBox<String>(
                suggestionBuilder: (items, index, item) =>
                    SuperAutoSuggestionsItem<String>(
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
        AccountsSection(
          title: l10n.additionalInformation,
          accentColor:
              widget.theme.additionalInformationAccentColor ?? colors.tertiary,
          theme: widget.theme.section,
          child: SuperTextFormField(
            decoration: InputDecoration(
              labelText: l10n.note,
              hintText: l10n.addNotesAboutGroup,
            ),
            multiline: true,
            rows: 3,
          ),
        ),
        AccountsPageActions(
          theme: widget.theme.actions,
          start: MBtn(
            l10n.cancel,
            variant: MBtnVariant.secondary,
            full: true,
          ),
          end: MBtn(
            l10n.create,
            icon: 'check',
            full: true,
            onTap: _submit,
          ),
        ),
      ]),
    );
  }
}
