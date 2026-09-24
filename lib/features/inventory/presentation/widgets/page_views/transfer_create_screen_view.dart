// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
import 'package:flutter/material.dart';
import 'package:super_form_field/super_form_field.dart';
import '../../../../../design_system/kit.dart';
import '../../../domain/domain.dart';
import '../../controllers/inventory_line_form_controller.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

/// Renders the presentation for [TransferCreateScreen].
///
/// This widget contains the screen's existing layout and presentation
/// state while the corresponding `*Screen` file remains a small public
/// navigation/compatibility boundary. Business and data-layer behavior
/// is intentionally not introduced by this refactor.
///
/// Example:
///
/// ```dart
/// const TransferCreateView()
/// ```
class TransferCreateView extends StatefulWidget {
  final Future<void> Function(List<InventoryLine> lines)? onSubmit;

  const TransferCreateView({this.onSubmit, super.key});
  @override
  State<TransferCreateView> createState() => _TransferCreateScreenState();
}

class _TransferCreateScreenState extends State<TransferCreateView> {
  final _fromSource = SuperAutoSuggestionSources.strings([
    'Downtown Central',
    'North Warehouse',
    'East Distribution',
  ]);
  final _fromController = SuperAutoSuggestionsController<String>(
    allowFreeText: false,
  );
  final _toSource = SuperAutoSuggestionSources.strings([
    'North Warehouse',
    'Downtown Central',
    'East Distribution',
  ]);
  final _toController = SuperAutoSuggestionsController<String>(
    allowFreeText: false,
  );
  final _currencySource = SuperAutoSuggestionSources.strings([
    'SAR — Saudi Riyal',
    'USD — US Dollar',
    'EUR — Euro',
  ]);
  final _currencyController = SuperAutoSuggestionsController<String>(
    allowFreeText: false,
  );
  final _lines = <InventoryLineFormController>[];

  @override
  void dispose() {
    for (final l in _lines) {
      l.dispose();
    }
    _fromController.dispose();
    _toController.dispose();
    _currencyController.dispose();
    super.dispose();
  }

  void _addLine(String raw) {
    final parts = raw.split(' — ');
    final sku = parts.isNotEmpty ? parts[0] : raw;
    final name = parts.length > 1 ? parts[1] : raw;
    setState(
      () => _lines.insert(
        0,
        InventoryLineFormController(InventoryLine(sku: sku, name: name)),
      ),
    );
  }

  Future<void> _submit() async {
    await widget.onSubmit?.call(
      _lines.map((line) => line.value).toList(growable: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    var marker = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var icon = MIcons.of('doc');
    var marker2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon2 = MIcons.of('cart');
    var marker3 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon3 = MIcons.of('box');
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(
        title: Text(GeniusLinkLocalization.of(context).transferInventory),
        actions: const [AppLanguageToggleButton(), AppThemeToggleButton()],
      ),
      body: MScroll([
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).transferDetails,

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
                child: SuperTextFormField(
                  decoration: InputDecoration(
                    labelText: GeniusLinkLocalization.of(context).serialNo,
                  ),
                  initialValue: 'INV-TRF-2024-0117',
                  readOnly: true,
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
                  source: _currencySource,
                  controller: _currencyController,
                  decoration: InputDecoration(
                    labelText: GeniusLinkLocalization.of(context).currency,
                  ),
                  hintText: GeniusLinkLocalization.of(context).selectCurrency,
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
                  source: _fromSource,
                  controller: _fromController,
                  decoration: InputDecoration(labelText: 'From Store'),
                  hintText: GeniusLinkLocalization.of(
                    context,
                  ).searchOriginWarehouse,
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
                  source: _toSource,
                  controller: _toController,
                  decoration: InputDecoration(
                    labelText: GeniusLinkLocalization.of(context).toStore,
                  ),
                  hintText: GeniusLinkLocalization.of(
                    context,
                  ).searchDestination,
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).products,
          subtitle: '${_lines.length} line${_lines.length == 1 ? '' : 's'}',
          initiallyExpanded: true,
          accentColor: marker2,
          icon: icon2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Scanner(onPick: _addLine),
              ..._lines.asMap().entries.map((e) {
                final i = e.key;
                final l = e.value;
                return ProductRow(
                  name: l.name,
                  sku: l.sku,
                  qtyController: l.quantityController,
                  price: '—',
                  total: '—',
                  currency: '',
                  last: i == _lines.length - 1,
                );
              }),
              const AddProductBtn(),
            ],
          ),
        ),
        SuperSectionCard2(
          title: 'Notes & Docs',

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
                child: SuperTextFormField(
                  decoration: InputDecoration(
                    labelText: GeniusLinkLocalization.of(context).notes,
                    hintText: GeniusLinkLocalization.of(
                      context,
                    ).enterTransferNotesOrInternalInstructions,
                  ),
                  multiline: true,
                  rows: 3,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 6,
                large: 6,
                child: SuperAttachmentFormField(
                  decoration: InputDecoration(
                    labelText: GeniusLinkLocalization.of(context).attachments,
                  ),
                  accept: '.pdf,.jpg,.jpeg,.png',
                  maxSizeMB: 10,
                  maxFiles: 5,
                  multiple: true,
                  onBrowse: () async => const <SuperFile>[],
                ),
              ),
            ],
          ),
        ),
        ActionRow(primary: 'Transfer Inventory', onPrimary: _submit),
      ]),
    );
  }
}
