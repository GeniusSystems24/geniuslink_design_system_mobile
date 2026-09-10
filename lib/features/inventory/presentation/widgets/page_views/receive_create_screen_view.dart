// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
import 'package:flutter/material.dart';
import 'package:super_form_field/super_form_field.dart';
import '../../../../../design_system/kit.dart';
import '../../../domain/domain.dart';
import '../../controllers/inventory_line_form_controller.dart';
import '../../pages/inventory_shared_widgets.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

class _BalancedRow extends StatelessWidget {
  final String value;
  const _BalancedRow({required this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: SuperMaterialThemeData.of(context).superTheme.borderStrong,
            width: 2,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Eyebrow(
            'Balanced · Diff 0.00',
            color: SuperMaterialThemeData.of(context).colorScheme.secondary,
            size: 11,
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: SuperMaterialThemeData.of(
                context,
              ).textTheme.bodyMedium?.fontFamily,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: SuperMaterialThemeData.of(context).superTheme.fg1,
            ),
          ),
        ],
      ),
    );
  }
}

/// Renders the presentation for [ReceiveCreateScreen].
///
/// This widget contains the screen's existing layout and presentation
/// state while the corresponding `*Screen` file remains a small public
/// navigation/compatibility boundary. Business and data-layer behavior
/// is intentionally not introduced by this refactor.
///
/// Example:
///
/// ```dart
/// const ReceiveCreateView()
/// ```
class ReceiveCreateView extends StatefulWidget {
  final Future<void> Function(List<InventoryLine> lines)? onSubmit;

  const ReceiveCreateView({this.onSubmit, super.key});
  @override
  State<ReceiveCreateView> createState() => _ReceiveCreateScreenState();
}

class _ReceiveCreateScreenState extends State<ReceiveCreateView> {
  final _storeSource = SuperAutoSuggestionSources.strings([
      'Downtown Central',
      'North Warehouse',
      'East Distribution',
    ]);
  final _storeController = SuperAutoSuggestionsController<String>(
    allowFreeText: false,
  );
  final _supplierSource = SuperAutoSuggestionSources.strings([
      'ABC Trading Co.',
      'SteelMart LLC',
      'ConcretePro Ltd.',
    ]);
  final _supplierController = SuperAutoSuggestionsController<String>(
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
    _storeController.dispose();
    _supplierController.dispose();
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
    var marker = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var icon = MIcons.of('cart');
    var marker2 = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var icon2 = MIcons.of('doc');
    var marker3 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon3 = MIcons.of('box');
    var marker4 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var icon4 = MIcons.of('swap');
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: Text(GeniusLinkLocalization.of(context).receiveInventory), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
      body: MScroll([
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).receiveDetails,

          initiallyExpanded: true,
          accentColor: marker3,
          icon: icon3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SuperTextFormField(
                decoration: InputDecoration(labelText: GeniusLinkLocalization.of(context).serialNo),
                initialValue: 'INV-REC-2024-0241',
                readOnly: true,
              ),
              SuperAutoSuggestionsBox<String>(
                suggestionBuilder: (items, index, item) => SuperAutoSuggestionsItem<String>(
                  value: item,
                  titleText: item,
                ),
                source: _currencySource,
                controller: _currencyController,
                decoration: InputDecoration(labelText: GeniusLinkLocalization.of(context).currency),
                hintText: GeniusLinkLocalization.of(context).selectCurrency,
              ),
              SuperAutoSuggestionsBox<String>(
                suggestionBuilder: (items, index, item) => SuperAutoSuggestionsItem<String>(
                  value: item,
                  titleText: item,
                ),
                source: _storeSource,
                controller: _storeController,
                decoration: InputDecoration(labelText: GeniusLinkLocalization.of(context).receivingStore),
                hintText: GeniusLinkLocalization.of(context).searchStore,
              ),
              SuperAutoSuggestionsBox<String>(
                suggestionBuilder: (items, index, item) => SuperAutoSuggestionsItem<String>(
                  value: item,
                  titleText: item,
                ),
                source: _supplierSource,
                controller: _supplierController,
                decoration: InputDecoration(labelText: GeniusLinkLocalization.of(context).supplierAccount),
                hintText: GeniusLinkLocalization.of(context).eGAbcTradingCo,
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).inventoryItems,
          subtitle:
              '${_lines.length} line${_lines.length == 1 ? '' : 's'} · received into stock',
          initiallyExpanded: true,
          accentColor: marker,
          icon: icon,
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
          title: GeniusLinkLocalization.of(context).accountingDistribution,

          initiallyExpanded: true,
          accentColor: marker4,
          icon: icon4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              DistRow(
                account: '1200 — Inventory (WIP)',
                side: 'Debit',
                amount: '+24,200.00',
                last: false,
              ),
              DistRow(
                account: '2001 — Accounts Payable',
                side: 'Credit',
                amount: '-24,200.00',
                last: true,
              ),
              _BalancedRow(value: '24,200.00'),
            ],
          ),
        ),
        SuperSectionCard2(
          title: 'Notes & Docs',

          initiallyExpanded: true,
          accentColor: marker2,
          icon: icon2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SuperTextFormField(
                decoration: InputDecoration(
                  labelText: GeniusLinkLocalization.of(context).receiptNotes,
                  hintText: GeniusLinkLocalization.of(context).poNumberDeliveryNoteInspectionResults,
                ),
                multiline: true,
                rows: 3,
              ),
              SuperAttachmentFormField(
                decoration: InputDecoration(labelText: GeniusLinkLocalization.of(context).attachments),
                accept: '.pdf,.jpg,.jpeg,.png',
                maxSizeMB: 10,
                maxFiles: 5,
                multiple: true,
                onBrowse: () async => const <SuperFile>[],
              ),
            ],
          ),
        ),
        ActionRow(primary: 'Receive Inventory', onPrimary: _submit),
      ]),
    );
  }
}
