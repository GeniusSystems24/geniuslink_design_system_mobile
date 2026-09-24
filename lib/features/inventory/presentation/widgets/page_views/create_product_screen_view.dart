// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
// ============================================================
// VIEW — Products & Inventory operations (ports MobileInventory)
// productsList · productDetail · createProduct · issueDetail
// receiveCreate · receiveDetail · transferCreate · transferDetail · adjustment
// ============================================================

import 'package:flutter/material.dart';
import 'package:super_form_field/super_form_field.dart';
import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

/// Renders the presentation for [CreateProductScreen].
///
/// This widget contains the screen's existing layout and presentation
/// state while the corresponding `*Screen` file remains a small public
/// navigation/compatibility boundary. Business and data-layer behavior
/// is intentionally not introduced by this refactor.
///
/// Example:
///
/// ```dart
/// const CreateProductView()
/// ```
class CreateProductView extends StatefulWidget {
  const CreateProductView({super.key});
  @override
  State<CreateProductView> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductView> {
  bool _force = false;
  String? _skuErr, _nameEnErr, _nameArErr;

  final _categorySource = SuperAutoSuggestionSources.strings([
    'Steel',
    'Concrete',
    'Lumber',
    'Fasteners',
    'Tools',
  ]);
  final _categoryController = SuperAutoSuggestionsController<String>(
    allowFreeText: false,
  );
  final _uomSource = SuperAutoSuggestionSources.strings([
    'PCS',
    'KG',
    'TON',
    'M',
    'M²',
    'LTR',
  ]);
  final _uomController = SuperAutoSuggestionsController<String>(
    allowFreeText: false,
  );
  final _vatSource = SuperAutoSuggestionSources.strings(['0%', '5%', '15%']);
  final _vatController = SuperAutoSuggestionsController<String>(
    allowFreeText: false,
    initialValue: '15%',
  );
  final _storeSource = SuperAutoSuggestionSources.strings([
    'Downtown Central',
    'North Warehouse',
    'East Distribution',
  ]);
  final _storeController = SuperAutoSuggestionsController<String>(
    allowFreeText: false,
  );

  @override
  void dispose() {
    _categoryController.dispose();
    _uomController.dispose();
    _vatController.dispose();
    _storeController.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() => _force = true);
    if (_skuErr == null && _nameEnErr == null && _nameArErr == null) {
      // Implementation note: persist product
    }
  }

  @override
  Widget build(BuildContext context) {
    var marker = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var icon = MIcons.of('store');
    var marker2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon2 = MIcons.of('box');
    var marker3 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var icon3 = MIcons.of('swap');
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(
        title: Text(GeniusLinkLocalization.of(context).createProduct),
        actions: const [AppLanguageToggleButton(), AppThemeToggleButton()],
      ),
      body: MScroll([
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).productDefinition,
          subtitle: GeniusLinkLocalization.of(
            context,
          ).skuNamesAndClassification,
          initiallyExpanded: true,
          accentColor: marker2,
          icon: icon2,
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: SuperTextFormField(
                  decoration: InputDecoration(
                    labelText: 'SKU',
                    hintText: GeniusLinkLocalization.of(context).eGStl44021,
                  ),
                  required: true,
                  minLength: 3,
                  forceError: _force,
                  onValidity: (e) => _skuErr = e,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: SuperTextFormField(
                  decoration: InputDecoration(
                    labelText: GeniusLinkLocalization.of(context).barcode,
                    hintText: GeniusLinkLocalization.of(context).scanOrType,
                    prefixIcon: Icon(Icons.qr_code_scanner_rounded, size: 18),
                  ),
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: SuperTextFormField(
                  decoration: InputDecoration(
                    labelText: GeniusLinkLocalization.of(context).nameEnglish,
                    hintText: GeniusLinkLocalization.of(
                      context,
                    ).eGStructuralSteelIBeam,
                  ),
                  required: true,
                  minLength: 2,
                  forceError: _force,
                  onValidity: (e) => _nameEnErr = e,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: SuperTextFormField(
                  decoration: InputDecoration(
                    labelText: GeniusLinkLocalization.of(context).nameArabic,
                    hintText: GeniusLinkLocalization.of(
                      context,
                    ).eGStructuralSteelIBeam,
                  ),
                  arabic: true,
                  required: true,
                  minLength: 2,
                  forceError: _force,
                  onValidity: (e) => _nameArErr = e,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: SuperAutoSuggestionsBox<String>(
                  suggestionBuilder: (context, items, index, item) =>
                      SuperAutoSuggestionsItem<String>(
                        value: item,
                        titleText: item,
                      ),
                  source: _categorySource,
                  controller: _categoryController,
                  decoration: InputDecoration(
                    labelText: GeniusLinkLocalization.of(context).category,
                  ),
                  hintText: GeniusLinkLocalization.of(context).selectCategory,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: SuperAutoSuggestionsBox<String>(
                  suggestionBuilder: (context, items, index, item) =>
                      SuperAutoSuggestionsItem<String>(
                        value: item,
                        titleText: item,
                      ),
                  source: _uomSource,
                  controller: _uomController,
                  decoration: InputDecoration(
                    labelText: GeniusLinkLocalization.of(context).unitOfMeasure,
                  ),
                  hintText: GeniusLinkLocalization.of(context).selectUnit,
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).costingPricing,

          initiallyExpanded: true,
          accentColor: marker3,
          icon: icon3,
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: SuperNumericFormField(
                  decoration: InputDecoration(
                    labelText: GeniusLinkLocalization.of(context).unitCostSar,
                    prefixText: 'SAR ',
                  ),
                  decimals: 2,
                  min: 0,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: SuperNumericFormField(
                  decoration: InputDecoration(
                    labelText: GeniusLinkLocalization.of(
                      context,
                    ).sellingPriceSar,
                    prefixText: 'SAR ',
                  ),
                  decimals: 2,
                  min: 0,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: SuperAutoSuggestionsBox<String>(
                  suggestionBuilder: (context, items, index, item) =>
                      SuperAutoSuggestionsItem<String>(
                        value: item,
                        titleText: item,
                      ),
                  source: _vatSource,
                  controller: _vatController,
                  decoration: InputDecoration(
                    labelText: GeniusLinkLocalization.of(context).vatRate,
                  ),
                  hintText: GeniusLinkLocalization.of(context).selectRate,
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).inventorySettings,

          initiallyExpanded: true,
          accentColor: marker,
          icon: icon,
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: SuperNumericFormField(
                  decoration: InputDecoration(
                    labelText: GeniusLinkLocalization.of(context).reorderLevel,
                  ),
                  min: 0,
                  step: 1,
                  decimals: 0,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: SuperAutoSuggestionsBox<String>(
                  suggestionBuilder: (context, items, index, item) =>
                      SuperAutoSuggestionsItem<String>(
                        value: item,
                        titleText: item,
                      ),
                  source: _storeSource,
                  controller: _storeController,
                  decoration: InputDecoration(
                    labelText: GeniusLinkLocalization.of(context).defaultStore,
                  ),
                  hintText: GeniusLinkLocalization.of(context).selectStore,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: SuperNumericFormField(
                  decoration: InputDecoration(
                    labelText: GeniusLinkLocalization.of(context).openingStock,
                  ),
                  min: 0,
                  step: 1,
                  decimals: 0,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 6,
                large: 6,
                child: SuperAttachmentFormField(
                  decoration: InputDecoration(
                    labelText: GeniusLinkLocalization.of(context).productImages,
                  ),
                  accept: '.jpg,.jpeg,.png,.pdf',
                  maxSizeMB: 10,
                  maxFiles: 5,
                  multiple: true,
                  onBrowse: () async => const <SuperFile>[],
                ),
              ),
            ],
          ),
        ),
        ActionRow(primary: 'Create Product', onPrimary: _submit),
      ]),
    );
  }
}
